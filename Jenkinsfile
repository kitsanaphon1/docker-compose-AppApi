pipeline {
  agent any

  environment {
    COMPOSE_PROJECT_NAME = "sooyaa"
    DOCKER_CONTEXT = "jenkins-remote"
    DEPLOY_MODE = "down" // 👉 เปลี่ยนเป็น "down" ถ้าต้องการหยุด service
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'deploy', url: 'https://github.com/kitsanaphon1/docker-compose-AppApi.git'
      }
    }

    stage('Docker Compose Action') {
      steps {
        script {
          if (env.DEPLOY_MODE == 'up') {
            sh '''
              docker --context=$DOCKER_CONTEXT compose down || true
              docker --context=$DOCKER_CONTEXT compose pull
              docker --context=$DOCKER_CONTEXT compose up -d
            '''
          } else if (env.DEPLOY_MODE == 'down') {
            sh '''
              docker --context=$DOCKER_CONTEXT compose down
            '''
          } else {
            error "Invalid DEPLOY_MODE: ${env.DEPLOY_MODE}"
          }
        }
      }
    }
  }
}
