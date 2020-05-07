# Intialize project
export PROJECT_ID=<Your Project Name>

# Build the docker image
cd Crawler

docker build -t gcr.io/${PROJECT_ID}/crawler-image .

# Push the image to container registry
docker push gcr.io/${PROJECT_ID}/crawler-image

# Create selenium grid on the cluster
bash StartSelenium.sh

# Wait for the service to be up and running
sleep 60s

# Get the pod details
kubectl get pods

# Start the nodes to crawl data
bash StartCrawler.sh

# Wait for nodes to be up and running
sleep 60s

# Get the current details
kubectl get pods