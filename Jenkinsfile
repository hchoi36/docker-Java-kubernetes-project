def TF = "EC2"

pipeline {
    agent {
        label 'workernode2'
        //label 'worker_terraform'
    }

    stages {
        stage('Checkout') {
            steps {
                // Get some code from a GitHub repository
                checkout([$class: 'GitSCM', branches: [[name: '*/AD-7']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/hchoi36/docker-Java-kubernetes-project.git']]])
        
            }
        }  

        
        stage('Maven') {
            steps {
                dir("${WORKSPACE}/productcatalogue") {
                sh 'mvn clean install'
                }
            }
        }

        stage('Docker_build') {
            steps {
                dir("${WORKSPACE}/productcatalogue") {
                sh 'docker build -t hchoi36/demo:v1 .'
                }
            }
        }

        stage('Docker_push') {
            steps {
                script {
                    docker.withRegistry( 'https://registry.hub.docker.com', docker_registry ) {
                    sh 'docker push hchoi36/demo:v1'
                }
            }
        }
        
     }  
      
    }
}
