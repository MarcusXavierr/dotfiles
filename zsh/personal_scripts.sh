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

function genWeeklyWiki() {
    # Get the current week number (considering the week starts on Sunday)
    week=$(date +%U)

    # Get the start (Sunday) and end (Saturday) days of the current week
    start_day=$(date -d "$(date +%Y-%m-01) +$((($week - 1) * 7 + 1)) days" +%d-%b)
    end_day=$(date -d "$(date +%Y-%m-01) +$((($week - 1) * 7 + 7)) days" +%d-%b)

    # Create the directory name
    directory_name=$(date +%Y)__${start_day}_${end_day}

    # Create the directory
    mkdir $directory_name

    # Create index.md file inside the created directory
    touch ./$directory_name/index.md

    # Modify Home.md file in the current directory to add the link to index.md
    sed -i "1i [Week $week | $start_day - $end_day](${directory_name}/index.md)" Home.md
}
