pipeline {
    agent any
    
    environment {
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials'
        DOCKER_USERNAME = 'adhyuth18/demo1'
        DOCKER_PASSWORD = 'Adyar@5155'
    }
    
    stages {
        stage('Login to Docker Hub'){
            steps {
                script {
                    // Ensure you're logged in before pushing the image
                    sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password -stdin'
                }
            }
        }    
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }
        
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_USERNAME}/demo-app:${BUILD_NUMBER}")
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', DOCKER_CREDENTIALS_ID) {
                        docker.image("${DOCKER_USERNAME}/demo-app:${BUILD_NUMBER}").push()
                    }
                }
            }
        }
        
        stage('Deploy') {
            steps {
                sh 'docker-compose up -d'
            }
        }
    }
    
    post {
        always {
            sh 'docker-compose down'
        }
    }
}
