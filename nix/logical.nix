{
  network.description = "NIXOPS server";

  nixos =
    { config, pkgs, ... }:
    { 
    
     ## master branch

#services.postgresql = {
#        enable = true;
#        authentication = "local all all ident";
#      };

 services.graphite = {
     dataDir = "/var/graphitedata";
     web.enable = true;
      carbon = {
       enableCache = true;
      };
    };


     
#  services = {
#
# postgresql.enable = true;
#  postgresql.authentication = "local all all ident";
#
#        logrotate = {
#        enable = true;
#        config = ''
#        /var/log/restart-backends.log {
#            missingok
#            daily
#            rotate 10
#            compress
#        }
#        /var/log/tmp/* {
#            missingok
#            daily
#            rotate 18
#            compress
#        }
#        '';
#        };
#
#  cron = {
#         enable = true;
#         systemCronJobs = [
#           "* * * * 0 find /tmp -type f ! -name access.log -delete"
#           "*/1 * * * * root echo '`date` restart-backends' >> /var/log/restart-backends.log" ];
#      };

      #services.httpd.enable = true;
      #services.httpd.adminAddr = "maxxl@tut.by";
      #services.httpd.documentRoot = "/www";
      
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
    database.host = "127.0.0.1:5432";
    database.name = "grafana";
    database.user = "grafana";
    database.password = "Grafana-1";
};


      services.postgresql = {
        enable = true;
        authentication = "host    all             all             0.0.0.0/0            password";
        enableTCPIP = true;
        dataDir = "/var/db/postgresql";
        port = 5432;
       };


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
