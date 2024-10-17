# EKS Project with Terraform

This project provides a minimalist yet production-ready foundation for deploying an EKS cluster on AWS using Terraform. It includes a VPC, EKS cluster, and worker nodes, and is automated with GitHub Actions for CI/CD.

## Project Structure

- `.github/workflows/main.yml`: GitHub Actions configuration for CI/CD.
- `main.tf`: Main Terraform configuration.
- `variables.tf`: Variable definitions.
- `outputs.tf`: Project outputs.
- `modules/`: Separate modules for VPC and EKS.
- `README.md`: Project documentation.

## Modules

### VPC Module

- **Description**: Configures a VPC with public and private subnets.
- **Variables**:
  - `vpc_cidr`: CIDR block for the VPC.
  - `public_subnets`: List of public subnets.
  - `private_subnets`: List of private subnets.

### EKS Module

- **Description**: Configures an EKS cluster with managed nodes.
- **Variables**:
  - `cluster_name`: Name of the EKS cluster.
  - `vpc_id`: ID of the VPC.
  - `private_subnets`: Private subnets for the EKS cluster.
  - `instance_type`: Instance type for the nodes (default `t3.medium`).
  - `desired_capacity`: Desired number of nodes (default `2`).

## CI/CD

GitHub Actions is used to automate the deployment of the infrastructure and applications.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- **AWS Account**: You need an AWS account with appropriate permissions to create resources.
- **AWS CLI**: Installed and configured with your AWS credentials.
- **Terraform**: Installed on your local machine. This project is compatible with Terraform version 1.3.0 and later.
- **kubectl**: Installed to interact with your Kubernetes cluster.
- **GitHub Account**: If you plan to use GitHub Actions for CI/CD.

## Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/elliotsecops/eks-terraform.git
   cd eks-terraform
   ```

2. **Initialize Terraform**:
   ```bash
   terraform init
   ```

3. **Plan the Deployment**:
   ```bash
   terraform plan -var="cluster_name=my-production-cluster"
   ```

4. **Apply the Deployment**:
   ```bash
   terraform apply -var="cluster_name=my-production-cluster"
   ```

## Configuration

- **AWS Credentials**: Ensure your AWS credentials are configured correctly. You can set them up using the AWS CLI:
   ```bash
   aws configure
   ```
   Make sure to configure the correct AWS region.

- **Terraform Variables**: Modify the `variables.tf` file or use a `terraform.tfvars` file to set your specific values for variables like `vpc_cidr`, `public_subnets`, etc.

  Example `terraform.tfvars`:
  ```hcl
  cluster_name = "my-dev-cluster"
  desired_capacity = 3
  AWS_REGION = "us-east-1"
  ```

  Apply using the `terraform.tfvars` file:
  ```bash
  terraform apply -var-file=terraform.tfvars
  ```

## Post-Deployment Steps

1. **Verify Cluster**:
   ```bash
   kubectl get nodes
   ```

2. **Deploy Applications**:
   ```bash
   kubectl apply -f path/to/your/application.yaml
   ```

3. **Access the Cluster**:
   After deployment, you can access the cluster using the following command:
   ```bash
   aws eks --region us-east-1 update-kubeconfig --name my-production-cluster
   ```

   After running this command, ensure your kubectl context is set correctly:
   ```bash
   kubectl config use-context arn:aws:eks:us-east-1:123456789012:cluster/my-production-cluster
   ```


## Scaling

- **Auto Scaling**: Configure auto-scaling policies for your EKS cluster to handle varying workloads. Use metrics like CPU and memory to trigger scaling events. Refer to the [AWS Auto Scaling documentation](https://docs.aws.amazon.com/autoscaling/ec2/userguide/what-is-amazon-ec2-auto-scaling.html).

## Security

- **IAM Roles**: Ensure proper IAM roles and policies are in place for your EKS cluster and worker nodes. Refer to the [AWS IAM documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html).
- **Network Security**: Review and configure security groups and network ACLs. Refer to the [AWS VPC documentation](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html).

## Troubleshooting

- **Common Issues**:
  - **Deployment Errors**: Check the Terraform logs for detailed error messages.
  - **Node Joining Issues**: Verify the worker node IAM role and security group configurations.
  - **Access Issues**: Ensure your AWS CLI is configured correctly and your IAM user has the necessary permissions.
  - **kubectl Context**: Ensure your kubectl context is set correctly after running `aws eks update-kubeconfig`.

## Contributing

If you want to contribute to this project, please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes and commit them (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Open a pull request.

Please follow the coding style guidelines and ensure all tests pass before submitting a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

For questions or support, please contact:

- **Email**: elliotsecops@protonmail.com
- **GitHub**: [elliotsecops](https://github.com/elliotsecops)
