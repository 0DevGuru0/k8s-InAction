+                                HPA-EXAMPLE
*********************************************************************************
# https://www.katacoda.com/reselbob/scenarios/using-k8s-horizontal-pod-autoscaler
*********************************************************************************

Install metrics-server:
# git clone https://github.com/kubernetes-incubator/metrics-server.git
# cd metrics-server/
# nano deploy/1.8+/metrics-server-deployment.yaml
# [
#     command:
#         - /metrics-server
#         - --metric-resolution=30s
#         - --kubelet-insecure-tls
#         - --kubelet-preferred-address-types=InternalIP
# ]
# kubectl apply -f deploy/1.8+/
Test metrics-server:
# kubectl top pod --all-namespaces

Create deployment that should autoscale
# kubectl run hpa-demo-web --image=k8s.gcr.io/hpa-example --requests=cpu=200m --port=80 --replicas=1
# kubectl expose deployment hpa-demo-web --type=NodePort --port=30001
# kubectl autoscale deployment hpa-demo-web --cpu-percent=5 --min=1 --max=5

Create infinit request loop for deployment
# kubectl run -it deployment-for-testing --image=busybox /bin/sh
# echo "while true; do wget -q -O- http://hpa-demo-web.default.svc.cluster.local ; done" > loops.sh
# chmod +x /loops.sh
# sh /loops.sh