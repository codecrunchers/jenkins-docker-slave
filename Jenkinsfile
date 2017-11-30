node('docker_slave') {
    stage("Checkout") {
        checkout([$class: 'GitSCM', branches: [
            [name: '*/master']
        ], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [
            [credentialsId: 'git', url: 'git@github.com:Plnt9/jenkins-docker-slave.git']
        ]])

    }

    stage('Prep') {
        def customImage = docker.build("planet9/docker-slave")
    }

    stage('Deploy') {
        sh '$(aws ecr get-login --no-include-email --region eu-west-1)'
        sh 'docker tag planet9/docker-slave:latest 234585392744.dkr.ecr.eu-west-1.amazonaws.com/prod-pipeline/docker-slave:latest'
        sh 'docker push 234585392744.dkr.ecr.eu-west-1.amazonaws.com/prod-pipeline/docker-slave:latest'
    }
}
