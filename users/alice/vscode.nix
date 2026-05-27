{ nixpkgs-unstable }: { pkgs, config, ... }:
{ home.packages = with pkgs; [
    nixpkgs-unstable.vscode
    nixpkgs-unstable.claude-code
  ];
  programs.vscode.package = nixpkgs-unstable.vscode;
}
