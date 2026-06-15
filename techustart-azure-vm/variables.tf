variable "azure_region" {
  description = "Región de Azure donde se desplegarán los recursos."
  type        = string
  default     = "eastus"
}

variable "tamano_vm" {
  description = "Tamaño de la máquina virtual Linux."
  type        = string
  default     = "Standard_B1s"
}
