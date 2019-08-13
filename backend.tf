terraform {
  backend "remote" {
    organization = "myOrganization"
    workspaces {
      name = "my-infrastructure"
    }
  }
}
