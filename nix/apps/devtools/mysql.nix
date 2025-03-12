{ config, pkgs, ... }:

{
  # Enable and configure MySQL (MariaDB)
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;

    # Ensure MySQL starts on boot
    ensureDatabases = [ "testdb" ];
    ensureUsers = [
      {
        name = "root";
        ensurePermissions = { "*.*" = "ALL PRIVILEGES"; };
        password = "1001";
      }
    ];

    # Enforce native password authentication
    settings = {
      bind-address = "127.0.0.1";
      port = 3306;
      skip-networking = false;
      default_authentication_plugin = "mysql_native_password";
    };
  };

  # Install MySQL Workbench and MySQL 8.4
  environment.systemPackages = with pkgs; [
    parallel-full
    mysql-workbench
    mysql84
  ];

  # Add MySQL 8.4 to PATH for all users
  environment.variables.PATH = [ "${pkgs.mysql84}/bin" ];

  # Ensure MySQL data directory has correct permissions
  systemd.tmpfiles.rules = [
    "d /var/lib/mysql 0700 mysql mysql -"
  ];

  # Ensure MySQL starts on boot
  systemd.services.mysql = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
  };
}
