provider "aws" {
  region = var.region
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "sf-uw2-dev"
    key    = "env:/sf-uw2-dev/vpc/terraform.tfstate"
    region = var.region
  }
}

resource "aws_workspaces_directory" "spookyfox" {
  directory_id = aws_directory_service_directory.example.id
  subnet_ids = [
    aws_subnet.example_c.id,
    aws_subnet.example_d.id
  ]

  tags = {
    Example = true
  }

  self_service_permissions {
    change_compute_type  = true
    increase_volume_size = true
    rebuild_workspace    = true
    restart_workspace    = true
    switch_running_mode  = true
  }

  workspace_access_properties {
    device_type_android    = "ALLOW"
    device_type_chromeos   = "ALLOW"
    device_type_ios        = "ALLOW"
    device_type_linux      = "ALLOW"
    device_type_osx        = "ALLOW"
    device_type_web        = "ALLOW"
    device_type_windows    = "DENY"
    device_type_zeroclient = "DENY"
  }

  workspace_creation_properties {
    custom_security_group_id            = aws_security_group.example.id
    default_ou                          = "OU=AWS,DC=Workgroup,DC=Example,DC=com"
    enable_internet_access              = true
    enable_maintenance_mode             = true
    user_enabled_as_local_administrator = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.workspaces_default_service_access,
    aws_iam_role_policy_attachment.workspaces_default_self_service_access
  ]
}