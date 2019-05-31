module "cloudtrail" {
  source              = "../../modules/cloudtrail"
  account_id          = "${var.aws_prod_account_id}"
  s3_bucket_name      = "digitalmarketplaces-prod-account-cloudtrail-bucket"
  trail_name          = "digitalmarketplaces-prod-account-cloudtrail"
  validate_account_id = "${var.aws_main_account_id}"
}
