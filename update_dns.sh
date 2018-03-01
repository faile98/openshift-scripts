export GUID=`hostname|cut -f2 -d-|cut -f1 -d.`

HostIP1=`host infranode1-$GUID.oslab.opentlc.com ipa.opentlc.com |grep infranode | awk '{print $4}'`
HostIP2=`host infranode2-$GUID.oslab.opentlc.com ipa.opentlc.com |grep infranode | awk '{print $4}'`
HostIP3=`host infranode3-$GUID.oslab.opentlc.com ipa.opentlc.com |grep infranode | awk '{print $4}'`

domain="cloudapps-$GUID.oslab.opentlc.com"

mkdir -p /var/named/zones

echo "\$ORIGIN  .
\$TTL 1  ;  1 seconds (for testing only)
${domain} IN SOA master.${domain}.  root.${domain}.  (
  2011112904  ;  serial
  60  ;  refresh (1 minute)
  15  ;  retry (15 seconds)
  1800  ;  expire (30 minutes)
  10  ; minimum (10 seconds)
)
  NS master.${domain}.
\$ORIGIN ${domain}.

* IN A ${HostIP1}
  IN A ${HostIP2}
  IN A ${HostIP3}"  >  /var/named/zones/${domain}.db

mv /etc/named.conf /etc/named.conf.orig
echo "// named.conf
options {
  listen-on port 53 { any; };
  directory \"/var/named\";
  dump-file \"/var/named/data/cache_dump.db\";
  statistics-file \"/var/named/data/named_stats.txt\";
  memstatistics-file \"/var/named/data/named_mem_stats.txt\";
  allow-query { any; };
  recursion yes;
  /* Path to ISC DLV key */
  bindkeys-file \"/etc/named.iscdlv.key\";
  forwarders {
   192.168.0.1;
  };
  allow-recursion { 192.168.0.0/16; };
};
logging {
  channel default_debug {
    file \"data/named.run\";
    severity dynamic;
  };
};
zone \"${domain}\" IN {
  type master;
  file \"zones/${domain}.db\";
  allow-update { key ${domain} ; } ;
};" > /etc/named.conf
chgrp named -R /var/named ;  chown named -Rv /var/named/zones ;  restorecon -Rv /var/named ;  chown -v root:named /etc/named.conf ;  restorecon -v /etc/named.conf ;
systemctl enable named &&  systemctl start named
iptables -I INPUT 1 -p tcp --dport 53 -s 0.0.0.0/0 -j ACCEPT ; iptables -I INPUT 1 -p udp --dport 53 -s 0.0.0.0/0 -j ACCEPT ; iptables-save > /etc/sysconfig/iptables
