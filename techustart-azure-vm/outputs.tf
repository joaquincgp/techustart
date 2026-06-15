output "public_ip_address" {
  description = "Dirección IP pública asignada a la máquina virtual."
  value       = azurerm_linux_virtual_machine.main.public_ip_address
}

output "apache_url" {
  description = "URL HTTP para validar el servidor Apache."
  value       = "http://${azurerm_linux_virtual_machine.main.public_ip_address}"
}
