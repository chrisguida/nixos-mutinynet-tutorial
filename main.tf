provider "digitalocean" {}

resource "digitalocean_droplet" "node" {
  name     = "node${count.index + 1}"
  region   = "nyc3"
#  size     = "s-1vcpu-1gb"

# cheapest vps with 600GB disk. needed to save money after the bitcoind build
# since DO does not allow shrinking disk once expanded.
  size     = "m6-4vcpu-32gb"

# largest vps on DO. needed to build bitcoind. $2/hr at time of writing.
#  size     = "c-48"

# smallest compute optimized droplet. good for initial setup before bitcoind build.
#  size     = "c-2"

# my image, use your own
  image    = 140788016

# my ssh key, use your own
  ssh_keys = [39451484]

# 20 nodes
  count = 20
}

