{ pkgs, ... }:

{
  environment.variables.NODEJS_PATH = "${pkgs.nodePackages_latest.nodejs}/";
}
