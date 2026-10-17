pipeline {
    agent any

    environment {
        APP_NAME = 'nexvion'
        IMAGE_TAG = '1.0'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh 'docker build -t ${APP_NAME}:${IMAGE_TAG} .'
            }
        }

        stage('Test') {
            steps {
                sh 'docker image inspect ${APP_NAME}:${IMAGE_TAG}'
                sh 'test -f index.html'
                sh 'test -f Dockerfile'
            }
        }

        stage('Package') {
            steps {
                sh 'docker tag ${APP_NAME}:${IMAGE_TAG} ${APP_NAME}:latest'
            }
        }
    }
}
