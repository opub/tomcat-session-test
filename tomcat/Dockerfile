# CentOS container with Java 8 and Tomcat 7 for session replication testing
FROM centos
LABEL maintainer="ted@opub.com"

# NB: this part is quite fragile as it requires the version to be available on the mirror below
ENV TOMCAT_VERSION 7.0.93
ENV TOMCAT_MAJOR 7

# setup environment
ENV CATALINA_HOME /opt/tomcat 
ENV PATH $PATH:$CATALINA_HOME/bin
ENV JAVA_OPTS -Dorg.apache.catalina.session.StandardSession.ACTIVITY_CHECK=true

# install prereqs
RUN yum -y install wget tar java-1.8.0-openjdk

# install tomcat
RUN wget -q -N http://mirror.linux-ia64.org/apache/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
 mkdir -p ${CATALINA_HOME} && \
 tar -xvf apache-tomcat-${TOMCAT_VERSION}.tar.gz --strip-components=1 --directory ${CATALINA_HOME} && \
 rm -f apache-tomcat-${TOMCAT_VERSION}.tar.gz

# custom configs with session setup
COPY server.xml ${CATALINA_HOME}/conf/server.xml

# custom home page with session details
COPY index.jsp ${CATALINA_HOME}/webapps/ROOT/index.jsp

# create tomcat user
RUN groupadd -r tomcat && \
 useradd -g tomcat -d ${CATALINA_HOME} -s /sbin/nologin  -c "Tomcat User" tomcat && \
 chown -R tomcat:tomcat ${CATALINA_HOME}

# start tomcat
WORKDIR /opt/tomcat
EXPOSE 8080
EXPOSE 8009
USER tomcat
CMD ["catalina.sh", "run"]
