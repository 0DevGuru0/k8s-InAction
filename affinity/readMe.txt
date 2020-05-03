Affinity: --> Limit On Pods
[The new node affinity syntax supports the following operators: In, NotIn, Exists, DoesNotExist, Gt, Lt]
    1- nodeAffinity 
    2- nodeAntiAffinity [ by specify NotIn| DoesNotExits operators in nodeAffinity ]

    3- podAffinity
    4- podAntiAffinity

    5-nodeSelector
    6-nodeName


Taint & Toleration: --> Limit On Nodes
   - only just say to node to expect specific taint pod and toleration ;
   - toleration doesn't restrict pod that have toleration to schedule on other node ;
   - this function restrict node to accept specific pod not restrict pod;