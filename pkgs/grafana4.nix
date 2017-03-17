pkgs : {
    description = "Grafana 4";
    enable = true;
    path = [pkgs.grafana-v4.1.2];
    wantedBy = [ "default.target" ];
        serviceConfig = {
        };    
}
