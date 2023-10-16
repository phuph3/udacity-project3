#Set up Bitnami Repo
helm repo add udacity-project3-repo https://charts.bitnami.com/bitnami

#Install PostgreSQL Helm Chart
helm install udacity-project3-service udacity-project3-repo/postgresql