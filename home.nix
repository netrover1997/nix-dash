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
    nixfmt
    shellcheck
    python3    
    mindustry-wayland
    discord
    discordo
    chromium
      evince
      webtorrent_desktop
      vlc
      mpv
      spotify
      easyeffects
      pavucontrol
      furnace
      qbittorrent
      protonup-qt
      unrar
      p7zip
      xarchiver
      qimgv
      loupe
      megasync
      aider-chat
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

    programs.yazi = {
        enable = true;
        enableBashIntegration = true; # integrations for your bash setup
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
      enableCompletion = true;

# 1. This securely loads your API key from a local hidden file instead of hardcoding it
      initExtra = ''
        if [ -f ~/.gemini_api_key ]; then
          export GEMINI_API_KEY=$(cat ~/.gemini_api_key)
        fi
      '';

		shellAliases = {
			btw = "echo I use nixos, btw";
			rs = "cd ~/nix-dash && git add . && sudo nixos-rebuild switch --flake .#nixos-btw";
			e = "emacsclient -t -a ''";                         # Instant Terminal Client
   		ec = "emacsclient -c -n -a ''";                         # Quick-fix Client
	aider-gemini = "aider --model gemini/gemini-pro-latest";
		};
	};
    programs.fzf = {
      enable = true;
      enableBashIntegration = true;
    };
    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
      options = [ "--cmd cd" ];
    };

    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

    # ---------- OBS Studio (streaming) ----------
    programs.obs-studio = {
      enable = true;
      package = pkgs.obs-studio; 
      plugins = with pkgs.obs-studio-plugins; [
        obs-vkcapture              # Game capture on Wayland (Vulkan/OpenGL hook)
        obs-pipewire-audio-capture # Capture game/desktop audio via PipeWire
      ];
    };
	home.file.".config/hypr".source = ./config/hypr;
  home.file.".config/uwsm".source = ./config/uwsm;
  home.file.".config/zed".source = ./config/zed;
}
