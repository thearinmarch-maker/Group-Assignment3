pipeline {
    agent any

    environment {
        DOCKER_HUB_USER = 'YOUR_DOCKERHUB_USERNAME'
        MANAGER_IP      = 'YOUR_MANAGER_PUBLIC_IP'
        TELEGRAM_TOKEN  = credentials('TELEGRAM_BOT_TOKEN')
        TELEGRAM_CHAT   = credentials('TELEGRAM_CHAT_ID')
    }

    stages {
        stage('Build') {
            steps {
                sh '''
                    docker build -t /custom-nginx:latest ./nginx
                    docker build -t /backend-service:latest ./services/backend
                '''
            }
        }

        stage('Test') {
            steps {
                sh 'docker run --rm /backend-service:latest npm test'
            }
        }

        stage('Push to Registry') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'DOCKERHUB_CREDENTIALS', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh '''
                        echo "" | docker login -u "" --password-stdin
                        docker push /custom-nginx:latest
                        docker push /backend-service:latest
                    '''
                }
            }
        }

        stage('Deploy to Swarm') {
            steps {
                sshagent(['SWARM_SSH_KEY']) {
                    sh '''
                        scp -o StrictHostKeyChecking=no docker-stack.yml ubuntu@:~/docker-stack.yml
                        ssh -o StrictHostKeyChecking=no ubuntu@ "DOCKER_HUB_USER= docker stack deploy -c ~/docker-stack.yml assignment3_stack"
                    '''
                }
            }
        }
    }

    post {
        success {
            sh '''
                curl -s -X POST "https://api.telegram.org/bot/sendMessage" \
                -d chat_id="" \
                -d text="✅ Build Success: Job '' (#) deployed successfully!"
            '''
        }
        failure {
            sh '''
                curl -s -X POST "https://api.telegram.org/bot/sendMessage" \
                -d chat_id="" \
                -d text="❌ Build Failed: Job '' (#) failed. Check console output."
            '''
        }
    }
}
