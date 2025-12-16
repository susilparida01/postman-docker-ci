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
                echo WORKSPACE=%WORKSPACE%

                if not exist "%WORKSPACE%\\reports" mkdir "%WORKSPACE%\\reports"

                echo === BEFORE RUN ===
                dir "%WORKSPACE%\\reports"

                docker run --rm ^
                -v "%WORKSPACE%\\reports:/etc/newman/reports" ^
                postman/newman:alpine ^
                run collections/API-Demo.postman_collection.json ^
                -r cli,html ^
                --reporter-html-export reports/report.html

                echo === AFTER RUN ===
                dir "%WORKSPACE%\\reports"
                '''
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'reports/**', allowEmptyArchive: false
            echo 'API test execution completed'
        }
        success {
            echo 'API Tests PASSED ✅'
        }
        failure {
            echo 'API Tests FAILED ❌'
        }
    }
}
