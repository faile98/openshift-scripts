export OWN_REPO_PATH=http://admin.na.shared.opentlc.com/repos/ocp/3.7
cat << EOF > /etc/yum.repos.d/open.repo
[rhel-7-server-rpms]
name=Red Hat Enterprise Linux 7
baseurl=${OWN_REPO_PATH}/rhel-7-server-rpms
enabled=1
gpgcheck=0
[rhel-7-server-rh-common-rpms]
name=Red Hat Enterprise Linux 7 Common
baseurl=${OWN_REPO_PATH}/rhel-7-server-rh-common-rpms
enabled=1
gpgcheck=0
[rhel-7-server-extras-rpms]
name=Red Hat Enterprise Linux 7 Extras
baseurl=${OWN_REPO_PATH}/rhel-7-server-extras-rpms
enabled=1
gpgcheck=0
[rhel-7-server-optional-rpms]
name=Red Hat Enterprise Linux 7 Optional
baseurl=${OWN_REPO_PATH}/rhel-7-server-optional-rpms
enabled=1
gpgcheck=0
[rhel-7-fast-datapath-rpms]
name=Red Hat Enterprise Linux 7 Fast Datapath
baseurl=${OWN_REPO_PATH}/rhel-7-fast-datapath-rpms
enabled=1
gpgcheck=0
[rhel-7-server-ose-3.7-rpms]
name=Red Hat Enterprise Linux 7 OSE 3.7
baseurl=${OWN_REPO_PATH}/rhel-7-server-ose-3.7-rpms
enabled=1
gpgcheck=0
EOF
mv /etc/yum.repos.d/redhat.{repo,disabled}
yum clean all
yum repolist
yum -y update
