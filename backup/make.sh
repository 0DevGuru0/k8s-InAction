docker run -p 9000:9000 --name minio \
-e "MINIO_ACCESS_KEY=afsan007" \
-e "MINIO_SECRET_KEY=minio123" \
-v /mnt/data:/data \
minio/minio server /data

wget https://github.com/vmware-tanzu/velero/releases/download/v1.3.2/velero-v1.3.2-linux-amd64.tar.gz
tar zxf velero-v1.3.2-linux-amd64.tar.gz
sudo mv velero-v1.3.2-linux-amd64/velero /usr/local/bin/
rm -rf velero*

cat <<EOF >> minio.credentials
[default]
aws_access_key_id=afsan007
aws_secret_access_key=minio123
EOF

velero install \
--plugins velero/velero-plugin-for-aws:v1.0.0 \
--provider aws \
--bucket kubedemo \
--secret-file ./minio.credentials \
--backup-location-config region=minio,s3ForcePathStyle=true,s3Url=https://2886795317-9000-elsy06.environments.katacoda.com/


watch kubectl get all -n velero

k create ns testing
k run nginx --image nginx --replicas 3

velero backup create fsbackup --include-namespaces=testing

k delete ns testing
velero restore create fsbackup-restore1 --from-backup fsbackup


