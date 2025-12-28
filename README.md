# Predictive Reliability Engine

> A production-grade DevOps platform that predicts application failures before they occur using real-time metrics analysis and statistical forecasting.

[![Infrastructure](https://img.shields.io/badge/Infrastructure-AWS%20EKS-orange)](https://aws.amazon.com/eks/)
[![IaC](https://img.shields.io/badge/IaC-Terraform-purple)](https://www.terraform.io/)
[![Monitoring](https://img.shields.io/badge/Monitoring-Prometheus%20%2B%20Grafana-red)](https://prometheus.io/)
[![CI/CD](https://img.shields.io/badge/CI%2FCD-GitHub%20Actions-blue)](https://github.com/features/actions)

[Include architecture diagram screenshot here]

## 🎯 Key Features

- **Predictive Analytics**: Forecasts OOM events 30-60 minutes in advance using time-series analysis
- **Proactive Scaling**: HPA integration that scales before failure, not after
- **Zero-Trust Security**: OIDC-based CI/CD with AWS STS, no long-lived credentials
- **GitOps Workflow**: Infrastructure changes via Git commits, automated deployments
- **Production Observability**: Custom metrics, dashboards, and alerting

## 🏗️ Architecture Highlights

### Infrastructure Layer
- **EKS Cluster**: Kubernetes 1.29 with 2 t3.medium worker nodes across 3 AZs
- **VPC Design**: Public/private subnet architecture with NAT gateway
- **State Management**: S3 backend with DynamoDB locking for concurrent safety

### Application Layer
- **Memory Leak Simulator**: Python Flask app with intentional memory growth
- **Custom Metrics**: Prometheus client exposing `app_memory_bytes`, `app_memory_objects`
- **Health Checks**: Liveness and readiness probes for reliability

### Monitoring Stack
- **Prometheus**: 15-second scrape interval for real-time data
- **Grafana**: 5-panel dashboard with predictive gauges
- **AlertManager**: (Ready for) routing to Slack/PagerDuty

### Predictive Engine
- **Algorithm**: Linear regression over 30-minute window with 1-hour forecast
- **Trigger Point**: Alerts when prediction exceeds 450 MiB (90% of limit)
- **Action**: Can trigger HPA scaling or preemptive pod restart

## 📊 Live Dashboard

<img width="1352" height="878" alt="Screenshot 2025-12-28 at 2 46 09 PM" src="https://github.com/user-attachments/assets/f2e38bc8-a428-418c-ae5c-1c4d693b6c00" />



**Dashboard Panels:**
1. Memory Usage (Bytes) - Real-time consumption
2. Leaked Objects Count - Number of objects in memory
3. Predicted Memory in 1 Hour - Gauge turns red when approaching limit
4. Memory Growth Rate - Bytes per second increase
5. Request Rate by Endpoint - Traffic analysis

## 🚀 Quick Start

### Prerequisites
- AWS Account with admin access
- Terraform 1.6+
- kubectl configured
- Docker installed

### Deploy Infrastructure

