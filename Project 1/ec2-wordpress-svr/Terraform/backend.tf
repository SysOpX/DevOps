terraform {
  backend "s3" {
    bucket         = "cpfi-terraform-state"
    key            = "env/dev/server_name/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "cpfi-terraform-state-locks"
    encrypt        = true
    kms_key_id     = "alias/cpfi-cmk-key"
    #use_lockfile   = true
  }
}
