helm init
helm inspect values stable/metrics-server > /tmp/metrics-server.values
vi /tmp/metrics-server.values
k create ns operations
helm install \
--name metrics-server \
--values /tmp/metrics-server.values \
--namespace operations \
stable/metrics-server
