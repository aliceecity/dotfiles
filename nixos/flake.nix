{
  description = "Sancho";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
  };

  outputs = {self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      lethe = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./configuration.nix ];
      };
    };
  };
}
