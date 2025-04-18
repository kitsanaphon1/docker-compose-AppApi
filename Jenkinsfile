pipeline {
    agent any

    environment {
        // กำหนดตัวแปร Docker Compose file
        DOCKER_COMPOSE_FILE = 'docker-compose.yml'
    }

    stages {
        stage('Checkout') {
            steps {
                // ดึงโค้ดจาก Git repository
                checkout scm
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
                    // เริ่มต้น services ตามที่กำหนดใน docker-compose.yml
                    sh 'docker-compose -f ${DOCKER_COMPOSE_FILE} up -d'
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                script {
                    // ตรวจสอบว่า deployment สำเร็จหรือไม่
                    // ตัวอย่างเช่น ตรวจสอบการเชื่อมต่อกับ Web API
                    sh 'curl -f http://localhost:5239/health || exit 1' // เพิ่มการตรวจสอบสุขภาพ (health check)
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
