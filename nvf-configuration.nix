{ pkgs, lib, ... }:

{
  vim = {
    theme = {
      enable = true;
      transparent = true;
    };
    statusline.lualine = {
        enable = true;
        theme = "nord";
    };
    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;
    
    languages = {
      enableLSP = true;
      enableTreesitter = true;

      nix.enable = true;
      rust.enable = true;
    };
  };
}