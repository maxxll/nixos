{
  network.description = "NIXOPS server";

  webserver =
    { config, pkgs, ... }:
    { 
    
     ## master branch

      services.httpd.enable = true;
      services.httpd.adminAddr = "maxxl@tut.by";
      services.httpd.documentRoot = "/www";
      
      services.logrotate.enable = true;
      services.logrotate.config = ''
        /var/log/temp/*.loo {
            missingok
            hourly
            rotate 11
            compress
        }
        '';

      networking.firewall.allowedTCPPorts = [ 80 3000 22 44 ];

services.grafana = {
    enable=true;
    port=3000;
    addr = "0.0.0.0";
};


      services.postgresql.enable = true;
      services.postgresql.authentication = "local all all ident";

      environment.systemPackages = [
          pkgs.jdk
          pkgs.wget
          pkgs.mc
          pkgs.sqlite
          pkgs.php
          pkgs.logrotate
          pkgs.git
        ];

    };

}
