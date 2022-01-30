currentBuild.displayName = "Caltech_Capestone-Project-3_B-Safe_Job#"+currentBuild.number

node('Slave-01') {
    
        def mvnHome = tool name: 'Apache_Maven_3.5.2', type: 'maven'    
        def mvnCMD = "${mvnHome}/bin/mvn"
    
    stage('Clean Up') {

        deleteDir()
    }
    
    
    stage('Git Checkout') {
 
        git credentialsId: 'SSH_Git-Jenkins', url: 'git@github.com:mytutes-github/Caltech_Capestone-Project-3_B-Safe.git'

    }
    
     stage('Maven Package') {
          
        sh "${mvnCMD} clean package"
        
    }
    
    stage('Maven Test') {
          
        sh "${mvnCMD} test"
        
    }
    
    
    stage('Tomcat Dependencies') {
 
    sh '''echo  "mv /usr/local/tomcat/webapps /usr/local/tomcat/webapps2"  >>  script.sh
          echo  "mv /usr/local/tomcat/webapps.dist/ /usr/local/tomcat/webapps"  >>  script.sh
          echo  "mv /usr/local/tomcat/webapps2/* /usr/local/tomcat/webapps"  >>  script.sh'''

    }
    
    stage('Build Docker Image'){

    sh 'docker build -t mydevopslabs/my-app:0.0.1 .'

  }
  

  stage('Upload Image to DockerHub'){

    withCredentials([string(credentialsId: 'DockerHubAccessToken', variable: 'DockerHubAccessToken')]) {
    
    sh "docker login -u mydevopslabs -p ${DockerHubAccessToken}"
    
    }

    sh 'docker push mydevopslabs/my-app:0.0.1'
  }
  
}

node('Ansible-Controller') {

stage('Ansible-Playbook Execution'){
 
   deleteDir()
   git credentialsId: 'SSH_Git-Jenkins', url: 'git@github.com:mytutes-github/Caltech_Capestone-Project-3_B-Safe.git'
   ansiblePlaybook credentialsId: 'Ansible-CICD', disableHostKeyChecking: true, installation: 'Ansible2', inventory: 'deploy.inv', playbook: 'deploy-docker.yml'
   
    }
}
