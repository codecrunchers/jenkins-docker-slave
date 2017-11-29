FROM openjdk:8u131-jdk-alpine
ENV REMOTING_VERSION "3.9"
ENV USERNAME docker

RUN adduser ${USERNAME} -S -G wheel -G ping
WORKDIR /home/${USERNAME}
RUN apk --update add curl docker git && \ 
        mkdir -p /home/${USERNAME}/jenkins_agent && \
        chmod 755 /home/${USERNAME}/jenkins_agent && \ 
	mkdir work && \
        chmod 777 /home/${USERNAME}/work && \
        chown ${USERNAME} /home/${USERNAME}/work -R && \
        curl --create-dirs -sSLo /home/${USERNAME}/jenkins_agent/slave.jar \
        http://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${REMOTING_VERSION}/remoting-${REMOTING_VERSION}.jar && \
        chmod 644 /home/${USERNAME}/jenkins_agent/slave.jar && \
        chown ${USERNAME} /home/${USERNAME}/jenkins_agent -R


USER ${USERNAME}
#for Sonar
ENTRYPOINT ["java", "-cp", "/home/docker/jenkins_agent/slave.jar", "hudson.remoting.jnlp.Main","-headless"]
#CMD ["--help"]
#ENTRYPOINT ["/bin/sh"]




