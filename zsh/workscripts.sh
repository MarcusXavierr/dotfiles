#macro to kill the docker desktop app and the VM (excluding vmnetd -> it's a service)
function kdo() {
    ps ax|grep -i docker|egrep -iv 'grep|com.docker.vmnetd'|awk '{print $1}'|xargs kill
}

#Appmax era {{{
#macro to up work system
function upsistema() {
    open -a Docker
    sleep 12
    cd ~/appmax/sistema && make up
}

#macro to get jira task on branch's name without brackets
function get_jira_code() {
    code="$(git branch | grep "*" | awk '{print $2}' |  grep -o '[A-z0-9]*-\d\d\?\d\?\d\?')"
    if [ ! -z "$code" ]; then
        echo "$code"
    fi
}

#macro to get Jira task code on branch's name
function get_branch_code() {
    code="$(git branch | grep "*" | awk '{print $2}' |  grep -o '[A-z0-9]*-\d\d\?\d\?\d\?')"
    if [ ! -z "$code" ]; then
      echo "[$code]"
    fi
}

function get_branch_name() {
    echo "$(git branch | grep "*" | awk '{print $2}')"
}

function deploy_appjs() {
    lockFile="${1:-lockfile}"
    while [ -f "$lockFile" ];
    do
        sleep 10
    done

    git add public/assets/js/app.js
    git commit -m "$(get_branch_code) build app.js"
    git push
}

function merge_from_develop() {
    branch=$(get_branch_name)
    git checkout develop
    git pull
    git checkout $branch
    git merge develop
}


function checkout_from_code() {
    code=$1
    git checkout $(search_branch $code)
}

# a function to set tracked time on jira
function jira_track_time() {
    taksId="$1"
    trackedTime="$2"
    if [ ! -z $taskId ]; then
        jira issue worklog add $taskId "$trackedTime" --no-input
    fi
}

# a macro to help me to track my work time on jira
function pomodoro_jira() {
    branchCode="$(get_jira_code)"
    if [ ! -z $branchCode ]; then
        jira_track_time $branchCode "25min"
    fi
}

function solve_merge_app() {
    git checkout --theirs public/assets/js/app.js
    git add public/assets/js/app.js
    git commit
}


function search_branch() {
    branchCode=$1
    echo "$(git branch | grep $branchCode | awk '{print $NF}')"
}

function workide() {
    tmux split-pane -h
    tmux last-pane
    tmux split-pane -v
    tmux new-window
    tmux last-window
    docker exec -it -u root appmax_php7_develop71 bash
}

#}}}

function setup_log() {
    echo "open pbi homol"
    nohup xdg-open http://plataforma.homol.logcomex.io/signIn/ > /dev/null 2>&1&
    sleep 4

    echo "open jira"
    nohup xdg-open https://logcomex.atlassian.net/jira/software/c/projects/LOG/boards/135 > /dev/null 2>&1&
    sleep 3

    echo "open pbi homol again"
    nohup xdg-open http://plataforma.homol.logcomex.io/signIn/ > /dev/null 2>&1&
}

function start_task() {
    git checkout homol && git pull && git checkout -b "feature/${1}-homol"
}


function migrateFile() {
    src="$1"
    dst="$2"

    if [ -z "$src" ] || [ -z "$dst" ]; then
        echo "Usage: migrateFile <source> <destination>"
        return
    fi

    file=$(find "$src" -type f -print | fzf)
    folderDst=$(find "$dst" -type d -print | fzf)

    echo "Copying $file to $folderDst"
    cp "$file" "$folderDst"
}

function _say() {
    clear
    cowsay -f dragon "$1" | lolcat
    sleep 2
    clear
}

function _setupBasics() {
    _say "Let's get started"
    echo "Open product"
    xdg-open http://plataforma.homol.logcomex.io/ > /dev/null 2>&1
    sleep 1
    xdg-open http://plataforma.homol.logcomex.io/ > /dev/null 2>&1
    sleep 1
    xdg-open https://logcomex.atlassian.net/jira/software/c/projects/LOG/boards/188 > /dev/null 2>&1
    sleep 1

    echo "Open slack"
    slack &> /dev/null 2>&1 &
    echo "Done!"
}

function setupBackend() {
    SESSION_NAME="backend"
    _setupBasics
    _say "Now let's setup the backend"

    echo 'Start docker'
    echo marcus | sudo -S systemctl start docker

    echo 'Enter backend repository'
    cd ~/work/repositories/plataformabi-back
    docker-compose -f .docker/dev/docker-compose.yml up -d

    echo 'Enter elastic search repository'
    cd ~/work/repositories/plataformabi-conector-elastic-search
    docker compose up -d

    echo 'Go back so we can start the tmux session'
    cd -

    tmux new-session -d -s "$SESSION_NAME"
    sleep 0.5

    # Define targets
    TARGET_SESSION="$SESSION_NAME"
    TARGET_WINDOW_0="$SESSION_NAME:0"
    TARGET_WINDOW_1="$SESSION_NAME:1"

    # First create the bottom pane (split from the main pane)
    tmux split-pane -v -t "$SESSION_NAME:0.0"

    # Now the bottom pane is pane 1, resize it to be smaller (12 cells)
    tmux resize-pane -t "$SESSION_NAME:0.0" -y 12

    # Now split the top pane horizontally to get left and right panes
    tmux split-pane -h -t "$SESSION_NAME:0.1"

    # Create a new window
    tmux new-window -t "$TARGET_SESSION"

    # Rename window 1 to "backend"
    tmux rename-window -t "$TARGET_WINDOW_1" backend

    echo "Tmux session '$SESSION_NAME' configured."

    # Optional: Attach to the session
    tmux attach-session -t "$SESSION_NAME"

    echo "Open vim wiki"
    tmux send-keys -t "$SESSION_NAME:0.0" C-z 'vw' Enter
}
