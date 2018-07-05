pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh 'mvn -B -DskipTests clean package'
        sh 'echo "ssh start"'
        sh 'echo "ssh end"'
      }
    }
  }
}