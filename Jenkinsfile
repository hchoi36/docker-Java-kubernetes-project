def TF = "EC2"

pipeline {
    agent {
        label 'workernode2'
        //label 'worker_terraform'
    }

    environment {
        DOCKERHUB_CREDENTIALS=credentials('docker_registry')
    }

    stages {
        stage('Checkout') {
            steps {
                // Get some code from a GitHub repository
                checkout([$class: 'GitSCM', branches: [[name: '*/AD-7']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/hchoi36/docker-Java-kubernetes-project.git']]])
        
            }
        }  

        
        stage('Build and package with maven') {
            steps {
                dir("${WORKSPACE}/productcatalogue") {
                sh 'mvn clean install'
                }
            }

            steps {
                dir("${WORKSPACE}/shopfront") {
                sh 'mvn clean install'
                }
            }

            steps {
                dir("${WORKSPACE}/stockmanager") {
                sh 'mvn clean install'
                }
            }
        }

        stage('Build image from Dockerfile') {
            steps {
                dir("${WORKSPACE}/productcatalogue") {
                sh 'docker build -t hchoi36/demo:pc .'
                }
            }

            steps {
                dir("${WORKSPACE}/shopfront") {
                sh 'docker build -t hchoi36/demo:sf .'
                }
            }
            
            steps {
                dir("${WORKSPACE}/stockmanager") {
                sh 'docker build -t hchoi36/demo:sm .'
                }
            }

        }

        
        stage('Login to Docker Hub') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }

        stage('Push image to registry') {
            steps {
                //WithDockerRegistry([credentialsId: "docker_registry", url: "" ]) {
                sh 'docker push hchoi36/demo:pc'
                sh 'docker push hchoi36/demo:sf'
                sh 'docker push hchoi36/demo:sm'
                //}
            }
        }
     
      
    }
   
post{
    always {  
      sh 'docker logout'           
    }      
  }

}
