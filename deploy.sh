docker build -t killerbugs/multi-client:latest -t killerbugs/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t killerbugs/multi-server:latest -t killerbugs/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t killerbugs/multi-worker:latest -t killerbugs/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push killerbugs/multi-client:latest
docker push killerbugs/multi-server:latest
docker push killerbugs/multi-worker:latest
docker push killerbugs/multi-client:$SHA
docker push killerbugs/multi-server:$SHA
docker push killerbugs/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=killerbugs/multi-client:$SHA
kubectl set image deployments/server-deployment server=killerbugs/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=killerbugs/multi-worker:$SHA