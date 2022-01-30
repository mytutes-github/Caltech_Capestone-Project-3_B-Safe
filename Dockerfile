FROM tomcat:8

COPY target/*.war /usr/local/tomcat/webapps/dockeransible.war

# Use Tomcat Version 8 as the base image
FROM tomcat:8

LABEL app=XYZ
# Workacound for Tomcat
RUN sed -i 's/port="8080"/port="4287"/' ${CATALINA_HOME}/conf/server.xml
CMD ["catalina.sh", "run"]

#Take the war and copy to webapps of tomcat
COPY target/*.war /usr/local/tomcat/webapps/home.war

# Tomcat Dependencies
RUN mkdir -p /scripts
COPY script.sh /scripts
WORKDIR /scripts
RUN chmod +x script.sh
RUN ./script.sh