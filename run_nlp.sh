# Intialize project
export PROJECT_ID=<Your Project Name>

# Build the docker image
cd Spark-NLP

docker build --tag nlp_explainer_img .

# Push the image to container registry
docker tag nlp_explainer_img gcr.io/$Project/nlp_explainer:latest
docker push gcr.io/$Project/nlp_explainer:latest

# Register redis as a service on the cluster
kubectl create -f redis-master-service.yaml
kubectl create -f redis-master.yaml

# Get the pod details
kubectl get pods

# Establish local connection with the redis service
kubectl port-forward deployment/redis-master 6379 &

# Python script to retrieve data from the cloud Datastore, preprocess it and put it in the queue.
python3 Scheduler.py

# Deploy nlp docker container
kubectl create -f Explainer.yaml

# Get the pod details
kubectl get pods

# Kill port forwarding
pkill kubectl -9

