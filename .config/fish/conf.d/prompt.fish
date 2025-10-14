# Terminal-specific prompt configuration
# Automatically adjust Tide prompt icons based on terminal type

if test "$TERM" = "linux"
    # Console/TTY mode - disable icons, use simple ASCII characters

    # Character prompt
    set -gx tide_character_icon ">"
    set -gx tide_character_vi_icon_default "<"
    set -gx tide_character_vi_icon_replace ">"
    set -gx tide_character_vi_icon_visual "V"

    # Git
    set -gx tide_git_icon ""
    set -gx tide_git_wdog_icon ""

    # Docker
    set -gx tide_docker_icon ""

    # Command duration
    set -gx tide_cmd_duration_icon ""

    # Other common icons
    set -gx tide_aws_icon ""
    set -gx tide_crystal_icon ""
    set -gx tide_direnv_icon ""
    set -gx tide_distrobox_icon ""
    set -gx tide_elixir_icon ""
    set -gx tide_gcloud_icon ""
    set -gx tide_go_icon ""
    set -gx tide_java_icon ""
    set -gx tide_jobs_icon ""
    set -gx tide_kotlin_icon ""
    set -gx tide_kubectl_icon ""
    set -gx tide_nix_shell_icon ""
    set -gx tide_node_icon ""
    set -gx tide_php_icon ""
    set -gx tide_pulumi_icon ""
    set -gx tide_python_icon ""
    set -gx tide_ruby_icon ""
    set -gx tide_rustc_icon ""
    set -gx tide_shlvl_icon ""
    set -gx tide_status_icon ""
    set -gx tide_terraform_icon ""
    set -gx tide_toolbox_icon ""
    set -gx tide_vi_mode_icon ""
else
    # Alacritty/graphical terminal mode - icons already configured in config.fish
    # No action needed, config.fish settings will be used
end
