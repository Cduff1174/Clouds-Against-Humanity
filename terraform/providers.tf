terraform {
  required_version = ">= 1.6.0"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.40"
    }
    twingate = {
      source  = "Twingate/twingate"
      version = "~> 3.0"
    }
    doppler = {
      source  = "DopplerHQ/doppler"
      version = "~> 1.15"
    }
  }
}

# Authenticates using DOPPLER_TOKEN from Spacelift's environment
provider "doppler" {}

# Fetches DIGITALOCEAN_TOKEN, TWINGATE_API_TOKEN, and TWINGATE_NETWORK at runtime
data "doppler_secrets" "this" {}

provider "digitalocean" {
  token = data.doppler_secrets.this.map.DIGITALOCEAN_TOKEN
}

provider "twingate" {
  api_token = data.doppler_secrets.this.map.TWINGATE_API_TOKEN
  network   = data.doppler_secrets.this.map.TWINGATE_NETWORK
}
