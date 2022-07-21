Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$PSDefaultParameterValues['*:ErrorAction']='Stop'
function ThrowOnNativeFailure {
    if (-not $?)
    {
        throw 'Native Failure'
    }
}
$nocache=""
if($args.count -gt 0){
    $nocache=$args[0]
}
docker build -t hub.docker.internal:5000/ikomida/rabbitmq-image:latest . $nocache
ThrowOnNativeFailure
docker push hub.docker.internal:5000/ikomida/rabbitmq-image:latest
docker pull hub.docker.internal:5000/ikomida/rabbitmq-image:latest
kubectl -n ikomida delete StatefulSet rabbitmq-microservice
kubectl apply -f ./k8s-dev/deployment.yaml
kubectl apply -f ./k8s-dev/service.yaml