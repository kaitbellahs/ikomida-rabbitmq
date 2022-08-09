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
docker build -t us-central1-docker.pkg.dev/ikomida-prod/docker/rabbitmq-image:latest . $nocache
ThrowOnNativeFailure
docker push us-central1-docker.pkg.dev/ikomida-prod/docker/rabbitmq-image:latest
kubectl -n ikomida delete StatefulSet rabbitmq-microservice
kubectl apply -f ./k8s/deployment.yaml
kubectl apply -f ./k8s/service.yaml