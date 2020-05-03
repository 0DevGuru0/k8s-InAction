# >>>https://github.com/ahmetb/kubernetes-network-policy-recipes/blob/master/03-deny-all-non-whitelisted-traffic-in-the-namespace.md



# k create ns myns
# k run nginx --image=nginx --labels "app=web" -n myns --expose --port 80

# k run -it --rm --image=alpine test-$RANDOM -- sh
#  wget -qO- http://web

cat <<EOF | kubectl apply -f -
kind: Service
apiVersion: v1
metadata:
 name: web
 namespace: default
spec:
 type: ExternalName
 externalName: nginx.myns.svc.cluster.local
 ports:
  - port: 80
EOF

cat <<EOF | kubectl apply -f -
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
 name: default-deny-all
 namespace: myns
spec:
 podSelector: {}
 ingress: []
EOF