# Configuration du backend local pour l'état de Terraform
terraform {
  backend "local" {
    path = ".tf_state/terraform.tfstate"
  }
}