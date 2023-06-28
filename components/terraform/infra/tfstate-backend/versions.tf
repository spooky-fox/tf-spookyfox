terraform {
 required_version = "~> 1.5.1"

 required_providers {
   aws = {
     source  = "hashicorp/aws"
     version = "~> 5.5.0"
   }
   local = {
     source  = "hashicorp/local"
     version = "~> 2.4.0"
   }
 }
}