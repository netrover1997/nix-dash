{ config, pkgs, ... }:


{
	home.username = "netrover";
	home.homeDirectory = "/home/netrover";

	home.packages = with pkgs; [
		# hardware control
		brightnessctl

		# Wayland/Hyprland session essentials
		wl-clipboard
		grim
		slurp
		hypridle
		hyprlock
		waybar
		mako
		fuzzel
		quickshell
	];

	services.hyprpolkitagent.enable = true;

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
			rs = "cd ~/nix-dash && git add . && sudo nixos-rebuild switch --flake .#nixos-btw";
		};
	};
	home.file.".config/hypr".source = ./config/hypr;	
                   
}
