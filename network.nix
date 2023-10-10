# 1.
let
  resourcesByType = (import ./parsetf.nix { }).resourcesByType;

  droplets = resourcesByType "digitalocean_droplet";
  nodes = builtins.filter (d: d.name == "node") droplets;

  # 2.
  mkNode = resource: { name, pkgs, ... }: {
    imports = [ ./common.nix ];
    deployment.targetHost = resource.values.ipv4_address;
    networking.hostName = resource.values.name;
#    networking.firewall.allowedTCPPorts = [ 9735 ];
    system.stateVersion = "23.11";
    users.users.bitcoiner = {
      isNormalUser = true;
      description = "bitcoiner";
      extraGroups = [ "wheel" ];
      packages = with pkgs; [
        vim
      ];
      password = "btcpp";
    };
    services.openssh = {
      settings.PasswordAuthentication = true;
      extraConfig = ''
        ClientAliveInterval 120
        ClientAliveCountMax 720
      '';
    };
  };
in
# 3.
{
  network = {
    pkgs = import <nixpkgs> { };
  };
} // # 5.
# 4.
builtins.listToAttrs (map (r: { name = r.values.name; value = mkNode r; }) nodes)

