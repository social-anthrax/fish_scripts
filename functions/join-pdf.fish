function join-pdf
    argparse --name="join_pdf" --description="MACOS Specific. Uses ghostscript to join multiple pdf files" "o/output=" -- $argv
    gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile="$_flag_output" $argv
end
