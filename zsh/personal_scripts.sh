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
    tmux split-pane -v
    tmux resize-pane -y 12 # set the lower panel height to 12 cells
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
    git filter-branch --env-filter 'if [ "$GIT_AUTHOR_EMAIL" = "$1" ]; then
    GIT_AUTHOR_EMAIL="$2";
    GIT_AUTHOR_NAME="Marcus Xavier";
    GIT_COMMITTER_EMAIL=$GIT_AUTHOR_EMAIL;
    GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"; fi' -- --all
}

#compile and run
function cnr() {
    gcc "$1"
    ./a.out
}

function startNodeProject() {
    mkdir "$1" && cd "$1" && npm init -y && npm i typescript tsx @types/node -D && npm tsc —init
}


function mergeFilesIntoArray() {
    jq -nR 'inputs as $a | inputs | reduce (inputs | select(. != "")) as $b ([]; . + [{name: $a, link: $b}])' "$1" "$2"
}

conda_init() {
    __conda_setup="$('/home/marcus/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/marcus/miniconda3/etc/profile.d/conda.sh" ]; then
            . "/home/marcus/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="/home/marcus/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
}

