function fish_right_prompt -d "Prints right prompt"
  set -g __fish_git_prompt_show_informative_status
  set -g __fish_git_prompt_showcolorhints
  set -g __fish_git_prompt_showupstream "informative"

  set -g __fish_git_prompt_color_prefix green --bold
  set -g __fish_git_prompt_color_suffix green --bold
  set -g __fish_git_prompt_color_branch green --bold
  set -g __fish_git_prompt_color_branch_detached red --bold
  set -g __fish_git_prompt_color_cleanstate green --bold

  set -g __fish_git_prompt_char_upstream_ahead "↑"
  set -g __fish_git_prompt_char_upstream_behind "↓"
  set -g __fish_git_prompt_char_upstream_prefix ""

  set -g __fish_git_prompt_char_stagedstate "●"
  set -g __fish_git_prompt_char_dirtystate "✚"
  set -g __fish_git_prompt_char_untrackedfiles "…"
  set -g __fish_git_prompt_char_conflictedstate "✖"
  set -g __fish_git_prompt_char_cleanstate "✔"

  fish_git_prompt
end
