docker build -t rmaznytsia/multi-client:latest -t rmaznytsia/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rmaznytsia/multi-server:latest -t rmaznytsia/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rmaznytsia/multi-worker:latest -t rmaznytsia/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rmaznytsia/multi-client:latest
docker push rmaznytsia/multi-server:latest
docker push rmaznytsia/multi-worker:latest

docker push rmaznytsia/multi-client:$SHA
docker push rmaznytsia/multi-server:$SHA
docker push rmaznytsia/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/client-deployment client=rmaznytsia/multi-client:$SHA
kubectl set image deployment/server-deployment server=rmaznytsia/multi-server:$SHA
kubectl set image deployment/worker-deployment worker=rmaznytsia/multi-worker:$SHA

