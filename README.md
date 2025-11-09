# terraform-eks
Criar um cluster EKS utilizando Terraform

Disponibilizo esse repositório para quem esta com dificuldades de criar um cluster Kubernetes na AWS EKS.
Esses códigos criam um cluster sem erros.

O que enfrentei de erros ?
Eu estava criando o cluster e sempre ao final de tudo dava erros nos Nodes informando sobre a saúde dos mesmos "Unhealth node status".
Depois de muitas pesquisas vi que faltava instalar os addons vpc-cni, coredns e kube-proxy, vi que o Terraform não instalava isso de nenhum forma.
Uma solução que achei foi executar um comando bash ao final da criação do cluster e dos nodes, esse bash cria os addons necessários para que
os nodes fiquem todos como Ready.

Provavelmente tem outra forma mais profissional de se resolver, mas após varias tentativas mal sucedidas de até mesmo criar esses addons via terraform,
esse comando bash foi o que resolveu o problema.

Nesse repositório contém também o Yaml do Nginx para quem queira testar o funcionamento do Kubernetes após a criação.
