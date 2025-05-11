# ☁️ EKS 기반 3-Tier 아키텍처 구축 프로젝트

본 프로젝트는 AWS Elastic Kubernetes Service (EKS)를 활용하여 **3-Tier 웹 아키텍처**(Web, WAS, DB)를 구성하고, nginx + tomcat + RDS 환경을 기반으로 인프라를 구성합니다.
- 참고 Notion: https://superb-toothpaste-646.notion.site/EKS-1e766366887980198cb0f53580d2eae7?pvs=4

![image](https://github.com/user-attachments/assets/3cf72995-fad9-4575-a971-c4808b260ddd)

---

## 📂 프로젝트 구조

```
├── Dockerfile                 # 애플리케이션용 Dockerfile
├── nginx-host-dep.yml         # Nginx 호스트 기반 배포 매니페스트
├── nginx-ip-dep.yml           # Nginx IP 기반 배포 매니페스트
├── nginx-reverse-dep.yml      # Nginx 리버스 프록시 배포 매니페스트
├── nginx-svc.yml              # Nginx 서비스 정의
├── tom-alb.yml                # Tomcat용 ALB 설정
├── tom-deployment.yml         # Tomcat 배포 매니페스트
├── tom-domain-alb.yml         # 도메인 기반 Tomcat ALB 설정
├── tom-svc.yml                # Tomcat 서비스 정의
├── web-alb.yml                # Web 계층 ALB 설정
├── web-domain-alb.yml         # 도메인 기반 Web ALB 설정
```

---

## 🛠️ 사전 준비 사항

- AWS CLI 설치 및 구성
- `kubectl` 설치 및 클러스터 연결
- `eksctl`을 통한 EKS 클러스터 생성
- Docker 설치 및 이미지 빌드 환경 구성
- 도메인(Route 53) 및 SSL 인증서(ACM) 구성 (선택)

---

## 🚀 배포 단계

### 1. EKS 클러스터 생성

```bash
eksctl create cluster \
  --name eks-3tier-cluster \
  --region ap-northeast-2 \
  --nodegroup-name standard-workers \
  --node-type t3.medium \
  --nodes 3
```

---

### 2. Docker 이미지 빌드 및 푸시

```bash
# 도커 이미지 빌드
docker build -t <도커허브계정명>/your-app-name:latest .

# 도커허브에 푸시
docker push <도커허브계정명>/your-app-name:latest
```

---

### 3. Kubernetes 리소스 배포

```bash
# Nginx 배포
kubectl apply -f nginx-host-dep.yml
kubectl apply -f nginx-svc.yml

# Tomcat 배포
kubectl apply -f tom-deployment.yml
kubectl apply -f tom-svc.yml

# ALB 설정
kubectl apply -f web-alb.yml
kubectl apply -f tom-alb.yml
```

---

## 🌐 도메인 기반 접근 (옵션)

- `web-domain-alb.yml`과 `tom-domain-alb.yml`을 사용해 Route 53에서 생성한 도메인과 연동
- SSL 인증서를 ACM에서 발급받아 HTTPS ALB 구성 가능

---

## 🔐 보안 설정

- IAM OIDC Provider 연동
- AWS Load Balancer Controller용 IAM 역할 구성
- RDS 접근 보안을 위한 Security Group 구성

---
