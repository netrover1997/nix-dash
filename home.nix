{ config, pkgs, ... }:


{
	home.username = "netrover";
	home.homeDirectory = "/home/netrover";
	home.packages = with pkgs; [
		gh
	];
	programs.git = {
		enable = true;
		settings = {
			user = {
		name = "netrover1997";
		email = "netrover1997@gmail.com";
			};
		credential = {
			"https://github.com" = {
				helper = "!gh auth token";
				};
			};
		};
	};

	home.stateVersion = "26.05";
	programs.bash = {
		enable = true;
		shellAliases = {
			btw = "echo I use nixos, btw";
		};
	};
}
