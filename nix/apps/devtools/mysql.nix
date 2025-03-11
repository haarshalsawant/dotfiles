{ config, pkgs, ... }:
{
  # Keep existing MariaDB service
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  # Install MySQL Workbench and MySQL 8.4
  environment.systemPackages = with pkgs; [
    parallel-full
    mysql-workbench
    mysql84
  ];

  # Add MySQL 8.4 to PATH for all users
  environment.variables = {
    PATH = [
      "${pkgs.mysql84}/bin"
    ];
  };

  # Create a system activation script to setup MySQL environment
  system.activationScripts.mysqlSetup = {
    text = ''
            # Create MySQL configuration directory if it doesn't exist
            mkdir -p /etc/mysql
      
            # Create a default my.cnf file for MySQL client tools
            if [ ! -f /etc/mysql/my.cnf ]; then
              cat > /etc/mysql/my.cnf << EOF
      [client]
      port = 3306
      socket = /run/mysqld/mysqld.sock

      [mysql]
      prompt = "MySQL [\d]> "
      default-character-set = utf8mb4

      [mysqldump]
      max_allowed_packet = 64M
      EOF
              chmod 644 /etc/mysql/my.cnf
            fi
    '';
    deps = [ ];
  };

  # Create MySQL data directory with proper permissions
  systemd.tmpfiles.rules = [
    "d /var/lib/mysql 0700 mysql mysql -"
  ];
}
