storageFolder=/srv/nfs/kubedata

echo "[NFS] Install nfs server"
apt install nfs-kernel-server >> /dev/null

echo "[NFS] Create store folder -- ($storageFolder)"
mkdir -p $storageFolder

echo "[NFS] configure nfs specified folder"
cat <<EOF >> /etc/exports
$storageFolder     *(rw,sync,no_subtree_check,no_root_squash,no_all_squash,insecure)
EOF

echo "[NFS] Export folder as nfs storage"
exportfs -rav

echo "[NFS] Check exported folder"
exportfs -v