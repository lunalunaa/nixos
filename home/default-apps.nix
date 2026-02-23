{ ... }:
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "vivaldi.desktop";
      "x-scheme-handler/http" = "vivaldi.desktop";
      "x-scheme-handler/https" = "vivaldi.desktop";
      "x-scheme-handler/about" = "vivaldi.desktop";
      "x-scheme-handler/unknown" = "vivaldi.desktop";
    };
  };

  # Optional: Set the environment variable just in case
  home.sessionVariables = {
    BROWSER = "vivaldi";
  };
}
