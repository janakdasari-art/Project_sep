pipeline {
    agent { label 'ci-agent' }

    environment {
        IMAGE = 'janakdasari/prt-cicd:latest'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/janakdasari-art/Project_sep.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-credentials',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push $IMAGE
                        docker logout
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'PRT - CI/CD Completed Successfully'
        }
    }
} 
