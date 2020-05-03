echo "create user key"
openssl genrsa -out user.key 2048

echo "create certificate request"
openssl req -new -key user.key -out user.csr -subj "/CN=kube-user/O=system:masters"

echo "apply certificate siging request on k8s cluster"
cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1beta1
kind: CertificateSigningRequest
metadata:
  name: user
spec:
  request: $(cat user.csr | base64 | tr -d '\n')
  usages:
  - digital signature
  - key encipherment
  - server auth
EOF

echo "approve user as admin"
kubectl certificate approve user

echo "get user certificate"
kubectl get csr user -o jsonpath='{.status.certificate}' | base64 --decode > user.crt

echo "get certitifacate authority"
kubectl config view -o jsonpath='{.clusters[0].cluster.certificate-authority-data}' --raw | base64 --decode - > ca.crt

echo "check for accessing cluster with user auth"
curl https://$Kube-Master-Ip:6443/api/v1 \
--key user.key \
--cert user.crt \
--cacert ca.crt
