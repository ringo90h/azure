#WSL Azure CLI 설치
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

#Kubectl 설치
sudo az aks install-cli

#리소스 그룹 만들기
az group create --name myAKSCluster --location japaneast

#aks 만들기
az aks create --resource-group myAKSCluster --name myAKSCluster --node-count 1 --enable-addons monitoring --generate-ssh-keys

#Kubernetes 클러스터 연결
az aks get-credentials --resource-group myAKSCluster --name myAKSCluster

#aks 노드 확인하기
kubectl get nodes

#kubectl 명령으로 서비스 계정 kubernetes-dashboard에 액세스하는데 필요한 권한 부여
kubectl create clusterrolebinding kubernetes-dashboard -n kube-system --clusterrole=cluster-admin --serviceaccount=kube-system:kubernetes-dashboard

#aks 대시보드 연결. 로컬 머신 포트(8001)을 클러스터의 관리 노드 포트 80으로 SSH 터널 생성
sudo az aks browse --resource-group myAKSCluster --name myAKSCluster 

#애플리케이션 배포
kubectl apply -f azure-vote.yaml

#애플리케이션 테스트
kubectl get service azure-vote-front --watch

#삭제 
az aks delete --resource-group myAKSCluster --name myAKSCluster --no-wait