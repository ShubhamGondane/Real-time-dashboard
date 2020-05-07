# Intialize project
export PROJECT_ID=<Your Project Name>

# Build the docker image
cd Dashboard
docker build --no-cache -t gcr.io/$Project/dashboard-app:latest .
docker push gcr.io/$Project/dashboard-app:latest

# Create dashboard service
kubectl create -f DashboardPod.yaml

# Check pod details
kubectl get pods -o wide

#Exposing an External IP Address to Access an Application in a Cluster
kubectl expose deployment dashboard-app --type=LoadBalancer --port 80 --target-port 8080

# Display information about the dashboard-app service
kubectl get service dashboard-app

# Get the Ip details
kubectl describe services dashboard-app