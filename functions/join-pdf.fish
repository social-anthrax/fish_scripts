function join-pdf
    argparse --name="join_pdf" "o/output=" -- $argv
    gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile="$_flag_output" $argv
end
