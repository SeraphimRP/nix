{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        go
        (python313Full.withPackages(ps: with ps; [ pygobject3 gobject-introspection pyqt6-sip pip ]))
        nodePackages.nodejs
        typescript
        pnpm
        # see https://github.com/XNM1/linux-nixos-hyprland-config-dotfiles/blob/main/nixos/rust.nix for rust impl
        dotnetCorePackages.sdk_9_0-bin

        # LSPs
        python313Packages.python-lsp-server
        typescript-language-server
        vscode-langservers-extracted
        dockerfile-language-server-nodejs
        bash-language-server
        omnisharp-roslyn
        marksman
        markdown-oxide
        nil
        gopls
        delve
        emmet-language-server
        docker-compose-language-service
        hyprls
        jetbrains.rider
    ];
}
