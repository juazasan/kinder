install:
	go install sigs.k8s.io/cloud-provider-kind@latest
	./install-registry.sh

up:
	kind create cluster --config kinder.yaml
	./add-registry.sh
	kubectl cluster-info --context kind-kinder
	kubectl kustomize "https://github.com/nginxinc/nginx-gateway-fabric/config/crd/gateway-api/standard?ref=v1.4.0" | kubectl apply -f -
	helm install ngf oci://ghcr.io/nginxinc/charts/nginx-gateway-fabric --create-namespace -n nginx-gateway --values values.yaml --wait

delete:
	kind delete cluster --name kinder