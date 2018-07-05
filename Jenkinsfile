pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh 'mvn -B -DskipTests clean package'
      }
    }
    stage('deploy') {
        steps {
            sh 'chmod 777 *.sh'
            sh './deploy.sh'
        }
    }
  }
}