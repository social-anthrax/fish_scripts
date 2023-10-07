function ll --wraps=ls --wraps=exa --description 'List contents of directory using long format'
  if set -q exa_no_git
    eza -lgh --icons $argv
  else
    eza -lgh --git --icons $argv
  end
end
