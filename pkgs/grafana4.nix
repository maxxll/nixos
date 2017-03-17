pkgs : {
    description = "Grafana 4";
    enable = true;
    path = [pkgs.grafana];
    wantedBy = [ "default.target" ];
        serviceConfig = {
        };    
}
