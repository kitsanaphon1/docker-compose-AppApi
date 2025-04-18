pipeline {
    agent any  // ใช้ตัวแปร agent any เพื่อให้ Jenkins สามารถทำงานบนเครื่องใดก็ได้

    environment {
        DOCKER_CONTEXT = 'jenkins-remote-1'  // Docker Context ที่คุณตั้งไว้
    }

    stages {
        stage('Clone GitHub Repo') {
            steps {
                // ดึง (clone) repository จาก GitHub โดยใช้ข้อมูล credentials ที่กำหนดไว้
                git credentialsId: "${GITHUB_CREDENTIALS_ID}", url: "${GITHUB_REPO_URL}"
            }
        }

        stage('Run Docker Compose') {
            steps {
                script {
                    // ใช้ Docker Context ที่ตั้งค่าไว้และรันคำสั่ง docker-compose ขึ้นมา
                    // ในที่นี้จะรัน docker-compose.yml ที่ดึงมาจาก GitHub
                    sh "docker --context ${DOCKER_CONTEXT} compose -f docker-compose.yml up -d"
                }
            }
        }

        stage('Cleanup') {
            steps {
                // หยุดและลบ container ที่รันอยู่
                sh "docker --context ${DOCKER_CONTEXT} compose down"
            }
        }
    }

    post {
        success {
            echo 'Docker Compose ทำงานสำเร็จ!'
        }
        failure {
            echo 'Docker Compose ล้มเหลว!'
        }
    }
}
