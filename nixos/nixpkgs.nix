{ ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;
  nixpkgs.overlays = [
    (final: prev: {
      jdk8 = final.openjdk8-bootstrap;
    })
  ];
}
