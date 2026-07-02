{
	description = "NixOS from Scratch";
	inputs = {
		nixpkgs.url = "nixpkgs/nixos-26.05";
		home-manager = {
			url = "github:nix-community/home-manager/release-26.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		nix-doom-emacs-unstraightened = {
			url = "github:marienz/nix-doom-emacs-unstraightened";
			# Empty on purpose: neither the module nor the overlay uses this
			# input, so following it would just add unnecessary evaluation.
			inputs.nixpkgs.follows = "";
		};
	};

	outputs = { self, nixpkgs, home-manager, ... }@inputs: {
		nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager
				{
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						extraSpecialArgs = { inherit inputs; };
						users.netrover = import ./home.nix;
						backupFileExtension = "backup";
					};
				}
			];
		};
	};

}
