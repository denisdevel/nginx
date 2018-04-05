pipeline {

  stages {
        stage('Test') {
            steps {
    		git 'https://github.com/denisdevel/nginx
		}
	}

    
    stage ('Build') {
	steps { 
        	def app = docker.build "najar/nginx"
	}
		}
    
   
    stage ('Publish')
	{ 
	steps {

        withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'dockerHubPassword', usernameVariable: 'najar')]) {
            app.push 'latest'
			}
        	}  
   	}
}
}
