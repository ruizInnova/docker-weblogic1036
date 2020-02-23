# docker-weblogic1036
Build Docker image:
docker build -t myweblogic1036 docker-weblogic1036

Run docker image:
docker run -d -ti -p 7001:7001 myweblogic1036 /bin/bash

Now you can access to weblogic:
http://localhost:7001/console
username: weblogic
password: weblogic01
