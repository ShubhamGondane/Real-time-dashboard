## This project is a real time dashboard application that scrapes web pages and runs the NLP pipeline on the collected data. We can see the tags, authors statistics on the dashboard which we can access in our browsers. This entire application runs on Kubernetes cluster. We create 3 different docker containers each specialized for crawling, NLP and dashboard display.

### Intialize project name
`export PROJECT_ID=<Your Project Name>`

### Command to create a container on gcloud
`gcloud beta container --project ${PROJECT_ID} clusters create "combined" --zone "us-central1-a" --no-enable-basic-auth --cluster-version "1.14.10-gke.27" --machine-type "n1-standard-1" --image-type "COS" --disk-type "pd-standard" --disk-size "100" --metadata disable-legacy-endpoints=true --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" --num-nodes "2" --enable-cloud-logging --enable-cloud-monitoring --enable-ip-alias --network "projects/${PROJECT_ID}/global/networks/default" --subnetwork "projects/${PROJECT_ID}/regions/us-central1/subnetworks/default" --default-max-pods-per-node "110" --enable-autoscaling --min-nodes "2" --max-nodes "8" --addons HorizontalPodAutoscaling,HttpLoadBalancing --no-enable-autoupgrade --enable-autorepair`

### Once you run the create_crawler_script.sh to see progress of any crawler

`kubectl logs <crawler-pod-name>`

### To scale up
kubectl scale deployment selenium-node-firefox --replicas=10

### Run the following script files in order
1. create_crawler.sh
This file creates our selenium grid to scrape the webpages and store the data in the google datastore

2. run_nlp.sh
This file runs the SparkNLP Pipeline to basic preprocssing and entity tagging and stores the result in BigQuery

3. run_dashboard.sh
This file creates the final dashboard that will displayed at the address:
http://<External IP address given in the output of this script>/dash/