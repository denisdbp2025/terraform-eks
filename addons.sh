#!/bin/bash
set -e

CLUSTER_NAME=$1
REGION=$2

echo "🚀 Instalando add-ons do EKS para o cluster: $CLUSTER_NAME na região: $REGION"

# Aguarda o cluster ficar pronto
echo "⏳ Aguardando o cluster ficar ativo..."
aws eks wait cluster-active --name "$CLUSTER_NAME" --region "$REGION"

# Instala o VPC CNI primeiro
echo "🌐 Instalando VPC CNI..."
aws eks create-addon --cluster-name "$CLUSTER_NAME" --addon-name vpc-cni --region "$REGION" --resolve-conflicts OVERWRITE || true

# Aguarda o VPC CNI ficar ativo
aws eks wait addon-active --cluster-name "$CLUSTER_NAME" --addon-name vpc-cni --region "$REGION"

# Instala CoreDNS
echo "🧩 Instalando CoreDNS..."
aws eks create-addon --cluster-name "$CLUSTER_NAME" --addon-name coredns --region "$REGION" --resolve-conflicts OVERWRITE || true

# Instala Kube Proxy
echo "🧠 Instalando Kube Proxy..."
aws eks create-addon --cluster-name "$CLUSTER_NAME" --addon-name kube-proxy --region "$REGION" --resolve-conflicts OVERWRITE || true

echo "✅ Add-ons do EKS instalados com sucesso!"
