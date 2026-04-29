{
  flake.modules = {
    homeManager.security = { pkgs, ... }: {
      home.packages = with pkgs; [
        wireguard-tools
        proton-vpn
        proton-vpn-cli
      ];
    };
  };
}