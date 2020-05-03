k run nginx --image nginx --generator run-pod/v1 \
&& k expose pod nginx --type='NodePort' --port=32222 \
&& k patch service nginx --type=json --patch='[{"op":"replace","path":"/spec/ports/0/nodePort","value":32222}]' \
&& k get svc nginx -o json | jq '.spec.ports[0]' 