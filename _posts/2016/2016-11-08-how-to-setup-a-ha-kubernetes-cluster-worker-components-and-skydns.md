---
layout: post
title: "How to set up a HA Kubernetes cluster: worker components and SkyDNS"
date: "2016-11-08 07:16:17"
image: blog-header/kubernetes-worker-logo.jpg
categories: tech-stories
authors: ["Karsten P."]
---

The fourth part of this blog post series deals with the worker nodes.
Due to their role it is easier to install worker nodes than master nodes.
Master nodes also need client certificates to connect to the API server.

## Certificates

Worker certificates are also created per node.
They are structured as easy as _Etcd_ client certificates.

{% highlight bash %}
root@worker:~$ mkdir -p /etc/kubernetes/ssl
root@worker:~$ cd /etc/kubernetes/ssl
root@worker:/etc/kubernetes/ssl$ cat > openssl.cnf << "EOF"
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name
[req_distinguished_name]
[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names
[alt_names]
IP.1 = $ENV::WORKER_IP
EOF
root@worker:/etc/kubernetes/ssl$ openssl genrsa -out worker.key 2048
root@worker:/etc/kubernetes/ssl$ chmod 600 worker.key
root@worker:/etc/kubernetes/ssl$ export WORKER_IP=192.168.2.[1|2|3]
root@worker:/etc/kubernetes/ssl$ openssl \
  req -new \
  -key worker.key \
  -out worker.csr \
  -subj "/CN=$(hostname -s)" \
  -extensions v3_req \
  -config openssl.cnf \
  -sha256
root@worker:/etc/kubernetes/ssl$ scp openssl.cnf worker.csr root@root-ca-host:
{% endhighlight %}

The creation is done by analogy with the certificates of the _Etcd_ clients.

{% highlight bash %}
root@root-ca-host:~$ export WORKER_IP=192.168.2.[1|2|3]
root@root-ca-host:~$ openssl x509 \
  -req \
  -CA ca.crt \
  -CAkey ca.key \
  -CAcreateserial \
  -in worker.csr \
  -out worker.crt \
  -days 365 \
  -extensions v3_req \
  -extfile openssl.cnf \
  -sha256
root@root-ca-host:~$ scp worker.crt root@worker:/etc/kubernetes/ssl
{% endhighlight %}

Since the worker nodes already got the root CA certificate (for _flanneld_) they should have the following certificates at this stage:

{% highlight bash %}
root@worker:/etc/kubernetes/ssl$ ls -la
-rw-r--r-- 1 root root 1179 Jun  1 20:54 worker.crt
-rw------- 1 root root 1675 Jun  1 20:54 worker.key
root@worker:/etc/ssl/etcd/$ ls -la
-rw-r--r--  1 root root 1418 Jun  1 16:13 ca.crt
-rw-r--r--  1 root root 1203 Jun  1 16:13 etcd-client.crt
-rw-------  1 root root 1679 Jun  1 16:12 etcd-client.key
{% endhighlight %}

## kubeconfig

Now the _YAML_ file is created which will be used by _kubelet_ and _kube-proxy_.
It determines where the previously created certificates are located.

{% highlight bash %}
root@worker:~$ cat > /etc/kubernetes/worker-kubeconfig.yaml << EOF
apiVersion: v1
kind: Config
clusters:
- name: local
  cluster:
    certificate-authority: /etc/ssl/etcd/ca.crt
users:
- name: kubelet
  user:
    client-certificate: /etc/kubernetes/ssl/worker.crt
    client-key: /etc/kubernetes/ssl/worker.key
contexts:
- context:
    cluster: local
    user: kubelet
  name: kubelet-context
current-context: kubelet-context
EOF
{% endhighlight %}

## Kubelet

_kubelet_ too is running on the worker nodes.
The configuration is different to the one of the master nodes.
Yet, the installation is done in the same way as described in [the second part of this blog post series](https://developer.epages.com/blog/2016/09/08/kubernetes-preparing-nodes.html).

{% highlight bash %}
root@worker:~$ cat > /etc/systemd/system/kubelet.service << EOF
[Unit]
Description=The primary agent to run pods
Documentation=http://kubernetes.io/docs/admin/kubelet/
Requires=networking.service
After=docker.service

[Service]
ExecStart=/usr/local/bin/kubelet \\
  --api-servers=https://loadbalancer.example.com \\
  --register-node=true \\
  --register-schedulable=true \\
  --allow-privileged=true \\
  --config=/etc/kubernetes/manifests \\
  --cluster-dns=10.3.0.2 \\
  --cluster-domain=cluster.local \\
  --kubeconfig=/etc/kubernetes/worker-kubeconfig.yaml \\
  --tls-cert-file=/etc/kubernetes/ssl/worker.crt \\
  --tls-private-key-file=/etc/kubernetes/ssl/worker.key \\
  --housekeeping-interval=60s
Restart=always
RestartSec=10
[Install]
WantedBy=multi-user.target
EOF
root@worker:~$ systemctl enable kubelet
{% endhighlight %}

As described in [the setup of the master components](https://developer.epages.com/blog/2016/10/18/kubernetes-master-components.html) _kubelet_ and _kube-proxy_ are affected by [an error](https://github.com/kubernetes/kubernetes/issues/18174).
Therefore, we do not insert a comma separated list of API servers but only the load balancer's URL in the parameter _api-servers_.
Unlike the master nodes, on the worker nodes shall run the real application pods.
As a consequence, _kubelet_ registers its own node within the API as "schedulable".

## Kube-proxy

The load balancer's URL is also registered in the pod definition of the service _kube-proxy_ of the worker nodes.

{% highlight bash %}
root@worker:~$ cat > /etc/kubernetes/manifests/kube-proxy << EOF
apiVersion: v1
kind: Pod
metadata:
  name: kube-proxy
  namespace: kube-system
spec:
  hostNetwork: true
  containers:
  - name: kube-proxy
    image: quay.io/coreos/hyperkube:v1.2.2_coreos.0
    command:
    - /hyperkube
    - proxy
    - --master=https://loadbalancer.example.com
    - --kubeconfig=/etc/kubernetes/worker-kubeconfig.yaml
    - --proxy-mode=iptables
    securityContext:
      privileged: true
    volumeMounts:
      - mountPath: /etc/ssl/certs
        name: "ssl-certs"
      - mountPath: /etc/kubernetes/worker-kubeconfig.yaml
        name: "kubeconfig"
        readOnly: true
      - mountPath: /etc/kubernetes/ssl
        name: "etc-kube-ssl"
        readOnly: true
      - mountPath: /etc/ssl/etcd
        name: "etcd-kube-ca"
        readOnly: true
  volumes:
    - name: "ssl-certs"
      hostPath:
        path: "/usr/share/ca-certificates"
    - name: "kubeconfig"
      hostPath:
        path: "/etc/kubernetes/worker-kubeconfig.yaml"
    - name: "etc-kube-ssl"
      hostPath:
        path: "/etc/kubernetes/ssl"
    - name: "etcd-kube-ca"
      hostPath:
        path: "/etc/ssl/etcd"
EOF
{% endhighlight %}

At this place we see a vulnerability of the HA cluster.
Normally, the load balancer has to be failure-resistant too, because it is the only connection from the worker to the master nodes.
But since this would go beyond the constraints of this article, we simply refer to [this older documentation](https://www.howtoforge.com/setting-up-a-high-availability-load-balancer-with-haproxy-keepalived-on-debian-lenny).
Now, that the _kube-proxy_ pod is created, the worker nodes are ready for operation.
Based on _flanneld_ and the _docker engine_, _kubelet_ is started with the following command:

{% highlight bash %}
root@worker:~$ systemctl start kubelet
{% endhighlight %}

Analogous to the master nodes, _kubelet_ now starts transferring the pod definitions from _/etc/kubernetes/manifests_ into containers.

{% highlight bash %}
root@worker:~$ docker ps
ID  IMAGE             COMMAND                  CREATED              STATUS              NAMES
b9  v1.2.2_coreos.0   "/hyperkube proxy --m"   About a minute ago   Up About a minute   kube-proxy
16  pause:2.0         "/pause"                 2 minutes ago        Up About a minute   POD
{% endhighlight %}

## kubectl

[kubectl](http://kubernetes.io/docs/user-guide/kubectl-overview/) is the administration tool for the cluster.
It is running on your local computer and interacts via Kubernetes API with the cluster.
Among others, it enables you to create new pods using YAML files on your local machine.
Note that YAML files on the Kubernetes nodes (so called "static pods") cannot be administrated via _kebectl_.
The _kubectl_ communication is TLS encrypted.
The API certificate is created in an accustomed manner (see prior worker certificates).

{% highlight bash %}
user@workstation:~$ mkdir -p ~/.kube
user@workstation:~$ cd ~/.kube
user@workstation:.kube$ openssl genrsa -out kubectl.key 2048
user@workstation:.kube$ chmod 600 kubectl.key
user@workstation:.kube$ openssl req \
  -nodes \
  -key kubectl.key \
  -out kubectl.csr \
  -subj "/CN=kubectl" \
  -sha256
{% endhighlight %}

The cluster's root CA is copied to the folder _~/.kube_ as _ca.crt_.
After that _kubectl_ is configured.

{% highlight bash %}
user@workstation:.kube$ kubectl config set-cluster default-cluster \
--server=https://loadbalancer.example.com \
--certificate-authority=ca.crt
user@workstation:.kube$ kubectl config set-credentials default-admin \
--certificate-authority=ca.crt \
--client-certificate=kubectl.crt \
--client-key=kubectl.key
user@workstation:.kube$ kubectl config set-context default-system \
--cluster=default-cluster \
--user=default-admin
user@workstation:.kube$ kubectl config use-context default-system
{% endhighlight %}

With the following command, the correct way of functioning can be tested.

{% highlight bash %}
user@workstation:~$ kubectl get nodes
NAME       STATUS                    AGE
master01   Ready,SchedulingDisabled  1h
master02   Ready,SchedulingDisabled  1h
worker01   Ready                     1h
worker02   Ready                     1h
worker03   Ready                     1h
{% endhighlight %}

## SkyDNS

Now that the cluster is set up, we can install the cluster DNS.
We use the add-on [SkyDNS](https://github.com/kubernetes/kubernetes/tree/v1.2.2/cluster/addons/dns).
This way an application within the cluster DNS name can use Kubernetes services.
This pod runs on one of the worker nodes.
So _SkyDNS_ is the first application on the new cluster (represented by a [Replication Controller](http://kubernetes.io/docs/user-guide/replication-controller/)).
In addition, _SkyDNS_ needs another Kubernetes object: the [Service](http://kubernetes.io/docs/user-guide/services/).
The example demonstrates the creation of both objects directly on the shell of _kubectl_.
But of course they can be created via YAML files, too.

{% highlight bash %}
user@workstation:~$ cat <<EOF | kubectl create -f -
apiVersion: v1
kind: ReplicationController
metadata:
  name: kube-dns-v11
  namespace: kube-system
  labels:
    k8s-app: kube-dns
    version: v11
    kubernetes.io/cluster-service: "true"
spec:
  replicas: 1
  selector:
    k8s-app: kube-dns
    version: v11
  template:
    metadata:
      labels:
        k8s-app: kube-dns
        version: v11
        kubernetes.io/cluster-service: "true"
    spec:
      containers:
      - name: etcd
        image: gcr.io/google_containers/etcd-amd64:2.2.1
        resources:
          # TODO: Set memory limits when we've profiled the container for large
          # clusters, then set request = limit to keep this container in
          # guaranteed class. Currently, this container falls into the
          # "burstable" category so the kubelet doesn't backoff from restarting it.
          limits:
            cpu: 100m
            memory: 500Mi
          requests:
            cpu: 100m
            memory: 50Mi
        command:
        - /usr/local/bin/etcd
        - -data-dir
        - /var/etcd/data
        - -listen-client-urls
        - http://127.0.0.1:2379,http://127.0.0.1:4001
        - -advertise-client-urls
        - http://127.0.0.1:2379,http://127.0.0.1:4001
        - -initial-cluster-token
        - skydns-etcd
        volumeMounts:
        - name: etcd-storage
          mountPath: /var/etcd/data
      - name: kube2sky
        image: gcr.io/google_containers/kube2sky:1.14
        resources:
          # TODO: Set memory limits when we've profiled the container for large
          # clusters, then set request = limit to keep this container in
          # guaranteed class. Currently, this container falls into the
          # "burstable" category so the kubelet doesn't backoff from restarting it.
          limits:
            cpu: 100m
            # Kube2sky watches all pods.
            memory: 200Mi
          requests:
            cpu: 100m
            memory: 50Mi
        livenessProbe:
          httpGet:
            path: /healthz
            port: 8080
            scheme: HTTP
          initialDelaySeconds: 60
          timeoutSeconds: 5
          successThreshold: 1
          failureThreshold: 5
        readinessProbe:
          httpGet:
            path: /readiness
            port: 8081
            scheme: HTTP
          # we poll on pod startup for the Kubernetes master service and
          # only setup the /readiness HTTP server once that's available.
          initialDelaySeconds: 30
          timeoutSeconds: 5
        args:
        # command = "/kube2sky"
        - --domain=cluster.local
      - name: skydns
        image: gcr.io/google_containers/skydns:2015-10-13-8c72f8c
        resources:
          # TODO: Set memory limits when we've profiled the container for large
          # clusters, then set request = limit to keep this container in
          # guaranteed class. Currently, this container falls into the
          # "burstable" category so the kubelet doesn't backoff from restarting it.
          limits:
            cpu: 100m
            memory: 200Mi
          requests:
            cpu: 100m
            memory: 50Mi
        args:
        # command = "/skydns"
        - -machines=http://127.0.0.1:4001
        - -addr=0.0.0.0:53
        - -ns-rotate=false
        - -domain=cluster.local.
        ports:
        - containerPort: 53
          name: dns
          protocol: UDP
        - containerPort: 53
          name: dns-tcp
          protocol: TCP
      - name: healthz
        image: gcr.io/google_containers/exechealthz:1.0
        resources:
          # keep request = limit to keep this container in guaranteed class
          limits:
            cpu: 10m
            memory: 20Mi
          requests:
            cpu: 10m
            memory: 20Mi
        args:
        - -cmd=nslookup kubernetes.default.svc.cluster.local 127.0.0.1 >/dev/null
        - -port=8080
        ports:
        - containerPort: 8080
          protocol: TCP
      volumes:
      - name: etcd-storage
        emptyDir: {}
      dnsPolicy: Default  # Don't use cluster DNS.
EOF
{% endhighlight %}
{% highlight bash %}
user@workstation:~$ cat <<EOF | kubectl create -f -
apiVersion: v1
kind: Service
metadata:
  name: kube-dns
  namespace: kube-system
  labels:
    k8s-app: kube-dns
    kubernetes.io/cluster-service: "true"
    kubernetes.io/name: "KubeDNS"
spec:
  selector:
    k8s-app: kube-dns
  clusterIP: 10.3.0.2
  ports:
  - name: dns
    port: 53
    protocol: UDP
  - name: dns-tcp
    port: 53
    protocol: TCP
EOF
{% endhighlight %}

The code shows that the _cluster-dns_ IP entered in _kubelet_ is implemented in the DNS service.
Other applications from different namespaces can use the corresponding services simply by calling the service name.
SkyDNS is permanently looking for new services within the API and creates new entries in the _Etcd_ storage.
For the communication with the API it uses a [secret](http://kubernetes.io/docs/user-guide/secrets/).
This secret is provided via the secured connections of all cluster components.

## Summary

The installation of worker nodes also requires certificates to authenticate against the Kubernetes API.
To distribute the worker connections to both master nodes we use the load balancer.
This workaround is necessary, because there is an implementation error in _kube-proxy_.
The downside of this solution is the fact that the load balancer is not failure-resistant.

## Outlook

In order to reduce the risk of a cluster outage a considerable monitor environment of all nodes should be established.
Consequently, problems can be found as early as possible.
For this purpose Kubernetes provides additional add-ons.
[Fluentd, combined with Elasticsearch and Kibana](https://github.com/kubernetes/kubernetes/tree/v1.2.2/cluster/addons/fluentd-elasticsearch), as well as [Heapster, with Influxdb and Grafana](https://github.com/kubernetes/kubernetes/tree/v1.2.2/cluster/addons/cluster-monitoring/influxdb), offer the possibility to analyze log files and the utilization of nodes.

## Additional links

[CoreOS Kubernetes guide](https://coreos.com/kubernetes/docs/1.2.2)
[Kubernetes on GitHub](https://github.com/kubernetes/kubernetes)

# Related posts

* [How to set up a HA Kubernetes cluster: etcd cluster with SSL](https://developer.epages.com/blog/2016/08/09/how-to-setup-a-ha-kubernetes-cluster-etcd-cluster-with-ssl.html)
* [How to set up a HA Kubernetes cluster: preparing the nodes](https://developer.epages.com/blog/2016/09/08/how-to-setup-a-ha-kubernetes-cluster-preparing-the-nodes.html)
* [How to set up a HA Kubernetes cluster: master components](https://developer.epages.com/blog/2016/10/18/how-to-setup-a-kubernetes-cluster-master-components.html)
