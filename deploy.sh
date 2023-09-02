docker build -t notabotnot/multi-client:latest -t notabotnot/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t notabotnot/multi-server:latest -t notabotnot/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t notabotnot/multi-worker:latest -t notabotnot/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push notabotnot/multi-client:latest
docker push notabotnot/multi-client:$SHA

docker push notabotnot/multi-server:latest
docker push notabotnot/multi-server:$SHA

docker push notabotnot/multi-worker:latest
docker push notabotnot/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=notabotnot/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=notabotnot/multi-worker:$SHA
kubectl set image deployments/client-deployment client=notabotnot/multi-client:$SHA