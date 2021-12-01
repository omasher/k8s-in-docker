# 1. Label a node for affinity assignment
# Label the node named kind-worker.

kubectl label nodes kind-worker nodelocation=usa

# Verify the label is applied to the node kind-worker.

kubectl get nodes --show-labels

# 2. Create the deployment manifest file
# The deployment manifest has an attribute, nodeAffinity, which contains the information
# by which the pods will be assigned to nodes that have the label pair nodelocation=usa.

# 3. Apply the deployment manifest

 # Apply the deployment manifest.

kubectl apply -f deployment.yaml

# Verify that the deployment pods are up and running.

kubectl get pods

# View the node location of the pods in the deployment.

kubectl get pod -o wide