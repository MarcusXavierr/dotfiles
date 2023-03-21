#macro to kill the docker desktop app and the VM (excluding vmnetd -> it's a service)
function kdo() {
    ps ax|grep -i docker|egrep -iv 'grep|com.docker.vmnetd'|awk '{print $1}'|xargs kill
}

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

#macro to wait app.js to build and then commit my build
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

function search_branch() {
    branchCode=$1
    echo "$(git branch | grep $branchCode | awk '{print $NF}')"
}

function checkout_from_code() {
    code=$1
    git checkout $(search_branch $code)
}

function workide() {
    tmux split-pane -h
    tmux last-pane
    tmux split-pane -v
    tmux new-window
    tmux last-window
    docker exec -it -u root appmax_php7_develop71 bash
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
