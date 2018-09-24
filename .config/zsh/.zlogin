eval $(ssh-agent) >/dev/null

if [[ -z "$DISPLAY" && "$XDG_VTNR" -eq 1 ]]; then
    # Qt5 styling (requires gtk2 and AUR package qt5-styleplugins...)
    export QT_QPA_PLATFORMTHEME='gtk2'
    export QT_STYLE_OVERRIDE='gtk2'

    # Start i3
    #exec startx

    # Wayland- / sway-specific settings
    export CLUTTER_BACKEND=wayland
    export QT_QPA_PLATFORM=wayland
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    export QT_WAYLAND_FORCE_DPI=96
    export SDL_VIDEODRIVER=wayland
    export _JAVA_AWT_WM_NONREPARENTING=1

    # Start sway
    exec sway > ~/.local/share/sway.out 2> ~/.local/share/sway.err
fi
