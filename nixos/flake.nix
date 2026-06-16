{
  description = "hi";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";

    mcsr-nixos = {
      url = "https://git.uku3lig.net/uku/mcsr-nixos/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
        specialArgs = { inherit inputs; };
        modules = [ 
          ./hosts/abyss/configuration.nix 
        ];
      };
    };
  };
}
