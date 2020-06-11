docker run -d \
--name jenkins \
-v jenkins_home:/var/jenkins_home \
-p 8080:8080 \
-p 50000:50000 \
jenkins/jenkins:lts


docker run -d -p 5000:5000 --restart=always --name registry -v docker:/var/lib/registry registry:2