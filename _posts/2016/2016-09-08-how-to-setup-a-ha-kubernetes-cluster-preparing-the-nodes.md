---
layout: post
title: "How to set up a HA Kubernetes cluster: preparing the nodes"
date: "2016-09-08 07:16:17"
image: blog-header/kubernetes-docker-flanneld-logo.jpg
categories: tech-stories
authors: ["Karsten P."]
---

The second part of this blog post series deals with the preparation of the Kubernetes and service nodes.
It describes the installation of the HAProxy, the Flannel daemon (flanneld), the docker engine (docker) and kubelet.

## Installing the service node

The service node which is located outside the cluster undertakes the task of a load balancer.
Since the open source version of nginx does not support TCP load balancing we use [HAProxy](http://www.haproxy.org/).
HAProxy distributes packages between the hosts on the [transport layer](https://en.wikipedia.org/wiki/Transport_layer) of the [OSI reference model](https://en.wikipedia.org/wiki/OSI_model).
The following configuration is set up after the [Installation of HAProxy](https://haproxy.debian.net/).

{% highlight bash %}
root@service:~$ cat > /etc/haproxy/haproxy.cfg << EOF
global
    log         127.0.0.1 local2

    chroot      /var/lib/haproxy
    pidfile     /var/run/haproxy.pid
    maxconn     4000
    user        haproxy
    group       haproxy
    daemon

    # turn on stats unix socket
    stats socket /var/lib/haproxy/stats

defaults
        log     global
        mode    http
        option  dontlognull
        option  redispatch
        retries 3
        maxconn 2000
        timeout connect         10s
        timeout client          1m
        timeout server          1m

listen https :443
        mode tcp
        balance roundrobin

        server apiserver01 master01.example.com:443 check
        server apiserver01 master02.example.com:443 check
EOF
root@service:~$ systemd restart haproxy
{% endhighlight %}

After restarting the service it should be possible to reach the master nodes via the load balancer URL (e.g. *loadbalancer.example.com*) although at this time there is no service available on port 443.

## Flanneld

[Flannel](https://coreos.com/flannel) enables the cluster wide distribution of the pods' packages.
Since the description of the networks are stored in *etcd* a connection of all Kubernetes nodes (master and worker) to the *etcd* cluster has to be enabled.
The docker daemon on each Kubernetes node will be performed with special parameters provided by flanneld.
Cross-node communication of containers is realized by iptables that route the packages to the correct target servers.
For this purpose flanneld creates its own virtual network interface and must therefore run with root rights.

### Create *etcd* client certificates

Kubernetes nodes need a client certificate because each user of the *etcd* cluster has to authenticate.
It can be created as described in [the first part of this blog post series](https://developer.epages.com/blog/2016/08/09/how-to-setup-a-kubernetes-cluster-etcd-cluster-with-ssl.html) but there are differences in the _openssl.cnf_.
The _openssl.cnf_ has a simpler structure as flanneld has to identify itself as client only.

{% highlight bash %}
root@kubernetes:~$ mkdir -p /etc/ssl/etcd
root@kubernetes:~$ cd /etc/ssl/etcd
root@kubernetes:/etc/ssl/etcd$ cat > openssl.cnf <<EOF
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name
[req_distinguished_name]
[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = clientAuth
EOF
root@kubernetes:/etc/ssl/etcd$ openssl genrsa -out etcd-client.key 2048
root@kubernetes:/etc/ssl/etcd$ chmod 600 etcd-client.key
root@kubernetes:/etc/ssl/etcd$ openssl \
  req -new \
  -key etcd-client.key \
  -out etcd-client.csr \
  -subj "/CN=$(hostname -s)" \
  -extensions v3_req \
  -config openssl.cnf \
  -sha256
root@kubernetes:/etc/ssl/etcd$ scp openssl.cnf etcd-client.csr root@root-ca-host:
{% endhighlight %}

This certificate request is also signed with the root CA stored as _/etc/ssl/etcd/etcd-client.crt_ on the Kubernetes nodes.

{% highlight bash %}
root@root-ca-host:~$ openssl x509 \
  -req \
  -CA ca.crt \
  -CAkey ca.key \
  -CAcreateserial \
  -in etcd-client.csr \
  -out etcd-client.crt \
  -days 365 \
  -extensions v3_req \
  -extfile openssl.cnf \
  -sha256
root@root-ca-host:~$ scp etcd-client.crt ca.crt root@kubernetes:/etc/ssl/etcd/
{% endhighlight %}

Altogether, the following files should be available on all Kubernetes nodes:

{% highlight bash %}
root@kubernetes:~$ cd /etc/ssl/etcd/
root@kubernetes:/etc/ssl/etcd$ rm -f openssl.cnf etcd-client.csr
root@kubernetes:/etc/ssl/etcd$ ls -la
-rw-r--r--  1 root root 4711 Jun  33 08:15 ca.crt
-rw-r--r--  1 root root 4712 Jun  33 08:15 etcd-client.crt
-rw-------  1 root root 4713 Jun  33 08:15 etcd-client.key
{% endhighlight %}

### Installing of the daemon

For the various settings an extra file __options.env__ is used.
Besides all *etcd* nodes __options.env__ file contains the certificates.
Finally, the *Systemd* service is created.

{% highlight bash %}
root@kubernetes:~$ cd /tmp
root@kubernetes:/tmp$ mkdir -p /opt/flanneld
root@kubernetes:/tmp$ curl -L -O https://github.com/coreos/flannel/releases/download/v0.5.5/flannel-0.5.5-linux-amd64.tar.gz
root@kubernetes:/tmp$ tar -xzf flannel-0.5.5-linux-amd64.tar.gz
root@kubernetes:/tmp$ cp flannel-0.5.5/flanneld /usr/local/bin/flanneld
root@kubernetes:/tmp$ cp flannel-0.5.5/mk-docker-opts.sh /opt/flanneld/mk-docker-opts.sh
root@kubernetes:/tmp$ chmod 755 /usr/local/bin/flanneld
root@kubernetes:/tmp$ chmod 755 /opt/flanneld/mk-docker-opts.sh
root@kubernetes:/tmp$ mkdir -p /etc/flanneld
root@kubernetes:/tmp$ export PRIMARY_HOST_IP=192.168.1.[1|2] or 192.168.2.[1|2|3]
root@kubernetes:/tmp$ cat > /etc/flanneld/options.env << EOF
FLANNELD_ETCD_ENDPOINTS=https://192.168.0.1:2379,https://192.168.0.2:2379,https://192.168.0.3:2379
FLANNELD_ETCD_CAFILE=/etc/ssl/etcd/ca.crt
FLANNELD_ETCD_CERTFILE=/etc/ssl/etcd/etcd-client.crt
FLANNELD_ETCD_KEYFILE=/etc/ssl/etcd/etcd-client.key
FLANNELD_IFACE=$PRIMARY_HOST_IP
FLANNELD_PUBLIC_IP=$PRIMARY_HOST_IP
EOF
root@kubernetes:/tmp$ cat > /etc/systemd/system/flanneld.service << EOF
[Unit]
Description=Network fabric for containers
Documentation=https://github.com/coreos/flannel
Requires=networking.service
Before=docker.service
After=networking.service

[Service]
Type=notify
Restart=always
RestartSec=5
EnvironmentFile=/etc/flanneld/options.env
LimitNOFILE=40000
LimitNPROC=1048576
ExecStartPre=/sbin/modprobe ip_tables
ExecStartPre=/bin/mkdir -p /run/flanneld

ExecStart=/usr/local/bin/flanneld --ip-masq=true

## Updating Docker options
ExecStartPost=/opt/flanneld/mk-docker-opts.sh -d /run/flanneld/docker_opts.env -i

[Install]
WantedBy=multi-user.target
EOF
root@kubernetes:/tmp$ systemctl enable flanneld
root@kubernetes:/tmp$ systemctl start flanneld
root@kubernetes:/tmp$ rm -rf flannel-0.5.5
root@kubernetes:/tmp$ rm -f flannel-0.5.5-linux-amd64.tar.gz
{% endhighlight %}

### Docker engine

As you can see in _/etc/systemd/system/flanneld.service_ the script _mk-docker-opts.sh_ creates environment variables with the file _/run/flanneld/docker_opts.env_.
These variables are used by the Docker daemon.
We use the [drop-in feature](https://www.freedesktop.org/software/systemd/man/systemd.unit.html) of *Systemd*.
So there is no need to change the standard service definition of Docker.
The [installation of the Docker engine](https://docs.docker.com/engine/installation/linux/debian/) is done in the standard way.

{% highlight bash %}
root@kubernetes:~$ apt-get purge lxc-docker*
root@kubernetes:~$ apt-get purge docker.io*
root@kubernetes:~$ apt-get install -y apt-transport-https ca-certificates
root@kubernetes:~$ apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
root@kubernetes:~$ cat > /etc/apt/sources.list.d/docker.list << EOF
deb https://apt.dockerproject.org/repo debian-jessie main
EOF
root@kubernetes:~$ apt-get update
root@kubernetes:~$ apt-get install -y docker-engine
root@kubernetes:~$ systemctl enable docker
root@kubernetes:~$ systemctl stop docker
root@kubernetes:~$ mkdir -p /etc/systemd/system/docker.service.d
root@kubernetes:~$ cat > /etc/systemd/system/docker.service.d/docker.conf << "EOF"
[Service]
EnvironmentFile=/run/flanneld/docker_opts.env
ExecStart=
ExecStart=/usr/bin/docker daemon -H fd:// $DOCKER_OPTS $DOCKER_OPT_BIP $DOCKER_OPT_MTU $DOCKER_OPT_IPMASQ
EOF
root@kubernetes:~$ systemctl daemon-reload
root@kubernetes:~$ systemctl enable docker
root@kubernetes:~$ systemctl restart docker
{% endhighlight %}

*drop-in* overwrites the start command.
The new one contains the variables from the file _/run/flanneld/docker_opts.env_ generated by the *flanneld* and loaded via the option *EnvironmentFile*.

## Kubelet

[Kubelet](http://kubernetes.io/docs/admin/kubelet/) controls the directory _/etc/kubernetes/manifests_ and creates Docker containers from the Pod definitions located here.
Therefore, it also needs root rights.
The Kubelet version has to be compatible to the one of the API server.

### Installation
Kubelet is part of the official Kubernetes release.
It is simply loaded to every Kubernetes node and unpacked there.

{% highlight bash %}
root@kubernetes:/tmp$ curl -L -O https://github.com/kubernetes/kubernetes/releases/download/v1.2.2/kubernetes.tar.gz
root@kubernetes:/tmp$ tar -xzf kubernetes.tar.gz
root@kubernetes:/tmp$ cd kubernetes/server
root@kubernetes:/server$ tar -xzf kubernetes-server-linux-amd64.tar.gz
root@kubernetes:/server$ cp kubernetes/server/bin/kubelet /usr/local/bin/kubelet
root@kubernetes:/server$ cd /tmp
root@kubernetes:/tmp$ rm -rf kubernetes
root@kubernetes:/tmp$ chmod 755 /usr/local/bin/kubelet
root@kubernetes:/tmp$ mkdir -p /etc/kubernetes/manifests
{% endhighlight %}

In addition we have to add [Kernel boot parameter](https://github.com/kubernetes/kubernetes/issues/9837).
Refer to the following code example on how to do this using *sed*.

{% highlight bash %}
root@kubernetes:~$ sed -i "s/^GRUB_CMDLINE_LINUX_DEFAULT=\"\(.*\)\"$/GRUB_CMDLINE_LINUX_DEFAULT=\"\1\ cgroup_enable=memory\"/g" /etc/default/grub
root@kubernetes:~$ update-grub
root@kubernetes:~$ reboot
{% endhighlight %}

## Summary

The external __service node__ is used as a load balancer.
Working on the [Transport layer](https://en.wikipedia.org/wiki/Transport_layer) of the [OSI reference model](https://en.wikipedia.org/wiki/OSI_model) it does not terminate SSL but simply routes the traffic.

On all __Kubernetes nodes__ run various services.
*Flanneld* is required to run the *Docker engine*.
It stores data for the networks in the *etcd cluster* and therefore needs a client certificate.
The *Docker engine* is a standard installation.
It uses its own *drop-in* to be able to handle the parameters provided by *flanneld*.

## Related posts

* [How to set up a HA Kubernetes cluster: etcd cluster with SSL](https://developer.epages.com/blog/2016/08/09/how-to-setup-a-ha-kubernetes-cluster-etcd-cluster-with-ssl.html)
