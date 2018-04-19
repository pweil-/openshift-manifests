#!/bin/bash

###
# ALLOW_PRIVILEGED=true hack/local-up-cluster.sh
###

kubectl=/home/pweil/codebase/kubernetes/src/k8s.io/kubernetes/cluster/kubectl.sh

###
#  etcd
#
#  TODO: need path for data that is not hostpath
###
$kubectl --namespace=kube-system create secret generic openshift-master-config \
  --from-file=/home/pweil/codebase/openshift-manifests/kube-apiserver/admin.crt \
  --from-file=/home/pweil/codebase/openshift-manifests/kube-apiserver/admin.key \
  --from-file=/home/pweil/codebase/openshift-manifests/kube-apiserver/admin.kubeconfig \
  --from-file=/home/pweil/codebase/openshift-manifests/kube-apiserver/ca-bundle.crt \
  --from-file=/home/pweil/codebase/openshift-manifests/kube-apiserver/ca.crt \
  --from-file=/home/pweil/codebase/openshift-manifests/kube-apiserver/ca.key \
  --from-file=/home/pweil/codebase/openshift-manifests/kube-apiserver/ca.serial.txt \
  --from-file=/home/pweil/codebase/openshift-manifests/kube-apiserver/etcd.server.crt \
  --from-file=/home/pweil/codebase/openshift-manifests/kube-apiserver/etcd.server.key \
  --from-file=/home/pweil/codebase/openshift-manifests/kube-apiserver/frontproxy-ca.crt \
  --from-file=/home/pweil/codebase/openshift-manifests/kube-apiserver/frontproxy-ca.key \
  --from-file=/home/pweil/codebase/openshift-manifests/kube-apiserver/frontproxy-ca.serial.txt \
  --from-file=/home/pweil/codebase/openshift-manifests/kube-apiserver/master-config.yaml \
  --from-file=/home/pweil/codebase/openshift-manifests/kube-apiserver/master.etcd-client.crt \
  --from-file=/home/pweil/codebase/openshift-manifests/kube-apiserver/master.etcd-client.key \
  --from-file=/home/pweil/codebase/openshift-manifests/kube-apiserver/master.kubelet-client.crt \
  --from-file=/home/pweil/codebase/openshift-manifests/kube-apiserver/master.kubelet-client.key \
  --from-file=/home/pweil/codebase/openshift-manifests/kube-apiserver/master.proxy-client.crt \
  --from-file=/home/pweil/codebase/openshift-manifests/kube-apiserver/master.proxy-client.key \
  --from-file=/home/pweil/codebase/openshift-manifests/kube-apiserver/master.server.crt \
  --from-file=/home/pweil/codebase/openshift-manifests/kube-apiserver/master.server.key \
  --from-file=/home/pweil/codebase/openshift-manifests/kube-apiserver/openshift-aggregator.crt \
  --from-file=/home/pweil/codebase/openshift-manifests/kube-apiserver/openshift-aggregator.key \
  --from-file=/home/pweil/codebase/openshift-manifests/kube-apiserver/openshift-master.crt \
  --from-file=/home/pweil/codebase/openshift-manifests/kube-apiserver/openshift-master.key \
  --from-file=/home/pweil/codebase/openshift-manifests/kube-apiserver/openshift-master.kubeconfig \
  --from-file=/home/pweil/codebase/openshift-manifests/kube-apiserver/router.crt \
  --from-file=/home/pweil/codebase/openshift-manifests/kube-apiserver/router.key \
  --from-file=/home/pweil/codebase/openshift-manifests/kube-apiserver/router.pem \
  --from-file=/home/pweil/codebase/openshift-manifests/kube-apiserver/serviceaccounts.private.key \
  --from-file=/home/pweil/codebase/openshift-manifests/kube-apiserver/serviceaccounts.public.key \
  --from-file=/home/pweil/codebase/openshift-manifests/kube-apiserver/service-signer.crt \
  --from-file=/home/pweil/codebase/openshift-manifests/kube-apiserver/service-signer.key

$kubectl --namespace=kube-system create -f /home/pweil/codebase/openshift-manifests/etcd.yaml

sleep 30

###
#  api server
# 
#  TODO: mount paths for cloud provider and master data
###
$kubectl --namespace=kube-system create -f /home/pweil/codebase/openshift-manifests/apiserver.yaml

###
#  scheduler
# 
#  TODO: mount paths for cloud provider
###
$kubectl --namespace=kube-system create -f /home/pweil/codebase/openshift-manifests/kube-scheduler.yaml

###
#  controller manager
# 
#  TODO: mount paths for cloud provider
###
$kubectl --namespace=kube-system create -f /home/pweil/codebase/openshift-manifests/kube-controller-manager-10253.yaml

read -p "Press enter to continue"

###
#  openshift api-server
#
#  TODO: check ns for finalizers
#  TODO: cloud provider
###
$kubectl create -f /home/pweil/codebase/openshift-manifests/openshift-apiserver-namespace.yaml

$kubectl --namespace=openshift-apiserver create secret generic openshift-apiserver-config \
  --from-file=/home/pweil/codebase/openshift-manifests/openshift-apiserver/admin.crt \
  --from-file=/home/pweil/codebase/openshift-manifests/openshift-apiserver/admin.key \
  --from-file=/home/pweil/codebase/openshift-manifests/openshift-apiserver/admin.kubeconfig \
  --from-file=/home/pweil/codebase/openshift-manifests/openshift-apiserver/ca-bundle.crt \
  --from-file=/home/pweil/codebase/openshift-manifests/openshift-apiserver/ca.crt \
  --from-file=/home/pweil/codebase/openshift-manifests/openshift-apiserver/ca.key \
  --from-file=/home/pweil/codebase/openshift-manifests/openshift-apiserver/ca.serial.txt \
  --from-file=/home/pweil/codebase/openshift-manifests/openshift-apiserver/etcd.server.crt \
  --from-file=/home/pweil/codebase/openshift-manifests/openshift-apiserver/etcd.server.key \
  --from-file=/home/pweil/codebase/openshift-manifests/openshift-apiserver/frontproxy-ca.crt \
  --from-file=/home/pweil/codebase/openshift-manifests/openshift-apiserver/frontproxy-ca.key \
  --from-file=/home/pweil/codebase/openshift-manifests/openshift-apiserver/frontproxy-ca.serial.txt \
  --from-file=/home/pweil/codebase/openshift-manifests/openshift-apiserver/master-config.yaml \
  --from-file=/home/pweil/codebase/openshift-manifests/openshift-apiserver/master.etcd-client.crt \
  --from-file=/home/pweil/codebase/openshift-manifests/openshift-apiserver/master.etcd-client.key \
  --from-file=/home/pweil/codebase/openshift-manifests/openshift-apiserver/master.kubelet-client.crt \
  --from-file=/home/pweil/codebase/openshift-manifests/openshift-apiserver/master.kubelet-client.key \
  --from-file=/home/pweil/codebase/openshift-manifests/openshift-apiserver/master.proxy-client.crt \
  --from-file=/home/pweil/codebase/openshift-manifests/openshift-apiserver/master.proxy-client.key \
  --from-file=/home/pweil/codebase/openshift-manifests/openshift-apiserver/master.server.crt \
  --from-file=/home/pweil/codebase/openshift-manifests/openshift-apiserver/master.server.key \
  --from-file=/home/pweil/codebase/openshift-manifests/openshift-apiserver/openshift-aggregator.crt \
  --from-file=/home/pweil/codebase/openshift-manifests/openshift-apiserver/openshift-aggregator.key \
  --from-file=/home/pweil/codebase/openshift-manifests/openshift-apiserver/openshift-master.crt \
  --from-file=/home/pweil/codebase/openshift-manifests/openshift-apiserver/openshift-master.key \
  --from-file=/home/pweil/codebase/openshift-manifests/openshift-apiserver/openshift-master.kubeconfig \
  --from-file=/home/pweil/codebase/openshift-manifests/openshift-apiserver/serviceaccounts.private.key \
  --from-file=/home/pweil/codebase/openshift-manifests/openshift-apiserver/serviceaccounts.public.key \
  --from-file=/home/pweil/codebase/openshift-manifests/openshift-apiserver/service-signer.crt \
  --from-file=/home/pweil/codebase/openshift-manifests/openshift-apiserver/service-signer.key

$kubectl --namespace=openshift-apiserver create -f /home/pweil/codebase/openshift-manifests/openshift-apiserver-sa.yaml

$kubectl --namespace=openshift-apiserver create -f /home/pweil/codebase/openshift-manifests/openshift-apiserver.yaml



