pipeline {
    agent any

    environment {
        DOCKER_USERNAME = "janakdasari"
        DOCKER_IMAGE = "janakdasari/prt-cicd:latest"
    }

    stages {

        stage('Pull Code from Git') {
            steps {
                git branch: 'main',
                    url: 'YOUR_GITHUB_REPOSITORY_URL'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    docker build -t $DOCKER_IMAGE .
                '''
            }
        }

        stage('Push Docker Image') {
            steps {
                sh '''
                    echo "Logging in to Docker Hub..."
                    echo "$DOCKER_PASSWORD" | docker login \
                        -u "$DOCKER_USERNAME" \
                        --password-stdin

                    docker push $DOCKER_IMAGE

                    docker logout
                '''
            }
        }

        stage('CI/CD Completed') {
            steps {
                echo 'PRT - CI/CD Completed Successfully'
            }
        }
    }
}
