def TF = "EC2"

pipeline {
    agent {
        label 'workernode2'
        //label 'worker_terraform'
    }
    tools {
        terraform 'tf_test'
        }

    stages {
        stage('Checkout') {
            steps {
                // Get some code from a GitHub repository
                checkout([$class: 'GitSCM', branches: [[name: '*/AD-6']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/xiaotinglian/cloud-native-microservice-strangler.git']]])
        
            }
        }  

        
        stage('terraform') {
            steps {
                dir("${WORKSPACE}/terraform/${TF}") {
                sh 'ls'
                sh 'pwd'
                sh 'terraform init'
                }
            }
        }
        
        stage("plan") {
          steps {
            withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws_credentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    dir("${WORKSPACE}/terraform/${TF}") {
                    sh 'terraform plan'
                    }
            }
          }
        }
        
        stage("apply") {
          steps {
            withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws_credentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    dir("${WORKSPACE}/terraform/${TF}") {
                    sh 'terraform apply --auto-approve'
                    }
            }
          }
        }
      
        stage("destroy") {
          input {
            message "Ready to destroy?"
            ok "Yes"
          }
          
          steps {
            withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws_credentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    dir("${WORKSPACE}/terraform/${TF}") {
                    sh 'terraform destroy --auto-approve'
                    }
            }
          }
        }
      
    }
}
          
