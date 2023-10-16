SERVICE_NAME=kubernetes

POSTGRES_PASSWORD=$(kubectl get secret --namespace default $SERVICE_NAME-postgresql -o jsonpath="{.data.postgres-password}" | base64 -d)

kubectl port-forward --namespace default svc/$SERVICE_NAME-postgresql 5432:5432 &
PGPASSWORD=$POSTGRES_PASSWORD psql --host 127.0.0.1 -U postgres -d postgres -p 5432 < ./db/1_create_tables.sql &&\
PGPASSWORD=$POSTGRES_PASSWORD psql --host 127.0.0.1 -U postgres -d postgres -p 5432 < ./db/2_seed_users.sql &&\
PGPASSWORD=$POSTGRES_PASSWORD psql --host 127.0.0.1 -U postgres -d postgres -p 5432 < ./db/3_seed_tokens.sql

DB_USERNAME=admin DB_PASSWORD=$POSTGRES_PASSWORD python app.py