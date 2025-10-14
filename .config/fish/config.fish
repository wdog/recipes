if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting


set -gx tide_right_prompt_items status cmd_duration jobs direnv time docker_wdog
set -gx tide_left_prompt_items context pwd git_wdog newline character

# set -gx tide_pwd_bg_color 55286f
set -gx tide_pwd_bg_color 004145
set -gx tide_pwd_color_dirs 33a393
set -gx tide_pwd_color_anchors FFFFFF
set -gx tide_pwd_color_truncated_dirs D8B402


set -gx tide_docker_wdog_bg_color b73562
set -gx tide_docker_wdog_color ffffff

set -gx tide_git_wdog_bg_color b73562
set -gx tide_git_wdog_color 000000
set -gx tide_git_wdog_bg_color_unstable C4A000
set -gx tide_git_wdog_bg_color_urgent CC0000
set -gx tide_git_wdog_color_branch 000000
set -gx tide_git_wdog_color_conflicted 000000
set -gx tide_git_wdog_color_dirty 000000
set -gx tide_git_wdog_color_operation 000000
set -gx tide_git_wdog_color_staged 000000
set -gx tide_git_wdog_color_stash 000000
set -gx tide_git_wdog_color_untracked 000000
set -gx tide_git_wdog_color_upstream 000000
set -gx tide_git_wdog_icon \uf126 " "
set -gx tide_git_wdog_truncation_strategy \x1d
set -gx tide_git_wdog_truncation_length 24

set -gx tide_time_color ffffff
set -gx tide_time_bg_color 004145
set -gx tide_time_format "%H:%M:%S"


set -gx tide_context_color_ssh 210B2C
set -gx tide_context_bg_color BC96E6

# tide configure --auto --style=Rainbow \
#     --prompt_colors='True color' \
#     --show_time=No \
#     --rainbow_prompt_separators=Angled \
#     --powerline_prompt_heads=Sharp \
#     --powerline_prompt_tails=Round \
#     --powerline_prompt_style='Two lines, character' \
#     --prompt_connection=Solid \
#     --powerline_right_prompt_frame=No \
#     --prompt_connection_andor_frame_color=Dark \
#     --prompt_spacing=Sparse \
#     --icons='Many icons' \
#     --transient=No



alias claude="/home/wdog/.claude/local/claude"
