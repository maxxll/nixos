#pkgs : {
#    description = "Grafana 4";
#   enable = true;
#    path = [pkgs.grafana];
#    wantedBy = [ "default.target" ];
#        serviceConfig = {
#        };    
#}

    systemd.services.grafana4 = {
      description = "Grafana 4";
      path = [ pkgs.grafana ];
      serviceConfig = {
        Type = "simple";        
      };
    };
