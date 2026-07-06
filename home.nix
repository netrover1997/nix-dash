{ config, pkgs, inputs, ... }:


{
	imports = [ inputs.nix-doom-emacs-unstraightened.homeModule ];

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
		zed-editor
        antigravity
    # tools lsp
    nodejs
    gcc
    pandoc
    nixfmt-rfc-style
    shellcheck
    python3
    python3Packages.isort
    python3Packages.pytest
    pipenv
    steam
    steam-tui
    mindustry-wayland
    discord
    discordo
    chromium
    evince
	];

	services.hyprpolkitagent.enable = true;

	# Doom Emacs, built by nix-doom-emacs-unstraightened.
	# doomDir tracks ./config/doom in this repo, so `doom sync` never has to
	# run by hand -- `rs` (nixos-rebuild switch) rebuilds it for you.
	programs.doom-emacs = {
		enable = true;
		doomDir = ./config/doom;
		# Uncomment if you hit "Cannot find Git revision" errors on newer Nix:
		# experimentalFetchTree = true;

		emacs = pkgs.emacs30-pgtk;
	};

	# Run Emacs as a daemon (Unstraightened auto-registers itself as
	# services.emacs.package) and talk to it with `emacsclient`. Without
	# this, cold Doom startup can take the better part of a minute.
	services.emacs = {
		enable = true;
		client.enable = true;
	};

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
			e = "emacsclient -t -a ''";                         # Instant Terminal Client
   		ec = "emacsclient -c -n -a ''";                         # Quick-fix Client
		};
	};
	home.file.".config/hypr".source = ./config/hypr;
  home.file.".config/uwsm".source = ./config/uwsm;
  home.file.".config/zed".source = ./config/zed;
}
