pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh 'mvn -B -DskipTests clean package'
        sh 'sshpass -p w123456w ssh root@118.24.99.216'
      }
    }
  }
}