pipeline {
    agent { label 'ci-agent' }

    environment {
        DOCKER_USERNAME = "janakdasari"
        DOCKER_IMAGE = "janakdasari/prt-cicd:latest"
    }

    stages {

        stage('Pull Code from Git') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/janakdasari-art/Project_sep.git'
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
        withCredentials([usernamePassword(
            credentialsId: 'dockerhub',
            usernameVariable: 'janakdasari',
            passwordVariable: 'dckr_pat_v6QD_JshfDuCo22vGuo1dlKaSYo'
        )]) {
            sh '''
                echo "$DOCKER_PASSWORD" | docker login \
                    -u "$DOCKER_USERNAME" \
                    --password-stdin

                docker push $DOCKER_IMAGE

                docker logout
            '''
        }
    }
}

        stage('CI/CD Completed') {
            steps {
                echo 'PRT - CI/CD Completed Successfully'
            }
        }
    }
}
