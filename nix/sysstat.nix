pkgs : {
    description = "Systat Desription";
    enable = true;
    path = [nixos.sysstat];
    wantedBy = [ "default.target" ];
}
