# public keys source
~/.ssh/authorized_keys

# create public&private keys
ssh-keygen

openssl genrsa -out my-bank.key 2048
openssl rsa -in my-bank.key -pubout > mybank.pem


# create certificate
openssl req -new \
-key my-bank.key \
-out my-bank.csr \
-subj "/C=US/ST=CA/O=MyOrg,Inc./CN=my-bank.com"

.crt / .pem # public keys formate
.key / -key.pem # private keys


# Generate key
openssl genrsa -out ca.key 2048

# Certificate signing request
openssl req -new -key ca.key -subj "/CN=KUBERNETES-CA" -out ca.csr

# Sign certificate
openssl x509 -req -in ca.csr -signkey ca.key -out ca.crt

# ///////////////////////////////////////////////////////////////////////
# USER_ADMIN

# Generate key
openssl genrsa -out admin.key 2048

# Certificate signing request
openssl req -new -key admin.key -subj "/CN=KUBERNETES-CA/O=system:masters" -out admin.csr

# Sign certificate
openssl x509 -req -in admin.csr -signkey admin.key -out admin.crt

# Decode the certificate file
openssl x509 -in /etc/kubernetes/pki/apiserver.crt -text -noout

journalctl #for see logs system