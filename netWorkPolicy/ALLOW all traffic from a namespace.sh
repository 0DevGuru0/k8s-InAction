cat <<EOF | k apply -f -
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
 name: allow-all-traffic-from-a-namespace
spec:
 podSelector:
  matchLabels:
   app: web
 ingress:
  - from:
     - namespaceSelector:
        matchLabels:
         purpose: production
EOF

cat <<EOF | k apply -f -
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
 name: allow-all-traffic-from-a-namespace-a-pod
spec:
 podSelector:
  matchLabels:
   app: web
 ingress:
  - from:
      - namespaceSelector:
          matchLabels:
          purpose: production
      - podSelector:
          matchLabels:
            type: monitoring
EOF


cat <<EOF | k apply -f -
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
 name:  deny-egress
spec:
 podSelector:
  matchLabels:
   app: web
 policyTypes:
  - Egress
 egress:
  - ports:
    - protocol: UDP
      port: 53
    - protocol: TCP
      port: 53
EOF

cat <<EOF | k apply -f -
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
 name:  foo-deny-external-egress
spec:
 podSelector:
  matchLabels:
    app: foo
 policyTypes:
  - Egress
 egress:
  - ports:
    - protocol: UDP
      port: 53
    - protocol: TCP
      port: 53
  to:
   - namespaceSelector: {}
EOF

cat <<EOF | k apply -f -
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: foo-deny-external-egress
spec:
  podSelector:
    matchLabels:
      app: foo
  policyTypes:
  - Egress
  egress:
  - ports:
    - port: 53
      protocol: UDP
    - port: 53
      protocol: TCP
   to:
    - namespaceSelector: {}
EOF