FROM openjdk:8u131-jdk-alpine
#OpenJDK 7 would not negotiate JNLP
ENV REMOTING_VERSION "3.9"
ENV USERNAME docker
WORKDIR /home/${USERNAME}

#This is a hardcoded Docker Group ID for the AWS ECS Optimised AMI
RUN addgroup -g 497 docker && \
	echo http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
	apk --no-cache add shadow  && \
	adduser ${USERNAME} -S  && \
	usermod -a -G docker,wheel,root,ping ${USERNAME} && \
 	apk --update add curl docker git openssh-client aws-cli && \ 
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




