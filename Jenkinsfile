pipeline {
  agent any
  stages {
        stage('Test') {
            steps {
    		git 'https://github.com/denisdevel/nginx'
		}
	}

    
    stage ('Build') {
	steps { 
        	sh  'docker build -t najar/nginx'
		}
	}
    
   
    stage ('Publish')
	{ 
	steps {
		sh 'docker push najar/nginx'
        	}  
   	}
}
}
