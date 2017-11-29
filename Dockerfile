FROM openjdk:8u131-jdk-alpine
ENV REMOTING_VERSION "3.9"

RUN adduser jenkins -S -G wheel -G ping
WORKDIR /home/jenkins
RUN apk --update add curl docker && \ 
        mkdir -p /home/jenkins/jenkins_agent && \
        chmod 755 /home/jenkins/jenkins_agent && \ 
	mkdir work && \
        chmod 755 /home/jenkins/work && \
        chown jenkins /home/jenkins/work -R && \
        curl --create-dirs -sSLo /home/jenkins/jenkins_agent/slave.jar \
        http://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${REMOTING_VERSION}/remoting-${REMOTING_VERSION}.jar && \
        chmod 644 /home/jenkins/jenkins_agent/slave.jar && \
        chown jenkins /home/jenkins/jenkins_agent -R


USER jenkins
#for Sonar
ENTRYPOINT ["java", "-cp", "/home/jenkins/jenkins_agent/slave.jar", "hudson.remoting.jnlp.Main","-headless"]
#CMD ["--help"]
ENTRYPOINT ["/bin/sh"]




