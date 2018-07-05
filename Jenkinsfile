pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh 'mvn -B -DskipTests clean package'
        sh 'echo "ssh start"'
        sh 'sshpass -p w123456w ssh -t -t root@118.24.99.216'
        sh 'echo "ssh end"'
      }
    }
  }
}