pipeline {
    agent any

    parameters {
            booleanParam(name: 'PLAN_TERRAFORM', defaultValue: false, description: 'Check to plan Terraform changes')
            booleanParam(name: 'APPLY_TERRAFORM', defaultValue: false, description: 'Check to apply Terraform changes')
            booleanParam(name: 'DESTROY_TERRAFORM', defaultValue: false, description: 'Check to apply Terraform changes')
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Clean workspace before cloning (optional)
                deleteDir()

                // Clone the Git repository
                git branch: 'main',
                    url: 'https://github.com/andreaendigital/infraestructure-carPrice.git'

                sh "ls -lart"
            }
        }

        stage('Terraform Init') {
                    steps {
                       withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-crendentails-rwagh']]){
                            dir('infra') {
                            sh 'echo "=================Terraform Init=================="'
                            sh 'terraform init'
                        }
                    }
                }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    if (params.PLAN_TERRAFORM) {
                       withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-crendentails-rwagh']]){
                            dir('infra') {
                                sh 'echo "=================Terraform Plan=================="'
                                sh 'terraform plan'
                            }
                        }
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    if (params.APPLY_TERRAFORM) {
                       withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-crendentails-rwagh']]){
                            dir('infra') {
                                sh 'echo "=================Terraform Apply=================="'
                                sh 'terraform apply -auto-approve'
                            }
                        }
                    }
                }
            }
        }

        stage('Monitor EC2 Setup') {
            steps {
                script {
                    if (params.APPLY_TERRAFORM) {
                        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-crendentails-rwagh']]){
                            dir('infra') {
                                sh 'echo "=================Monitoring EC2 Setup=================="'
                                sh '''
                                    # Get EC2 instance ID
                                    INSTANCE_ID=$(terraform output -raw ec2_public_ip | xargs -I {} aws ec2 describe-instances --region eu-central-1 --filters "Name=ip-address,Values={}" --query "Reservations[0].Instances[0].InstanceId" --output text)
                                    echo "Instance ID: $INSTANCE_ID"
                                    
                                    # Monitor for 3 minutes
                                    for i in {1..6}; do
                                        echo "\n=== Check $i/6 (30s intervals) ==="
                                        echo "Getting console output..."
                                        aws ec2 get-console-output --instance-id $INSTANCE_ID --region eu-central-1 --output text | tail -20
                                        
                                        if [ $i -lt 6 ]; then
                                            echo "Waiting 30 seconds..."
                                            sleep 30
                                        fi
                                    done
                                    
                                    echo "\n=================Setup Complete=================="
                                    echo "Access your app at:"
                                    echo "Direct: http://$(terraform output -raw ec2_public_ip):5000"
                                    echo "ALB: http://$(terraform output -raw alb_dns_name)"
                                '''
                            }
                        }
                    }
                }
            }
        }

        stage('Terraform Destroy') {
            steps {
                script {
                    if (params.DESTROY_TERRAFORM) {
                       withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-crendentails-rwagh']]){
                            dir('infra') {
                                sh 'echo "=================Terraform Destroy=================="'
                                sh 'terraform destroy -auto-approve'
                            }
                        }
                    }
                }
            }
        }
    }
}