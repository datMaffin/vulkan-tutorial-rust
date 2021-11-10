{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  nativeBuildInputs = [ 
    pkgs.python39
    pkgs.cacert
    pkgs.cargo
    pkgs.pkgconfig
  ];
  buildInputs = [
    # winit
    ## xorg
    pkgs.xorg.libX11
    pkgs.xorg.libXcursor
    pkgs.xorg.libXrandr
    pkgs.xorg.libXi
    ## wayland
    pkgs.libxkbcommon
    pkgs.wayland

    # vulkan (ash)
    pkgs.vulkan-loader
    pkgs.vulkan-validation-layers
  ];

  shellHook = ''
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${pkgs.lib.makeLibraryPath [ pkgs.vulkan-loader pkgs.wayland pkgs.libxkbcommon ]}"
    export VK_LAYER_PATH="${pkgs.vulkan-validation-layers}/share/vulkan/explicit_layer.d/"
  '';

}
