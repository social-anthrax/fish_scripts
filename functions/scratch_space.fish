function scratch_space --description "Puts the user into a new tmp dir until exit"
    status job-control full
    set -lx scratch_space_dir (mktemp -d -t 'scratch_space')
    set -l scratch_basename "./$(basename $scratch_space_dir)"
    ln -s "$scratch_space_dir" "$scratch_basename"

    set -lx fish_greeting (echo -e "Scratching allowed, no biting. \nYou're going to \x1b[9mBrazil!\x1b[29m $scratch_space_dir" | string collect)
    fish -C "cd ./$scratch_basename"

    rm "./$scratch_basename"
end
