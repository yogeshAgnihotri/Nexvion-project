output "kubernetes_lab_public_ip" {
  description = "Public IP of the Kubernetes lab EC2"
  value       = aws_instance.kubernetes_lab.public_ip
}

output "kubernetes_lab_instance_id" {
  description = "Kubernetes lab EC2 instance ID"
  value       = aws_instance.kubernetes_lab.id
}
