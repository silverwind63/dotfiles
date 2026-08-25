{
  lib,
  input,
  ...
}: {
  programs.nvf = {
    enable = true;
    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim = {
        viAlias = false;
        vimAlias = true;

        theme.enable = true;
        theme.name = "everforest";
        theme.style = "hard";

        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;
        binds.whichKey.enable = true;
        utility.yazi-nvim = {
          enable = true;
          mappings.openYazi = "cw";
          mappings.openYaziDir = "-";
        };
        tabline.nvimBufferline.enable = true;
        formatter.conform-nvim.enable = true;
        utility.motion.flash-nvim.enable = true;
        autopairs.nvim-autopairs.enable = true;
        comments.comment-nvim.enable = true;

        clipboard.providers.wl-copy.enable = true;
        options.shiftwidth = 4;
        options.tabstop = 4;

        tabline.nvimBufferline.mappings.cycleNext = "<Tab>";
        tabline.nvimBufferline.mappings.cyclePrevious = "<S-Tab>";

        lsp.enable = true;
        lsp.formatOnSave = true;

        languages = {
          enableTreesitter = true;

          nix.enable = true;
          nix.format.enable = true;
          python.enable = true;
          python.format.enable = true;
          clang.enable = true;
          qml.enable = true;
        };

        diagnostics.config = {
          signs.text = lib.generators.mkLuaInline ''
            {
              [vim.diagnostic.severity.ERROR] = "󰅚 ",
              [vim.diagnostic.severity.WARN] = "󰀪 ",
            }
          '';
        };
      };
    };
  };
}
