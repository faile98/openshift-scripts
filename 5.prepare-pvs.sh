export volsize="5Gi"
mkdir /root/pvs
for volume in pv{001..025} ; do
cat << EOF > /root/pvs/${volume}
{
  "apiVersion": "v1",
  "kind": "PersistentVolume",
  "metadata": {
    "name": "${volume}"
  },
  "spec": {
    "capacity": {
        "storage": "${volsize}"
    },
    "accessModes": [ "ReadWriteOnce" ],
    "nfs": {
        "path": "/exports/user-vols/${volume}",
        "server": "node6.example.com"
    },
    "persistentVolumeReclaimPolicy": "Recycle"
  }
}
EOF
  echo "Created def file for ${volume}"; done;
  for volume in pv{101..125} ; do
  cat << EOF > /root/pvs/${volume}
  {
    "apiVersion": "v1",
    "kind": "PersistentVolume",
    "metadata": {
      "name": "${volume}"
    },
    "spec": {
      "capacity": {
          "storage": "${volsize}"
      },
      "accessModes": [ "ReadWriteMany" ],
      "nfs": {
          "path": "/exports/user-vols/${volume}",
          "server": "node6.example.com"
      },
      "persistentVolumeReclaimPolicy": "Recycle"
    }
  }
  EOF
    echo "Created def file for ${volume}"; done;
export volsize="10Gi"
for volume in pv{026..050} ; do
cat << EOF > /root/pvs/${volume}
{
  "apiVersion": "v1",
  "kind": "PersistentVolume",
  "metadata": {
    "name": "${volume}"
  },
  "spec": {
    "capacity": {
        "storage": "${volsize}"
    },
    "accessModes": [ "ReadWriteOnce" ],
    "nfs": {
        "path": "/exports/user-vols/${volume}",
        "server": "node6.example.com"
    },
    "persistentVolumeReclaimPolicy": "Recycle"
  }
}
EOF
 echo "Created def file for ${volume}"; done;
export volsize="1Gi"
for volume in pv{051..100} ; do
cat << EOF > /root/pvs/${volume}
{
  "apiVersion": "v1",
  "kind": "PersistentVolume",
  "metadata": {
    "name": "${volume}"
  },
  "spec": {
    "capacity": {
        "storage": "${volsize}"
    },
    "accessModes": [ "ReadWriteOnce" ],
    "nfs": {
        "path": "/exports/user-vols/${volume}",
        "server": "node6.example.com"
    },
    "persistentVolumeReclaimPolicy": "Recycle"
  }
}
EOF
 echo "Created def file for ${volume}"; done;
