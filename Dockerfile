FROM ubuntu:16.04

# EINES
RUN apt-get update \
  && apt-get install -y tar \
  && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/*

COPY scrics/install_weblogic1036.sh /u01/install/install_weblogic1036.sh
COPY scrics/template1036.jar /u01/install/template1036.jar
COPY scrics/create_domain.ini /u01/install/create_domain.ini
COPY scrics/start_AdminServer.sh /u01/scripts/start_AdminServer.sh
COPY scrics/start_nodemanager.sh /u01/scripts/start_nodemanager.sh
COPY scrics/start_ALL.sh /u01/scripts/start_ALL.sh
ADD https://raw.githubusercontent.com/iwanttobefreak/weblogic/master/scrics/install/create_domain.sh /u01/install/create_domain.sh
ADD https://raw.githubusercontent.com/iwanttobefreak/weblogic/master/scrics/install/create_domain.py /u01/install/create_domain.py
ADD https://github.com/magic-chenyang/testone/releases/download/1.0/jdk-6u45-linux-x64.bin /u01/install/jdk-6u45-linux-x64.bin
ADD https://github.com/magic-chenyang/testone/releases/download/1.0/wls1036_generic.jar /u01/install/wls1036_generic.jar
RUN chmod +x /u01/install/install_weblogic1036.sh
RUN chmod +x /u01/install/create_domain.sh
RUN chmod +x /u01/scripts/start_nodemanager.sh
RUN chmod +x /u01/scripts/start_AdminServer.sh
RUN chmod +x /u01/scripts/start_ALL.sh
RUN chmod +x /u01/install/jdk-6u45-linux-x64.bin
RUN chmod +x /u01/install/wls1036_generic.jar

# USER
#RUN groupadd -g 1001 weblogic && useradd -u 1001 -g weblogic weblogic
#RUN mkdir -p /u01/install && mkdir -p /u01/scripts
#RUN chown -R weblogic. /u01
#USER weblogic

ENV USER_MEM_ARGS="-Djava.security.egd=file:/dev/./urandom"

RUN cd /u01/install && /u01/install/install_weblogic1036.sh

RUN cd /u01/install && /u01/scripts/start_AdminServer.sh && ./create_domain.sh create_domain.ini /u01/middleware1036/wlserver_10.3/server/bin/setWLSEnv.sh

#Esborrem programari d'instalacio
RUN rm -f /u01/install/*

CMD ["/u01/scripts/start_ALL.sh"]
