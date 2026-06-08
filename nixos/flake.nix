{
  description = "hi";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";

  };

  outputs = {self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      lethe = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          ./hosts/lethe/configuration.nix 
        ];
      };

      abyss = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          ./hosts/abyss/configuration.nix 
        ];
      };
    };
  };
}
