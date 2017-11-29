# jenkins-docker-slave
Docker Build Slave for Jenkins over jnlp. Provides docker functioanlity for builds

## Work Dir
Use `/home/jenkins/work`

## Required
* --privileged
* -v /var/run/docker.sock:/var/run/docker.sock

