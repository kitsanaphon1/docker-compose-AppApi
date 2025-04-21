pipeline {
  agent any

  environment {
    COMPOSE_PROJECT_NAME = "sooyaa"
    DOCKER_CONTEXT = "jenkins-remote-1"  // 👉 ใช้ docker context นี้
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'deploy', url: 'https://github.com/kitsanaphon1/docker-compose-AppApi.git'
      }
    }

    stage('Run docker-compose') {
      steps {
        sh '''
          docker --context=$DOCKER_CONTEXT compose down || true
          docker --context=$DOCKER_CONTEXT compose pull
          docker --context=$DOCKER_CONTEXT compose up -d
        '''
      }
    }
  }
}
