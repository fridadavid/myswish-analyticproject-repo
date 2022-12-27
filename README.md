# myswish-analyticproject-repo

TOOL USED IN THIS PROJECT.

Git/Github
Maven
Sonarqube 
Jenkins 
Docker 
Kubernetes 
DockerHub Registry 
Rancher 
New Relic
Vscode 

AWS SERVICES USED

-EC2
  IAM
  EKS
  ELB
  SNS
  CLOUD WATCH
  VPC AND IT COMPONENTS
  ROUTE53
  SECURITY GROUPS
  

- In this project i used a Java based application to build the Docker image: 

          ayukdavidashu/swishanalytics-test:v1.4.0

- The image was build and push to docker hub using a pipeline script in my code.

- I pushed the docker image to my dockerhub account.

-I used terraform to provision production grade EKS cluster to enable me deploy my application.
-Terraform code is made up of:
              . eks module
              . vpc module
              . ec2 module 
              . dnsr module

-I tested and deployed the terraform code. In my project there is a script to automate the deployment of the aws resources.

- To test the terraform code manually you can use this ocmmands
                    . cd into the module before you can run any of the cmds
           . cd vpc
           .ls
           . terraform init
           . terraform  fmt --recursive
           . terraform validate
           . terraform plan --var-file=variable/staging.tfvars
           . terraform apply --var-file=variable/staging.tfvars
           . terraform destroy --var-file=variable/staging.tfvars
- For dnsr. i validated the code, i could not deploy like i did for vpc n others bc my dns name has expired.

- I wrote my kubernetes manifests and deployed to my eks cluster. i was able to access the application. 
- All the manifest files are in the k8s-manifest directory.

-I also installed Rancher in a server, access rancher UI. I imported my aws EKS cluster to Rancher for easy management.

- I answered some of the questions in the task.


 Please i am open to learning new things. if there is any issue some were in my code. i open for corrections because the will help  me to grow. Thanks David. 
           


  
