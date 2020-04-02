terraform {
  backend "s3" {
    bucket = "cicd-fiap-28ati-333050"
    key    = "state/hackaton-cicd-deploy"
    region = "us-east-1"
  }
}