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
  programs.firefox = {
    enable = true;

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = { Cryptomining = true; };
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = true;
      DisablePocket = true;
      SearchBar = "unified";
      SearchEngines = { Default = "DuckDuckGo"; };

      Preferences = {
        "extensions.pocket.enabled" = lock-false;
        "browser.newtabpage.pinned" = lock-empty-string;
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

      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };

    # "browser.search.suggest.enabled" = lock-false;
    # "browser.search.suggest.enabled.private" = lock-false;
    # "browser.urlbar.suggest.searches" = lock-false;
    # "browser.urlbar.showSearchSuggestionsFirst" = lock-false;

    # profiles = {
    #   default = {
    #     extensions = with pkgs.nur.repos.rycee.firefox-addons; [
    #       bitwarden
    #       bypass-paywalls-clean
    #       copy-selection-as-markdown
    #       darkreader
    #       # enhancer-for-youtube
    #       gnome-shell-integration
    #       # metamask
    #       # modheader
    #       privacy-badger
    #       # sourcegraph
    #       tabliss
    #       # tampermonkey
    #       ublock-origin
    #       # wikiwand-wikipedia-modernized
    #     ];
    #     settings = {
    #       "signon.rememberSignons" = false;
    #       "widget.use-xdg-desktop-portal.file-picker" = 1;

    #       "browser.aboutConfig.showWarning" = false;
    #       "browser.compactmode.show" = true;
    #       "browser.startup.homepage" = "";
    #       # Be kind to SSD and don't write multiple GBs per day when watching videos
    #       "browser.cache.disk.enable" = false;

    #       "browser.newtabpage.activity-stream.default.sites" = "";
    #       "browser.newtabpage.activity-stream.feeds.topsites" = false;
    #       "browser.newtabpage.activity-stream.feeds.system.topstories" = false;
    #       "browser.newtabpage.activity-stream.feeds.snippets" = false;
    #       "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
    #       "browser.newtabpage.activity-stream.showSponsored" = false;
    #       "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
    #       "browser.newtabpage.activity-stream.system.showSponsored" = false;
    #       "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
    #       "browser.newtabpage.activity-stream.discoverystream.sendToPocket.enabled" = false;
    #       "browser.newtabpage.activity-stream.telemetry" = false;
    #       "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
    #       "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;

    #       "privacy.webrtc.legacyGlobalIndicator" = false;
    #       "app.shield.optoutstudies.enabled" = false;
    #       "app.update.auto" = false;
    #       "browser.contentblocking.category" = "strict";
    #       "browser.discovery.enabled" = false;
    #       "browser.laterrun.enabled" = false;
    #       "browser.protections_panel.infoMessage.seen" = true;
    #       "browser.quitShortcut.disabled" = true;
    #       "browser.shell.checkDefaultBrowser" = false;
    #       "browser.ssb.enabled" = true;
    #       "browser.urlbar.suggest.openpage" = false;
    #       "datareporting.policy.dataSubmissionEnable" = false;
    #       "datareporting.policy.dataSubmissionPolicyAcceptedVersion" = 2;
    #       "extensions.htmlaboutaddons.recommendations.enabled" = false;
    #       "extensions.pocket.enabled" = false;
    #       "identity.fxaccounts.enabled" = false;
    #       "privacy.trackingprotection.enabled" = true;
    #       "privacy.trackingprotection.socialtracking.enabled" = true;

    #       "mousewheel.default.delta_multiplier_x" = 20;
    #       "mousewheel.default.delta_multiplier_y" = 20;
    #       "mousewheel.default.delta_multiplier_z" = 20;

    #       # Firefox 75+ remembers the last workspace it was opened on as part of its session management.
    #       # This is annoying, because I can have a blank workspace, click Firefox from the launcher, and
    #       # then have Firefox open on some other workspace.
    #       "widget.disable-workspace-management" = true;
    #     };
    #   };
    # };
  };
}
