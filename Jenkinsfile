pipeline {
    agent any
    
    environment {
        CONTEXT_NAME = 'jenkins-remote-1'  // ชื่อ Docker context สำหรับการเชื่อมต่อ SSH
        COMPOSE_FILE = '/mnt/data/docker-compose.yml' // ที่อยู่ไฟล์ docker-compose.yml ของคุณ
    }

    stages {
        stage('Install Docker Compose') {
            steps {
                script {
                    echo "🔧 กำลังติดตั้ง Docker Compose หากยังไม่ได้ติดตั้ง..."
                    sh '''
                    if ! command -v docker-compose &> /dev/null; then
                        echo "docker-compose ไม่พบ, กำลังติดตั้ง..."
                        sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
                        sudo chmod +x /usr/local/bin/docker-compose
                        echo "ติดตั้ง Docker Compose เสร็จสิ้น"
                    else
                        echo "docker-compose พบแล้ว"
                    fi
                    '''
                }
            }
        }

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
