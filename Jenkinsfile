pipeline {
    agent {
        docker { image 'ruby:3.2.4-alpine' }
    }
    stages {
        stage('Test') {
            steps {
                sh 'ruby --version'
            }
        }
    }
}