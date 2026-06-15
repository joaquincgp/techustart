# TechUStart Azure VM

Proyecto Terraform para desplegar una máquina virtual Linux en Azure para la empresa ficticia TechUStart. La VM usa Ubuntu Server 22.04 LTS de Canonical, expone HTTP por el puerto 80 e instala Apache automáticamente al arrancar mediante `custom_data`.

## Estructura de archivos

```text
techustart-azure-vm/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars.example
├── .gitignore
└── README.md
```

## Requisitos previos

- Terraform `>= 1.5.0`
- Azure CLI instalado
- Una suscripción activa de Azure
- Sesión iniciada en Azure:

```bash
az login
az account set --subscription "<ID_O_NOMBRE_DE_LA_SUSCRIPCION>"
```

## Despliegue

1. Entrar al directorio del proyecto:

```bash
cd techustart-azure-vm
```

2. Inicializar Terraform:

```bash
terraform init
```

3. Revisar el plan de ejecución:

```bash
terraform plan
```

4. Crear la infraestructura:

```bash
terraform apply
```

Para usar valores personalizados, copia el archivo de ejemplo y edítalo:

```bash
cp terraform.tfvars.example terraform.tfvars
terraform apply
```

## Validación de Apache

Al finalizar el despliegue, Terraform mostrará la IP pública y la URL HTTP:

```bash
terraform output public_ip_address
terraform output apache_url
```

También puedes validar Apache con:

```bash
curl "$(terraform output -raw apache_url)"
```

O abrir la URL en un navegador:

```bash
open "$(terraform output -raw apache_url)"
```

## Limpieza

Para eliminar todos los recursos creados:

```bash
terraform destroy
```

## Notas de seguridad

- El NSG solo permite tráfico HTTP entrante por el puerto `80`.
- No se abre SSH públicamente desde Internet.
- La VM usa autenticación SSH con clave generada por Terraform y deshabilita autenticación por contraseña.
- La clave privada SSH queda almacenada en el archivo de estado de Terraform. No se imprime como output porque es información sensible.
- En un laboratorio, si necesitas consultar la clave privada manualmente desde el state, puedes usar:

```bash
terraform state show tls_private_key.ssh_key
```

No se recomienda extraer ni manejar claves privadas desde el state en entornos productivos. Para producción, usa un gestor de secretos como Azure Key Vault y protege el backend remoto de Terraform.
