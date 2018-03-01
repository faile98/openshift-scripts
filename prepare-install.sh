yum -y install atomic-openshift-utils

htpasswd -cb /root/htpasswd.openshift admin password
htpasswd -b /root/htpasswd.openshift mitzicom_admin password
htpasswd -b /root/htpasswd.openshift mitzicom_client1 password
htpasswd -b /root/htpasswd.openshift mitzicom_client2 password
