FROM tomcat:jdk17-temurin-jammy
USER root
ENV TZ=America/Recife
#ENV CATALINA_OPTS="-Xms4096M -Xmx4096M"
ENV CATALINA_OPTS="-Xms3072M -Xmx3072M"
RUN  rm -rf /usr/local/tomcat/webapps/ROOT && mv /usr/local/tomcat/webapps/ /usr/local/tomcat/webapps2/ && mv /usr/local/tomcat/webapps.dist/ /usr/local/tomcat/webapps/ && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN mkdir /usr/local/tomcat/webapps/ROOT/WEB-INF/chromedriver/
#COPY chromedriver.exe /usr/local/tomcat/webapps/ROOT/WEB-INF/chromedriver/
COPY tomcat-users.xml /usr/local/tomcat/conf/
COPY context.xml /usr/local/tomcat/webapps/manager/META-INF/
COPY beta.war /usr/local/tomcat/webapps/
CMD ["catalina.sh","run"]

## Certificado Webhook Itaú:
COPY ca-itau.pem  /usr/local/tomcat/webapps/ROOT/WEB-INF/certificado/
#COPY ca-cert  /usr/local/tomcat/webapps/ROOT/WEB-INF/certificado/

## Certificado Webhook Santander:
#COPY webhook.santander.com.br.cer  /usr/local/tomcat/webapps/ROOT/WEB-INF/certificado/
