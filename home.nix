{ config, pkgs, ... }:


{
	home.username = "netrover";
	home.homeDirectory = "/home/netrover";
	programs.git = {
		enable = true;
		settings = {
			user = {
		name = "netrover1997";
		email = "netrover1997@gmail.com";
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
