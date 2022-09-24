Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$PSDefaultParameterValues['*:ErrorAction']='Stop'
function ThrowOnNativeFailure {
    if (-not $?)
    {
        throw 'Native Failure'
    }
}
$projectid="ikomida-dev"
if($args.count -gt 0){
    $projectid=$args[0]
}
$nocache=""
if($args.count -gt 1){
    $nocache=$args[1]
}
docker build -t hub.docker.internal:5000/ikomida/rabbitmq-image:latest . $nocache
ThrowOnNativeFailure
docker push hub.docker.internal:5000/ikomida/rabbitmq-image:latest
kubectl -n ikomida delete StatefulSet rabbitmq-microservice
kubectl apply -f ./k8s-dev/deployment.yaml
kubectl apply -f ./k8s-dev/service.yaml