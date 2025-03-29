pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'madanneer1995/myapp:latest'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/madanneeraj/centralrepp.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $DOCKER_IMAGE .'
                }
            }
        }

        stage('Login to DockerHub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh 'docker login -u $DOCKER_USER -p $DOCKER_PASS'
                    }
                }
            }
        }

        stage('Push Docker Image to DockerHub') {
            steps {
                script {
                    sh 'docker push $DOCKER_IMAGE'
                }
            }
        }

        stage('Deploy on Remote Server') {
            steps {
                script {
                    sshagent(['ssh-key']) {
                        sh '''
                        ssh -o StrictHostKeyChecking=no ubuntu@13.232.105.228 << EOF
                        docker pull $DOCKER_IMAGE
                        docker stop myapp || true
                        docker rm myapp || true
                        docker run -d -p 9090:80 --name myapp $DOCKER_IMAGE
                        EOF
                        '''
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment Successful!'
        }
        failure {
            echo 'Deployment Failed!'
        }
    }
}
