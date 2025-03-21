gcloud compute networks create taw-custom-network --subnet-mode custom

gcloud compute networks subnets create subnet-us-central \
   --network taw-custom-network \
   --region us-central1 \
   --range 10.0.0.0/16

gcloud compute networks subnets create subnet-europe-west \
   --network taw-custom-network \
   --region europe-west1 \
   --range 10.1.0.0/16

gcloud compute networks subnets create subnet-asia-east \
   --network taw-custom-network \
   --region asia-east1 \
   --range 10.2.0.0/16

gcloud compute firewall-rules create nw101-allow-http \
--allow tcp:80 --network taw-custom-network --source-ranges 0.0.0.0/0 \
--target-tags http

gcloud compute firewall-rules create "nw101-allow-icmp" --allow icmp --network "taw-custom-network" --target-tags rules

gcloud compute firewall-rules create "nw101-allow-internal" --allow tcp:0-65535,udp:0-65535,icmp --network "taw-custom-network" --source-ranges "10.0.0.0/16","10.2.0.0/16","10.1.0.0/16"

gcloud compute firewall-rules create "nw101-allow-ssh" --allow tcp:22 --network "taw-custom-network" --target-tags "ssh"

gcloud compute firewall-rules create "nw101-allow-rdp" --allow tcp:3389 --network "taw-custom-network"

gcloud compute instances create us-test-01 \
--subnet subnet-us-central \
--zone us-central1-a \
 --machine-type=e2-medium \
--tags ssh,http,rules

gcloud compute instances create europe-test-01 \
--subnet subnet-europe-west \
--zone europe-west1-b \
--tags ssh,http,rules

gcloud compute instances create asia-test-01 \
--subnet subnet-asia-east \
--zone asia-east1-a \
--machine-type e2-medium \
--tags ssh,http,rules
