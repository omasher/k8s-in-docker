# 1. Installing kubectl
# Down the kubectl binary
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"

# Change the permissions to make the binary executable.

chmod +x ./kubectl

# Add the binary to the system's path by moving it to the directory

sudo mv ./kubectl /usr/local/bin/kubectl

# Confirm kubectl is properly installed by getting the version number.

kubectl version --client


# 2. Installing KinD  (https://kind.sigs.k8s.io/)

# Download KinD

curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.9.0/kind-linux-amd64 --insecure

# Change the permissions to make the binary executable.

sudo chmod +x ./kind

# Add the binary to the system's path by moving it to the directory

sudo mv ./kind /usr/local/bin/kind

# Confirm kind is properly installed by getting the version number.

kind --version

# 3. Creating a cluster using KinD
# Execute kind against the manifest file kind-config.yaml.

kind create cluster --config kind-config.yaml

# Confirm that you've created the single control plane node and two worker nodes on Kubernetes.

kubectl get nodes

# 4 Installing the multi-pod Kubernetes application

# Create a Kubernetes deployment.

kubectl create deploy nginx --replicas 3 --image nginx

# Inspect to be sure that the pods were created.

kubectl get pods -o wide

# Create and bind the service.

kubectl expose deploy nginx --port 80 --type NodePort

# Inspect to be sure that the service was created.

kubectl get service -o wide

# Determine the IP addresses of the worker nodes.

kubectl get node -o wide

# Make a call to the service against one of the INTERNAL-IP address and the node port described above in Step 4.

curl 172.19.0.2:{NODE_PORT}