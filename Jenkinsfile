pipeline {
  agent { label 'agent1' }

  environment {
    ENVIRONMENT = 'dev'
    AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
    AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
  }
  stages {
    stage('Checkout') {
      steps {
        checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/tatnin/final.git']]])
      }
    }

    stage('Init') {
      steps {
       dir("terraform") {
         sh 'terraform init -input=false'
         sh 'terraform workspace select ${ENVIRONMENT} || terraform workspace new ${ENVIRONMENT}'
       }
      }
    }
    stage('Plan') {
      steps {
        dir("terraform") {
          sh "terraform plan -var 'environment=${ENVIRONMENT}' -input=false -no-color -out plantf"
        }
      }
    }

    stage('Approval') {
      steps {
        script {
          input message: "Do you want to apply? "
        }
      }
    }

    stage('Apply') {
      steps {
        dir("terraform") {
          sh "terraform apply -input=false -no-color plantf"
        }
      }
    }
  }
}
