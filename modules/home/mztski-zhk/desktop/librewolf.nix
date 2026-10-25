{...} :{
  flake.homeModules.librewolf = {pkgs, ...}: {
    programs.firefox = {
      enable = true;
      package = pkgs.librewolf;
      policies = {
	DisableTelemetry = true;
	DisableFirefoxStudies = true;

        # https://librewolf.net/docs/settings/#use-a-stricter-autoplay-policy
	Preferences = {
          # Google Safe Browsing
          "browser.safebrowsing.malware.enabled" = true;
          "browser.safebrowsing.phishing.enabled" = true;
          "browser.safebrowsing.blockedURIs.enabled" = true;
          "browser.safebrowsing.provider.google4.gethashURL" = "https://safebrowsing.googleapis.com/v4/fullHashes:find?$ct=application/x-protobuf&key=%GOOGLE_SAFEBROWSING_API_KEY%&$httpMethod=POST";
          "browser.safebrowsing.provider.google4.updateURL" = "https://safebrowsing.googleapis.com/v4/threatListUpdates:fetch?$ct=application/x-protobuf&key=%GOOGLE_SAFEBROWSING_API_KEY%&$httpMethod=POST";
          "browser.safebrowsing.provider.google.gethashURL" = "https://safebrowsing.google.com/safebrowsing/gethash?client=SAFEBROWSING_ID&appver=%MAJOR_VERSION%&pver=2.2";
          "browser.safebrowsing.provider.google.updateURL" = "https://safebrowsing.google.com/safebrowsing/downloads?client=SAFEBROWSING_ID&appver=%MAJOR_VERSION%&pver=2.2&key=%GOOGLE_SAFEBROWSING_API_KEY%";
          ## Download check
          "browser.safebrowsing.downloads.enabled" = true;

          # Security Settings
          "privacy.resistFingerprinting.letterboxing" = true;
          "librewolf.webgl.prompt" = true; ## webgl can exec code, prompt to comfirm trusted
          "privacy.resistFingerprinting" = true;
          "security.OCSP.require" = true;

          ## enable history and cookies
          "privacy.clearOnShutdown.history" = false;
          "privacy.clearOnShutdown.cookies" = false;
          "network.cookie.lifetimePolicy" = 0;

          # Session Management
          "browser.sessionstore.resume_from_crash" = true;
          
          # Guestures
          ## mouse mid btn fast scoll
          "middlemouse.paste" = false;
          "general.autoScroll" = true;
	};
	ExtensionSettings = {
	  "uBlock0@raymondhill.net" = {
	    install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
	    installation_mode = "force_installed";
	  };
	};
      };
    };

    environment.etc."firefox/policies/policies.json".target = "librewolf/policies/policies.json";
    };
}
