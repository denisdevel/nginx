pipeline {
    agent any
    node {

    git 'https://github.com/denisdevel/nginx'

    
    stage "build" 
        def app = docker.build "najar/nginx"
    
   
    stage "publish" 
        withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'dockerHubPassword', usernameVariable: 'najar')]) {
            app.push 'latest'
        }  
   }
}
