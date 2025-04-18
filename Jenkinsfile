pipeline {
    agent any
    
    environment {
        CONTEXT_NAME = 'jenkins-remote-1'  // ชื่อ Docker context สำหรับการเชื่อมต่อ SSH
        COMPOSE_FILE = '/mnt/data/docker-compose.yml' // ที่อยู่ไฟล์ docker-compose.yml ของคุณ
    }

    stages {
        stage('Pull Docker Images') {
            steps {
                script {
                    echo "📥 กำลังดึง Docker images จากเครื่องปลายทาง..."
                    sh "docker --context $CONTEXT_NAME run --rm -v $COMPOSE_FILE:/docker-compose.yml docker-compose pull"
                }
            }
        }

        stage('Start Containers') {
            steps {
                script {
                    echo "🚀 กำลังเริ่ม Docker containers..."
                    sh "docker --context $CONTEXT_NAME run --rm -v $COMPOSE_FILE:/docker-compose.yml docker-compose up -d"
                }
            }
        }

        stage('Health Check') {
            steps {
                script {
                    echo "✅ กำลังตรวจสอบสถานะสุขภาพของบริการ..."
                    sh "docker --context $CONTEXT_NAME ps -a"
                }
            }
        }

        stage('Cleanup') {
            steps {
                script {
                    echo "🧹 กำลังทำความสะอาด container ที่ไม่ได้ใช้..."
                    sh "docker --context $CONTEXT_NAME run --rm -v $COMPOSE_FILE:/docker-compose.yml docker-compose down"
                }
            }
        }
    }

    post {
        always {
            echo "✅ งาน Docker Compose เสร็จสิ้น!"
        }
        success {
            echo "🎉 Pipeline ทำงานสำเร็จ!"
        }
        failure {
            echo "❌ Pipeline ล้มเหลว, โปรดตรวจสอบบันทึกข้อผิดพลาด."
        }
    }
}
