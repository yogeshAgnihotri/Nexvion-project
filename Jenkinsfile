
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

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-credentials',
                    usernameVariable: 'DOCKERHUB_USER',
                    passwordVariable: 'DOCKERHUB_TOKEN'
                )]) {
                    sh '''
                        set -e
                        echo "$DOCKERHUB_TOKEN" | docker login -u "$DOCKERHUB_USER" --password-stdin

                        docker tag ${APP_NAME}:${IMAGE_TAG} "$DOCKERHUB_USER/${APP_NAME}:${IMAGE_TAG}"
                        docker tag ${APP_NAME}:latest "$DOCKERHUB_USER/${APP_NAME}:latest"

                        docker push "$DOCKERHUB_USER/${APP_NAME}:${IMAGE_TAG}"
                        docker push "$DOCKERHUB_USER/${APP_NAME}:latest"

                        docker logout
                    '''
                }
            }
        }
             stage('Deploy to Kubernetes') {
            steps {
                sh '''
                    set -e

                    scp -i /var/lib/jenkins/.ssh/kubernetes-key.pem \
                        -o StrictHostKeyChecking=accept-new \
                        k8s/deployment.yaml k8s/service.yaml \
                        ubuntu@172.31.41.163:/tmp/

                    ssh -i /var/lib/jenkins/.ssh/kubernetes-key.pem \
                        -o StrictHostKeyChecking=accept-new \
                        ubuntu@172.31.41.163 '
                            kubectl apply -f /tmp/service.yaml
                            kubectl apply -f /tmp/deployment.yaml
                            kubectl rollout status deployment/nexvion \
                                -n webapp --timeout=180s
                            kubectl get pods -n webapp
                        '
                '''
            }
        }  
}

}
