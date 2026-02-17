# Google-Infra

**1. Create VM on GCP & Install Jenkins & terraform and Install Plugins on Jenkins:**

**1.1. Install Terraform from official documentation:**

```
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

- Install these plugins on jenkins: **terraform, blueocean, pipeline stage view**

- In **Jenkins Tools** Provide **Terraform Path**:

- On VM first hit this command:  ```which terraform```

![Screenshot 2025-03-09 211139](https://github.com/user-attachments/assets/6aa89356-4568-4d01-84bd-3a7359fac2a5)


**2. Create ```GCP IAM Service Account Credentails``` & Provide on ```GCP Credentails``` as (secret file)**

**2.1. Also ```Provide GCP Account ID``` on ```Jenkins Credentails``` as (secret text)**

**3. Create a Jenkins Pipeline**

```
pipeline {
    agent any
    environment {
        GOOGLE_APPLICATION_CREDENTIALS = credentials('gcp-service-account')
    }
    parameters {
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Choose action: apply to create resources, destroy to delete them')
    }
    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/vijaygiduthuri/test-repo.git'
            }
        }
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform Plan') {
            when { expression { params.ACTION == 'apply' } }
            steps {
                sh 'terraform plan'
            }
        }
        stage('Terraform Apply') {
            when { expression { params.ACTION == 'apply' } }
            steps {
                sh 'terraform apply --auto-approve'
            }
        }
        stage('Terraform Destroy') {
            when { expression { params.ACTION == 'destroy' } }
            steps {
                sh 'terraform destroy --auto-approve'
            }
        }
    }
}

```

**1. Adds a Jenkins parameter (ACTION)**

- Default options: ```apply``` (to create resources) and ```destroy``` (to delete them).

**2. Terraform Apply**

- Runs only if ACTION == ```apply```.

**3. Terraform Destroy**

- Runs only if ACTION == ```destroy```.

![Screenshot 2025-03-09 214118](https://github.com/user-attachments/assets/c774e776-5373-4d66-8204-e223d9ee260e)

# How to Use It

**1️⃣ Running Apply (Provision Resources)**

- In Jenkins, **run the pipeline normally**, selecting ```apply``` in the dropdown.
- This will **create/update** infrastructure.

**2️⃣ Running Destroy (Delete Resources)**

- In Jenkins, **manually trigger the build** and select ```destroy```.
- Terraform will **remove all provisioned resources**.
