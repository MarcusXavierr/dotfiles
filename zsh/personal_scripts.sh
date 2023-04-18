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

# organize tmux vertically
function ide() {
    tmux split-pane -h
    tmux last-pane
    tmux split-pane -v
    tmux new-window
}

# organize tmux horizontally
function ideh() {
    tmux split-pane -v -p 30
    tmux split-pane -h
    tmux new-window
}

# Just a script to open a tmux session ready to learn lisp ｟😎｠
function lisp() {
    tmux new-session -s ls -d -c ~/Projects/simple-data
    tmux attach-session -t ls
}

function lgwt() {
    tmux new-session -s go -d -c ~/Projects/curso_golang_testes/again
    tmux attach-session -t go
}

function own_commits() {
    git filter-branch --env-filter 'if [ "$GIT_AUTHOR_EMAIL" = "marcus.xavier@appmax.com.br" ]; then
    GIT_AUTHOR_EMAIL=marcusxavierr123@gmail.com;
    GIT_AUTHOR_NAME="Marcus Xavier";
    GIT_COMMITTER_EMAIL=$GIT_AUTHOR_EMAIL;
    GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"; fi' -- --all
}
