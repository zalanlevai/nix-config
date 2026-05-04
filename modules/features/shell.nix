{ self, pkgs, ... }: {
  flake.nixosModules.shell = { pkgs, lib, ... }: {
    programs.bash.enable = true;
    programs.fish.enable = true;

    users.defaultUserShell = pkgs.fish;

    # Shell utilities.
    programs.bat.enable = true;
    # Shell utility packages.
    environment.systemPackages = with pkgs; [
      # Core utilities.
      eza
      fd
      jq
      ncdu
      ripgrep

      # Zip support.
      unzip
      zip

      # Development utilities.
      graphviz
      hyperfine
      samply
      tokei

      # Media utilities
      ffmpeg
      imagemagick
    ];

    environment.shellAliases = {
      "exa" = "eza --header --icons --git";
      "exaa" = "exa -a";
      "exA" = "exa -a";
      "exal" = "exa -l";
      "exaal" = "exa -al";
      "exAl" = "exa -al";

      "gs" = "git status";
      "ga" = "git add";
      "gaa" = "git add -A";
      "gA" = "git add -A";
      "gcm" = "git commit -m";
      "gcma" = "git commit -a -m";
      "gca" = "git commit --amend --no-edit";
      "gcae" = "git commit --amend";
      "gcaa" = "git add -A && git commit --amend --no-edit";
      "gcA" = "git add -A && git commit --amend --no-edit";
      "gcaae" = "git add -A && git commit --amend";
      "gcAe" = "git add -A && git commit --amend";
      "gnope" = "git checkout .";
      "gwait" = "git reset HEAD";
      "gundo" = "git reset --soft HEAD";
      "gl" = "git log";
      "gll" = "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset %C(bold blue)<%an>%Creset' --abbrev-commit";
      "gco" = "git checkout";
      "gps" = "git push";
      "gpsf" = "git push --force-with-lease";
      "gpl" = "git pull --rebase";
      "grb" = "git rebase";
      "grbi" = "git rebase -i";
      "grba" = "git rebase --abort";
      "grbc" = "git rebase --continue";

      "grep" = "grep --color=auto";
      "ls" = "ls --color=auto";
    };

    programs.fish.interactiveShellInit = ''
      # Disable default greeting.
      set fish_greeting ""
    '';
  };
}
