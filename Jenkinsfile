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
                    sh "docker --context $CONTEXT_NAME compose -f $COMPOSE_FILE pull"
                }
            }
        }

        stage('Start Containers') {
            steps {
                script {
                    echo "🚀 กำลังเริ่ม Docker containers..."
                    sh "docker --context $CONTEXT_NAME compose -f $COMPOSE_FILE up -d"
                }
            }
        }

        stage('Health Check') {
            steps {
                script {
                    echo "✅ กำลังตรวจสอบสถานะสุขภาพของบริการ..."
                    sh "docker --context $CONTEXT_NAME ps -a"
                    // ถ้าต้องการสามารถเพิ่มขั้นตอนตรวจสุขภาพได้ที่นี่
                }
            }
        }

        stage('Cleanup') {
            steps {
                script {
                    echo "🧹 กำลังทำความสะอาด container ที่ไม่ได้ใช้..."
                    sh "docker --context $CONTEXT_NAME compose -f $COMPOSE_FILE down"
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
