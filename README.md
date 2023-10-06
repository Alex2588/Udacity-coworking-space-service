# Udacity | Coworking Space Service
## Tools and technologies used

- AWS CodeBuild
- AWS ECR (Elastic Container Registry)
- AWS EKS
- Helm

## Configuring the database and populating it

You can add the repo with the following command:
`helm repo add <REPO_NAME> https://charts.bitnami.com/bitnami`

Install the postgrsql chart:
`helm install postgresql bitnami/postgresql`

You can export the password by running:
`export POSTGRES_PASSWORD=$(kubectl get secret --namespace default postgresql -o jsonpath="{.data.postgres-password}" | base64 -d)`

To view the password run:
`echo $POSTGRES_PASSWORD`

You can run a port-forwarding and run the queries under the `db` directory to populate the database.
Example of command for port-forwarding:
`kubectl port-forward --namespace default svc/<SERVICE_NAME>-postgresql 5432:5432 &`
`PGPASSWORD="$POSTGRES_PASSWORD" psql --host 127.0.0.1 -U postgres -d postgres -p 5432`
## Deployment Workflow

1. Database Setup with Helm: We kick-start our deployment by initializing a PostgreSQL database using Helm, making it straightforward and reproducible.

2. Image Build and Push: Post our application development; the code is packaged as a Docker container using a Dockerfile. This image is then built and pushed to ECR using AWS CodeBuild.

3. Deployment to EKS: With our Docker image ready in ECR, Kubernetes steps in. Using our defined YAML configurations, we instruct Kubernetes to pull this image and deploy it.

##  Releasing New Builds

1. Code Updates: Make the necessary changes to the codebase and create a merge request. Once the merge request is approved and merged, it will trigger the build of the image and posterior publishing to ECR.

2. Update Kubernetes Deployment: If needed, modify the Kubernetes YAML configurations, especially if there are significant changes like environment variables or new services.

3. Rolling Updates: Kubernetes supports rolling updates to ensure zero downtime. Apply the new configurations, and K8s will handle the rest.

