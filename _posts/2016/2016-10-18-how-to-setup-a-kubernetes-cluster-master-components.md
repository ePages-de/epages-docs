---
layout: post
title: "How to set up a HA Kubernetes cluster: master components"
date: "2016-10-18 07:16:17"
image: blog-header/kubernetes-master-logo.jpg
categories: tech-stories
authors: ["Karsten P."]
---

The third part of this blog post series deals with master nodes and its components.
Among others we will have a look at the characteristics of an API server in an HA setup.

## Systemd service definition

Since [kubelet is already installed on all kubernetes nodes](https://developer.epages.com/blog/2016/09/08/kubernetes-preparing-nodes.html) we continue with the service definition on the master nodes.
For the communication with the API server the local port _8080_ is used on the master nodes:

{% highlight bash %}
root@master:~$ cat > /etc/systemd/system/kubelet.service << EOF
[Unit]
Description=The primary agent to run pods
Documentation=http://kubernetes.io/docs/admin/kubelet/
Requires=networking.service
After=docker.service

[Service]
ExecStart=/usr/local/bin/kubelet \\
  --api-servers=http://127.0.0.1:8080 \\
  --register-schedulable=false \\
  --register-node=true \\
  --allow-privileged=true \\
  --config=/etc/kubernetes/manifests \\
  --cluster-dns=10.3.0.2 \\
  --cluster-domain=cluster.local \\
  --housekeeping-interval=60s
Restart=always
RestartSec=10
[Install]
WantedBy=multi-user.target
EOF
root@master:~$ systemctl enable kubelet # Only enable service NO start!
{% endhighlight %}

Here we are facing a problem.
Kubelet needs the API server in order to register the node status in the cluster.
But the API server is started by kubelet.
This means kubelet does not work correctly until it reaches its local API server.
So kubelet runs an endless loop while starting in order to reach the API server.

## API server

### Certificates

The API server needs a server certificate like the *etcd* nodes.
This certificate has to be accepted by clients that access via the load balancer.
Therefore, it needs IP addresses and FQDN's of both API servers and the load balancer.
In addition, the DNS entries for the API Url (_kubernetes_ and _kubernetes.default_) will be inserted.

In contrary to all other certificates the one for the API server is created only on one master node and will be copied to the second one later on.
The reason for this is the creation and validation of the [API token](http://kubernetes.io/docs/user-guide/accessing-the-cluster/#accessing-the-api-from-a-pod) which is created with the key of the API server.
A [bearer token](https://tools.ietf.org/html/rfc6750) which is required for authorization against the kubernetes API is provided for each application within a container by using a file.
This token is created by the primary [kube controller manager](http://kubernetes.io/docs/admin/kube-controller-manager/) with the API server key.
When an application sends a request to the API it is "load balanced" to one of the master nodes.
But the master node can only accept the request if the tokens' key is correct.
By copying the certificate as well as the keys both master nodes are now able to validate encrypted connections with the token.

{% highlight bash %}
root@master01:~$ mkdir -p /etc/kubernetes/ssl
root@master01:~$ cd /etc/kubernetes/ssl
root@master01:/etc/kubernetes/ssl$ cat > openssl.cnf <<EOF
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name
[req_distinguished_name]
[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = localhost
DNS.2 = kubernetes
DNS.3 = kubernetes.default
DNS.4 = loadbalancer.example.com
DNS.6 = master01.example.com
DNS.7 = master02.example.com
IP.1 = 127.0.0.1
IP.2 = 10.3.0.1
IP.3 = 192.168.3.1
IP.4 = 192.168.1.1
IP.5 = 192.168.1.2
EOF
root@master01:/etc/kubernetes/ssl$ openssl genrsa -out apiserver.key 2048
root@master01:/etc/kubernetes/ssl$ chmod 600 apiserver.key
root@master01:/etc/kubernetes/ssl$ openssl \
  req -new \
  -key apiserver.key \
  -out apiserver.csr \
  -subj "/CN=kube-apiserver" \
  -extensions v3_req \
  -config openssl.cnf \
  -sha256
{% endhighlight %}

The certificate of the Root CA has to be added to the one of the API server just as it was done with the *etcd* peer certificate.

{% highlight bash %}
root@master01:/etc/kubernetes/ssl$ scp openssl.cnf apiserver.csr root@root-ca-host:
{% endhighlight %}

{% highlight bash %}
root@root-ca-host:~$ openssl x509 \
  -req \
  -CA ca.crt \
  -CAkey ca.key \
  -CAcreateserial \
  -in apiserver.csr \
  -out apiserver.crt \
  -days 365 \
  -extensions v3_req \
  -extfile openssl.cnf \
  -sha256
root@root-ca-host:~$ cat ca.crt >> apiserver.crt
root@root-ca-host:~$ scp apiserver.crt ca.crt root@master01:/etc/kubernetes/ssl
{% endhighlight %}

{% highlight bash %}
root@master01:~$ cd /etc/kubernetes/ssl
root@master01:/etc/kubernetes/ssl$ rm -f openssl.cnf apiserver.csr
root@master01:/etc/kubernetes/ssl$ ls -la
-rw-r--r--  1 root root 4712 Jun  33 08:15 apiserver.crt
-rw-------  1 root root 4713 Jun  33 08:15 apiserver.key
-rw-r--r--  1 root root 4711 Jun  33 08:15 ca.crt
{% endhighlight %}

Afterwards, the files (_apiserver.crt_, _apiserver.key_, _ca.crt_) are copied to the same position with identical rights on the master02 node.

{% highlight bash %}
root@master01:/etc/kubernetes/ssl$ scp apiserver.key apiserver.crt ca.crt root@master02:/etc/kubernetes/ssl/
{% endhighlight %}

### Pod

Now the YAML file that describes the API server can be created on both master nodes.
Here we use an image of [quay.io](https://quay.io/).

{% highlight bash %}
root@master:~$ cat > /etc/kubernetes/manifests/kube-apiserver << EOF
apiVersion: v1
kind: Pod
metadata:
  name: kube-apiserver
  namespace: kube-system
spec:
  hostNetwork: true
  containers:
  - name: kube-apiserver
    image: quay.io/coreos/hyperkube:v1.2.2_coreos.0
    command:
    - /hyperkube
    - apiserver
    - --bind-address=0.0.0.0
    - --etcd-servers=https://192.168.0.1:2379,https://192.168.0.2:2379,https://192.168.0.3:2379
    - --etcd-cafile=/etc/ssl/etcd/ca.crt
    - --etcd-certfile=/etc/ssl/etcd/etcd-client.crt
    - --etcd-keyfile=/etc/ssl/etcd/etcd-client.key
    - --allow-privileged=true
    - --service-cluster-ip-range=10.3.0.0/24
    - --secure-port=443
    - --advertise-address=192.168.3.1
    - --admission-control=NamespaceLifecycle,NamespaceExists,LimitRanger,SecurityContextDeny,ServiceAccount,ResourceQuota
    - --tls-cert-file=/etc/kubernetes/ssl/apiserver.crt
    - --tls-private-key-file=/etc/kubernetes/ssl/apiserver.key
    - --client-ca-file=/etc/ssl/etcd/ca.crt
    - --service-account-key-file=/etc/kubernetes/ssl/apiserver.key
    - --apiserver-count=2
    ports:
    - containerPort: 443
      hostPort: 443
      name: https
    - containerPort: 8080
      hostPort: 8080
      name: local
    volumeMounts:
    - mountPath: /etc/kubernetes/ssl
      name: ssl-certs-kubernetes
      readOnly: true
    - mountPath: /etc/ssl/certs
      name: ssl-certs-host
      readOnly: true
    - mountPath: /etc/ssl/etcd
      name: ssl-certs-etcd
      readOnly: true
  volumes:
  - hostPath:
      path: /etc/kubernetes/ssl
    name: ssl-certs-kubernetes
  - hostPath:
      path: /usr/share/ca-certificates
    name: ssl-certs-host
  - hostPath:
      path: /etc/ssl/etcd
    name: ssl-certs-etcd
EOF
{% endhighlight %}

The options used for the pod show some specific features.
_service-cluster-ip-range_ represents the net which is used cluster-wide for the containers.
The first IP, 10.3.0.1, is the IP of the _kubernetes.default_ service.
The second IP, 10.3.0.2, will be used for the cluster DNS service.
It is part of the kubelet service definition already.
The IP of the loadbalancer is used as _advertise-address_.
The reason is an [error](https://github.com/kubernetes/kubernetes/issues/18174) in the [kube proxies](http://kubernetes.io/docs/admin/kube-proxy/) and kubelet.
Due to this error only the first entry of a list of API server Url's would be used.
Using the loadbalancer's IP as _advertise-address_ causes _kube proxy_ to use static [IPtables](https://www.netfilter.org/) rules with this IP.
So the packages will be distributed by the loadbalancer.

## Kube controller manager

The _kube controller manager_ pod is created with the option _service-account-private-key-file_ to forward the key of the API server.

{% highlight bash %}
root@master:~$ cat > /etc/kubernetes/manifests/kube-controller-manager << EOF
apiVersion: v1
kind: Pod
metadata:
  name: kube-controller-manager
  namespace: kube-system
spec:
  hostNetwork: true
  containers:
  - name: kube-controller-manager
    image: quay.io/coreos/hyperkube:v1.2.2_coreos.0
    command:
    - /hyperkube
    - controller-manager
    - --master=http://127.0.0.1:8080
    - --leader-elect=true
    - --service-account-private-key-file=/etc/kubernetes/ssl/apiserver.key
    - --root-ca-file=/etc/ssl/etcd/ca.crt
    livenessProbe:
      httpGet:
        host: 127.0.0.1
        path: /healthz
        port: 10252
      initialDelaySeconds: 15
      timeoutSeconds: 1
    volumeMounts:
    - mountPath: /etc/kubernetes/ssl
      name: ssl-certs-kubernetes
      readOnly: true
    - mountPath: /etc/ssl/certs
      name: ssl-certs-host
      readOnly: true
    - mountPath: /etc/ssl/etcd
      name: ssl-certs-etcd
      readOnly: true
  volumes:
  - hostPath:
      path: /etc/kubernetes/ssl
    name: ssl-certs-kubernetes
  - hostPath:
      path: /usr/share/ca-certificates
    name: ssl-certs-host
  - hostPath:
      path: /etc/ssl/etcd
    name: ssl-certs-etcd
EOF
{% endhighlight %}

## Kube proxy pod of the master nodes

The _kube proxy_ pod of the master nodes uses the local network interface (127.0.0.1) of the API servers for internal communication.

{% highlight bash %}
root@master:~$ cat > /etc/kubernetes/manifests/kube-proxy << EOF
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
    - --master=http://127.0.0.1:8080
    - --proxy-mode=iptables
    securityContext:
      privileged: true
    volumeMounts:
    - mountPath: /etc/ssl/certs
      name: ssl-certs-host
      readOnly: true
  volumes:
  - hostPath:
      path: /usr/share/ca-certificates
    name: ssl-certs-host
EOF
{% endhighlight %}

## Kube scheduler

Finally, the [kube scheduler](http://kubernetes.io/docs/admin/kube-scheduler/) pod is defined.
There are no specialities here.

{% highlight bash %}
root@master:~$ cat > /etc/kubernetes/manifests/kube-scheduler << EOF
apiVersion: v1
kind: Pod
metadata:
  name: kube-scheduler
  namespace: kube-system
spec:
  hostNetwork: true
  containers:
  - name: kube-scheduler
    image: quay.io/coreos/hyperkube:v1.2.2_coreos.0
    command:
    - /hyperkube
    - scheduler
    - --master=http://127.0.0.1:8080
    - --leader-elect=true
    livenessProbe:
      httpGet:
        host: 127.0.0.1
        path: /healthz
        port: 10251
      initialDelaySeconds: 15
      timeoutSeconds: 1
EOF
{% endhighlight %}

## Putting the master nodes into operation

_kubelet_ is put into operation by simply using the following command:

{% highlight bash %}
root@master:~$ systemctl start kubelet
{% endhighlight %}

This may last several minutes because at this stage the master nodes download the images.
Afterwards, the list of containers is similar to the following one (output shortened):

{% highlight bash %}
root@master:~$ docker ps
ID  IMAGE             COMMAND                  CREATED              STATUS              NAMES
b7  v1.2.2_coreos.0   "/hyperkube proxy --m"   24 seconds ago       Up 23 seconds       kube-proxy
e6  v1.2.2_coreos.0   "/hyperkube controlle"   26 seconds ago       Up 25 seconds       kube-controller-manager
03  v1.2.2_coreos.0   "/hyperkube scheduler"   28 seconds ago       Up 27 seconds       kube-scheduler
3f  v1.2.2_coreos.0   "/hyperkube apiserver"   30 seconds ago       Up 28 seconds       kube-apiserver
02  /pause:2.0        "/pause"                 About a minute ago   Up About a minute   POD
22  /pause:2.0        "/pause"                 About a minute ago   Up About a minute   POD
79  /pause:2.0        "/pause"                 About a minute ago   Up About a minute   POD
18  /pause:2.0        "/pause"                 About a minute ago   Up About a minute   POD
{% endhighlight %}

But the log files still contain errors.
The containers are registered in the [namespace](http://kubernetes.io/docs/user-guide/namespaces/) _kube-system_.
The namespace does not exist by default, but has to be created on __only one__ of the master nodes.

{% highlight bash %}
root@master01:~$ curl -X POST -H "Content-Type: application/json" -d '{"apiVersion":"v1","kind":"Namespace","metadata":{"name":"kube-system"}}' http://127.0.0.1:8080/api/v1/namespaces
{
  "kind": "Namespace",
  "apiVersion": "v1",
  "metadata": {
    "name": "kube-system",
    "selfLink": "/api/v1/namespaces/kube-system",
    "uid": "6f5480d5-1234-567a5-a099-005085675353",
    "resourceVersion": "88",
    "creationTimestamp": "2042-42-42T42:42:42Z"
  },
  "spec": {
    "finalizers": [
      "kubernetes"
    ]
  },
  "status": {
    "phase": "Active"
  }
}
{% endhighlight %}

## Summary

_kubelet_ and the API server work closely together.
This requires a precise arrangement of services and pods.
The HA setup comes along with additional specialities that influence the worker nodes.
The usage of the loadbalancer's IP in the option _advertise-address_ of the API server pods circumvents an error in _kubernetes_ version 1.2.2.
Additional pods are based on the API server and can be easily set up.
Once the namespace _kube-system_ is created (after the start of the API server) the master nodes are ready to receive requests from the worker nodes.

# Related posts

* [How to set up a HA Kubernetes cluster: etcd cluster with SSL](https://developer.epages.com/blog/2016/08/09/how-to-setup-a-ha-kubernetes-cluster-etcd-cluster-with-ssl.html)
* [How to set up a HA Kubernetes cluster: preparing the nodes](https://developer.epages.com/blog/2016/09/08/how-to-setup-a-ha-kubernetes-cluster-preparing-the-nodes.html)
