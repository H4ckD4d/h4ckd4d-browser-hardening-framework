// h4ckd4d Firefox profile: everyday
// Balanced baseline for daily browsing with reduced breakage.

user_pref("browser.startup.page", 0);
user_pref("browser.formfill.enable", true);
user_pref("signon.rememberSignons", true);

user_pref("toolkit.telemetry.enabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("app.shield.optoutstudies.enabled", false);

user_pref("dom.security.https_only_mode", true);
user_pref("network.cookie.cookieBehavior", 5);
user_pref("network.http.referer.XOriginPolicy", 1);
user_pref("network.dns.disablePrefetch", true);

user_pref("privacy.donottrackheader.enabled", true);
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.pbmode.enabled", true);
user_pref("privacy.resistFingerprinting", false);

user_pref("media.peerconnection.enabled", true);
user_pref("webgl.disabled", false);

user_pref("privacy.clearOnShutdown.history", false);
user_pref("privacy.clearOnShutdown.cookies", false);
user_pref("privacy.clearOnShutdown.cache", false);
