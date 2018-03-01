export CLUSTER_ID=`hostname|cut -f2 -d-|cut -f1 -d.`
yum -y install ansible
cat ./hosts > /etc/ansible/hosts

ansible all -m copy -a "src=/etc/yum.repos.d/open.repo dest=/etc/yum.repos.d/open.repo"
ansible all -m shell -a "mv /etc/yum.repos.d/redhat.{repo,disabled}"
ansible all -m shell -a "yum clean all ; yum repolist ; yum -y update"

REGISTRY="registry.access.redhat.com";
OSE_VERSION=$(yum info atomic-openshift | grep Version | awk '{print $3}')
PTH="openshift3"
ansible infranodes -m shell \
  -a " docker pull $REGISTRY/$PTH/ose-haproxy-router:v$OSE_VERSION ; \
  docker pull $REGISTRY/$PTH/ose-deployer:v$OSE_VERSION ; \
  docker pull $REGISTRY/$PTH/ose-pod:v$OSE_VERSION ; \
  docker pull $REGISTRY/$PTH/ose-docker-registry:v$OSE_VERSION ;"

ansible node1.example.com,node2.example.com,node3.example.com,node4.example.com,node5.example.com,node6.example.com -m shell \
  -a "docker pull $REGISTRY/$PTH/ose-deployer:v$OSE_VERSION ; \
  docker pull $REGISTRY/$PTH/ose-sti-builder:v$OSE_VERSION ; \
  docker pull $REGISTRY/$PTH/ose-pod:v$OSE_VERSION ; \
  docker pull $REGISTRY/$PTH/ose-keepalived-ipfailover:v$OSE_VERSION ; \
  docker pull $REGISTRY/$PTH/ruby-20-rhel7 ; \
  docker pull $REGISTRY/$PTH/mysql-55-rhel7 ; \
  docker pull openshift/hello-openshift:v1.2.1 ;"
