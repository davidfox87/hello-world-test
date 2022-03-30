pipeline {
    agent any

    environment {
        PULUMI_STACK = "pulumi-aws-hello-world"
    }

    stages {
        stage ('tests, type checking, and linting') {
            
            agent {
                docker {
                    image 'python:3.8'
                }
            }
            stages {
                stage('Package') {
                    steps {
                        sh  ''' pip install pytest flake8 black fastapi uvicorn
                            '''
                    }
                }
                stage('Run unit tests') {
                    steps {
                        sh '''
                            pytest -vvrxXs
                        '''
                    }
                }
                stage('Run linting') {
                    steps {
                        sh '''
                            flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics
                            flake8 . --count --max-complexity=10 --max-line-length=127 --statistics
                            black . --check --diff
                        '''
                    }
                }
                stage('pylint static type checking') {
                    steps {
                        sh '''
                            pylint app/
                        '''
                    }
                }

            }
        }
        

        stage ('Docker Build') {
            steps {
                script {
                    docker_image = docker.build("hello")
                }
            }
        }

        stage ("Install dependencies") {
            steps {
                sh "curl -fsSL https://get.pulumi.com | sh"
                sh "$HOME/.pulumi/bin/pulumi version"
            }
        }
        
        stage('Deploying using Pulumi') {
            steps {
                echo 'Deploying'

                //sh "cd infrastructure"
                //sh "pulumi stack select ${PULUMI_STACK} --cwd infrastructure/"
                //sh "pulumi up --yes --cwd infrastructure/"

            }
        }
    }
    post {
        always {
            echo 'This will always run'
        }
        success {
            echo 'This will run only if successful'
        }
        failure {
            echo 'This will run only if failed'
        }
        unstable {
            echo 'This will run only if the run was marked as unstable'
        }
        changed {
            echo 'This will run only if the state of the Pipeline has changed'
            echo 'For example, if the Pipeline was previously failing but is now successful'
        }
    }
}