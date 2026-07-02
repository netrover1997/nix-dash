{ config, pkgs, ... }:


{
	home.username = "netrover";
	home.homeDirectory = "/home/netrover";
	
	home.packages = with pkgs; [
		brightnessctl
		];

	programs.git = {
		enable = true;
		settings = {
			user = {
		name = "netrover1997";
		email = "netrover1997@gmail.com";
			};
		credential = {
				helper = "store";
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
	home.file.".config/hypr".source = ./config/hypr;	
                   
}
