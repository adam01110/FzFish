{inputs, ...}: {
  imports = [inputs.treefmt-nix.flakeModule];

  perSystem = _: {
    treefmt = {
      flakeCheck = true;

      programs = {
        alejandra.enable = true;
        nixf-diagnose.enable = true;
        deadnix.enable = true;
        statix.enable = true;

        yamlfmt.enable = true;
        yamllint.enable = true;

        fish_indent.enable = true;

        rumdl-format.enable = true;
      };
    };
  };
}
