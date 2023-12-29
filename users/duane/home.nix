{ config, pkgs, ... }:

  let
    lock-false = {
      Value = false;
      Status = "locked";
    };
    lock-true = {
      Value = true;
      Status = "locked";
    };
    lock-empty-string = {
      Value = "";
      Status = "locked";
    };
  in

{

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  home.username = "duane";
  home.homeDirectory = "/home/duane";

  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    # Graphical apps
    amberol # music player
    bitwarden # passwords
    celluloid # video player
    fractal # matrix chat
    lazpaint # image editor
    shotcut # video editing
    vscodium # code editor

    # CLI tools
    bitwarden-cli # access secrets
    broot # summarize deep dirs
    eza # better ls
    fzf # fuzzy search
    git # version control
    htop # system resources
    lazygit # ncurses git
  ];

  programs.home-manager.enable = true;

  programs.firefox = {
    enable = true;

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
	Locked = true;
	Cryptomining = true;
	Fingerprinting = true;
      };
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = true;
      DisablePocket = true;
      SearchBar = "unified";
      SearchEngines = {
        Default = "DuckDuckGo";
        PreventInstalls = false;
      };

      Preferences = {
        "extensions.pocket.enabled" = lock-false;
        "browser.newtabpage.pinned" = lock-empty-string;
        "browser.search.suggest.enabled" = lock-false;
        "browser.search.suggest.enabled.private" = lock-false;
        "browser.urlbar.suggest.searches" = lock-false;
        "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
	"browser.topsites.contile.enabled" = lock-false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
        "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
        "browser.newtabpage.activity-stream.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
	"browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.havePinned" = lock-empty-string;
	"browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.searchEngines" = lock-empty-string;
      };
    };

    profiles = {
      default = {
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
	  bitwarden
	  # bypass-paywalls-clean
	  copy-selection-as-markdown
	  darkreader
	  # enhancer-for-youtube
	  gnome-shell-integration
	  # metamask
	  # modheader
	  privacy-badger
	  # sourcegraph
	  tabliss
	  # tampermonkey
	  ublock-origin
	  # wikiwand-wikipedia-modernized
	];
	settings = {
	  "browser.aboutConfig.showWarning" = false;
          "browser.compactmode.show" = true;
          "browser.startup.homepage" = "";

	  "browser.newtabpage.activity-stream.default.sites" = "";
	  "browser.newtabpage.activity-stream.feeds.topsites" = false;
	  "browser.newtabpage.activity-stream.feeds.system.topstories" = false;
          "browser.newtabpage.activity-stream.feeds.snippets" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
	  "browser.newtabpage.activity-stream.showSponsored" = false;
	  "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
	  "browser.newtabpage.activity-stream.system.showSponsored" = false;
	  "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
	  "browser.newtabpage.activity-stream.discoverystream.sendToPocket.enabled" = false;
	  "browser.newtabpage.activity-stream.telemetry" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;

          "privacy.webrtc.legacyGlobalIndicator" = false;
          "app.shield.optoutstudies.enabled" = false;
          "app.update.auto" = false;
          "browser.contentblocking.category" = "strict";
          "browser.discovery.enabled" = false;
          "browser.laterrun.enabled" = false;
          "browser.protections_panel.infoMessage.seen" = true;
          "browser.quitShortcut.disabled" = true;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.ssb.enabled" = true;
          "browser.urlbar.suggest.openpage" = false;
          "datareporting.policy.dataSubmissionEnable" = false;
          "datareporting.policy.dataSubmissionPolicyAcceptedVersion" = 2;
          "extensions.htmlaboutaddons.recommendations.enabled" = false;
          "extensions.pocket.enabled" = false;
          "identity.fxaccounts.enabled" = false;
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.socialtracking.enabled" = true;

	  "mousewheel.default.delta_multiplier_x" = 20;
	  "mousewheel.default.delta_multiplier_y" = 20;
	  "mousewheel.default.delta_multiplier_z" = 20;
	};
      };
    };
  };

  programs.zsh = {
    enable = true;

    shellAliases = {
      lg = "lazygit";
      config-os = "nvim ~/config/system/configuration.nix";
      update-os = "sudo nix-channel --update";
      apply-os = "sudo nixos-rebuild switch -I nixos-config=$HOME/config/system/configuration.nix";
      config = "nvim ~/config/users/duane/home.nix";
      update = "nix-channel --update";
      apply = "home-manager switch -f $HOME/config/users/duane/home.nix";
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./p10k-config;
        file = "p10k.zsh";
      }
    ];
  };

  programs.git = {
    enable = true;

    userName  = "Duane Johnson";
    userEmail = "duane.johnson@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      scaling-factor = 2;
    };
    "org/gnome/desktop/interface" = {
      clock-format = "12h";
    };
    "org/gtk/settings/file-chooser" = {
      clock-format = "12h";
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
    };
    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
      speed = -0.55;
    };
    "org/gnome/desktop/sound" = {
      allow-volume-above-100-percent = true;
    };
    "org/gnome/shell/keybindings" = {
      toggle-overview = ["<Super>slash"];
      maximize = ["<Super>m"];
    };
  };
}
