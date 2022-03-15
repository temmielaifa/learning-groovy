#!/bin/Groovy
pipeline {
    agent any
    stages {
        stage('Terraform Initialize') {
           
            steps {
                sh 'terraform init'
                
            }
        }
        stage('Create a planfile') {
           
            steps {
                sh 'terraform plan -out planfile'
               
            }
        }
        stage('Execute the Treraform Task') {
           
            steps {
                sh 'terraform apply planfile'
               
            }
        }
         
    }
}
