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
docker build -t us-central1-docker.pkg.dev/$projectid/docker/rabbitmq-image:latest . $nocache
ThrowOnNativeFailure
docker push us-central1-docker.pkg.dev/$projectid/docker/rabbitmq-image:latest
kubectl -n ikomida delete StatefulSet rabbitmq-microservice

Get-ChildItem ".\k8s\" -Filter *.yaml | 
Foreach-Object {
    $content = Get-Content $_.FullName
    $content.replace('$PROJECT_ID', $projectid) | kubectl apply -f -
}