#macro to search for a file in zettelkasten folder
function zettelkasten() {
    fileName="$(fzf --height 40% --reverse --border --print-query | tail -1)"
    if [[ $(echo $fileName |grep -o . | wc -l | grep -o '\d') == "0" ]]; then
        return 1
    fi
    case "$fileName" in
        *.md) nvim "$fileName" ;;
        *) nvim "Zettelkasten/$fileName.md" ;;
    esac
}

