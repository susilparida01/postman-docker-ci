pipeline {
    agent any

    environment {
        IMAGE_NAME = "postman-newman-tests"
    }

    stages {

        stage('Checkout from GitHub') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/susilparida01/postman-docker-ci.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %IMAGE_NAME% .'
            }
        }

        stage('Run Newman Tests') {
            steps {
                bat '''
                if not exist reports mkdir reports
                docker run --rm ^
                -v %WORKSPACE%\\reports:/etc/newman/reports ^
                %IMAGE_NAME%
                '''
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'reports/*.html', fingerprint: true
            echo 'API test execution finished'
        }
        success {
            echo 'API Tests PASSED ✅'
        }
        failure {
            echo 'API Tests FAILED ❌'
        }
    }
}
