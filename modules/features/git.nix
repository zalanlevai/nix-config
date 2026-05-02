{ self, pkgs, ... }: {
  flake.nixosModules.git = { pkgs, lib, ... }: {
    programs.git = {
      enable = true;
      config = {
        "credential \"https://github.com\"" = {
          helper = "!${lib.getExe pkgs.gh} auth git-credential";
        };
        "credential \"https://gist.github.com\"" = {
          helper = "!${lib.getExe pkgs.gh} auth git-credential";
        };
        "user" = {
          "name" = "Zalán Bálint Lévai";
          "email" = "zalan.levai@gmail.com";
        };
      };
    };

    environment.systemPackages = with pkgs; [gh];
  };
}
