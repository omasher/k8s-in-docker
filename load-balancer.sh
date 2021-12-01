 # 1. Install sipcalc.

# Use sipcalc to determine the range of IP addresses that MetalLB will use as 
# the pool from which external IP addresses will be assigned
sudo apt install sipcalc -y

# 2. Installing MetalLB (https://metallb.universe.tf/)

# Install the required Kubernetes namespace.

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.4/manifests/namespace.yaml

# Install MetalLB.

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.4/manifests/metallb.yaml

# Install the required Kubernetes secret.

kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

# 3. Determining an IP address range
# Find out the IP addresses being used by the nodes in the Kubernetes cluster.

kubectl get nodes -o wide

# Find the CIDR of the bridge into the cluster.

ip a s

# Use the sipcalc tool to find the range of IP addresses that MetalLB can use.

sipcalc 172.19.0.1/16 # Discovered using ip a s

# 4. Creating the MetalLB ConfigMap

# Apply the ConfigMap to the Kubernetes cluster.

kubectl apply -f metallb-config.yaml

# 5. Installing the Kubernetes Application
# Create a Kubernetes deployment with 3 replica pods.

kubectl create deploy nginx --replicas=3 --image nginx

# Verify the pods have been created.

kubectl get pods

# Create the service of type LoadBalancer and bind it to the pods.

kubectl expose deploy nginx --port 80 --type LoadBalancer

# Verify the pods have been created.

kubectl get service

# Accessing the Kubernetes Application

# Get the external IP address.

kubectl get services

# Call the service based on the external IP address assigned by the load balancer, in this case:

curl EXTERNAL_IP_ADDR