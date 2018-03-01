ansible nfs -m shell -a "mkdir -p /exports/user-vols/pv{001..200};
  for pvnum in {001..200} ; do \
  echo /exports/user-vols/pv${pvnum} *(rw,root_squash) >> /etc/exports.d/openshift-uservols.exports; \
  chown -R nfsnobody.nfsnobody  /exports/user-vols; \
  chmod -R 777 /exports/user-vols; \
  done;"
ansible nfs -m shell -a "systemctl restart nfs-server"
