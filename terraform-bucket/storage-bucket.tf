provider "google" {
  version = "2.5.0"
  project = "${var.project}"
  region = "${var.region}"
}

module "awesome_bucket" {
  source      = "git::https://github.com/SweetOps/terraform-google-storage-bucket.git?ref=master"
  name        = "storagebackettestCentr"
  stage       = "production"
  namespace   = "sweetops"
  location    = "europe-west1"
}



#module "storage-bucket" {
#  source = "SweetOps/storage-bucket/google"
#  version = "0.1.1"


  # Имена поменяйте на другие
#  name = ["storage-bucket-test1111", "storage-bucket-test2222"]
#} 

#output storage-bucket_url {
#value = "${module.storage-bucket.url}"
#}
