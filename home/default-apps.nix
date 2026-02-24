{ ... }:
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "vivaldi.desktop";
      "x-scheme-handler/http" = "Vivaldi.desktop";
      "x-scheme-handler/https" = "Vivaldi.desktop";
      "x-scheme-handler/about" = "Vivaldi.desktop";
      "x-scheme-handler/unknown" = "Vivaldi.desktop";
    };
  };

  # Optional: Set the environment variable just in case
  home.sessionVariables = {
    BROWSER = "vivaldi";
  };
}
