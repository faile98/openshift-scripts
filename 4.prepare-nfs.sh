ansible nfs -m shell -a "mkdir -p /exports/user-vols/pv{001..200};"

cat <<'EOF' > uservols.sh
#!/bin/bash
for pvnum in {001..200}
  do
    if grep -q pv${pvnum} /etc/exports.d/openshift-uservols.exports;
    then
      echo "pv${pvnum}" already registered
    else
      echo /exports/user-vols/pv${pvnum} *\(rw,root_squash\) >> /etc/exports.d/openshift-uservols.exports;
    fi
done;
EOF

ansible nfs -m copy -a "src=uservols.sh dest=/root/uservols.sh mode=u+x"

ansible nfs -m shell -a "/root/uservols.sh; chown -R nfsnobody.nfsnobody /exports/user-vols;  chmod -R 777 /exports/user-vols;";
ansible nfs -m file -a "path=/root/uservols.sh state=absent"
ansible localhost -m file -a "path=uservols.sh state=absent"
ansible nfs -m shell -a "systemctl restart nfs-server"
