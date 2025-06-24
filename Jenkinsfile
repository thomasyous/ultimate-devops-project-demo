pipeline {
  agent any

  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
    DOCKERHUB_USER = 'rajvrk'
    SERVICE_NAME = "${env.JOB_NAME.split('/')[-1]}" // Use repo name as service name
    IMAGE_TAG = "v${env.BUILD_NUMBER}"
  }

  stages {
    stage('Checkout') {
      steps { checkout scm }
    }

    stage('Install & Test') {
      steps {
        script {
          if (fileExists('package.json')) {
            sh 'npm install && npm test || echo "⚠️ No tests found."'
          } else if (fileExists('pom.xml')) {
            sh 'mvn clean install'
          } else if (fileExists('requirements.txt')) {
            sh 'pip install -r requirements.txt && pytest || echo "⚠️ No tests found."'
          } else {
            echo '❓ Unknown build system.'
          }
        }
      }
    }

    stage('Build Docker Image') {
      steps {
        sh """
          docker build -t ${DOCKERHUB_USER}/${SERVICE_NAME}:${IMAGE_TAG} .
          docker tag ${DOCKERHUB_USER}/${SERVICE_NAME}:${IMAGE_TAG} ${DOCKERHUB_USER}/${SERVICE_NAME}:latest
        """
      }
    }

    stage('Push to Docker Hub') {
      steps {
        sh 'echo "$DOCKERHUB_CREDENTIALS_PSW" | docker login -u "$DOCKERHUB_CREDENTIALS_USR" --password-stdin'
        sh "docker push ${DOCKERHUB_USER}/${SERVICE_NAME}:${IMAGE_TAG}"
        sh "docker push ${DOCKERHUB_USER}/${SERVICE_NAME}:latest"
      }
    }

    stage('Deploy to Kubernetes') {
      when { branch 'main' }
      steps {
        echo "🚀 Deploying ${SERVICE_NAME} to Kubernetes..."
        // sh "kubectl apply -f k8s/${SERVICE_NAME}.yaml"
      }
    }
  }

  post {
    always {
      cleanWs()
    }
  }
}
