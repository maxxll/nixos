pkgs : {
    description = "Systat Desription";
    enable = true;
    path = [pkgs.sysstat];
    wantedBy = [ "default.target" ];
}
