terraform {
  required_version = ">= 1.6"
}

module "static_site" {
  source = "../../modules/static_site"

  project_name = "tf-static-site"
  environment  = "dev"
  region       = "eu-north-1"
}
