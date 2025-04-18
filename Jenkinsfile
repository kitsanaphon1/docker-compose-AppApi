pipeline {
    agent any

    environment {
        // กำหนดตัวแปร Docker Compose file และ Docker context
        DOCKER_COMPOSE_FILE = 'docker-compose.yml'
        DOCKER_CONTEXT = 'jenkins-remote-1' // ใช้ Docker context ที่ตั้งชื่อว่า jenkins-remote-1
    }

    stages {
        stage('Checkout') {
            steps {
                // ดึงโค้ดจาก Git repository
                checkout scm
            }
        }

        stage('Set Docker Context') {
            steps {
                script {
                    // เลือก docker context ที่ต้องการใช้งาน
                    sh "docker context use ${DOCKER_CONTEXT}"
                }
            }
        }

        stage('Build Docker Images') {
            steps {
                script {
                    // สร้าง Docker images จากไฟล์ Docker Compose
                    sh 'docker-compose -f ${DOCKER_COMPOSE_FILE} build'
                }
            }
        }

        stage('Deploy Services') {
            steps {
                script {
                    // เริ่มต้น services ที่กำหนดใน docker-compose.yml
                    sh 'docker-compose -f ${DOCKER_COMPOSE_FILE} up -d'
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                script {
                    // ตรวจสอบว่า deployment สำเร็จหรือไม่
                    sh 'curl -f http://localhost:5239/health || exit 1' // ตัวอย่าง health check
                }
            }
        }
    }

    post {
        always {
            // ทำความสะอาด workspace หลังจากการ build เสร็จสิ้น
            cleanWs()
        }
        success {
            echo "Deployment successful!"
        }
        failure {
            echo "Deployment failed!"
        }
    }
}
