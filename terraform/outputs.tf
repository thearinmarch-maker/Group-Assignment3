output "manager_public_ip" {
  description = "Public IP of Swarm Manager"
  value       = aws_instance.swarm_manager.public_ip
}

output "worker_public_ips" {
  description = "Public IPs of Swarm Workers"
  value       = aws_instance.swarm_workers[*].public_ip
}

output "manager_private_ip" {
  description = "Private IP of Swarm Manager (for swarm join)"
  value       = aws_instance.swarm_manager.private_ip
}