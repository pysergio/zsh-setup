# Work aliases
eval "$(thefuck --alias)"
alias prodrun="git tag -f prodrun && git push -f origin prodrun"
alias devrun="git tag -f devrun && git push -f origin devrun"
alias edgerun="git tag -f edgerun && git push -f origin edgerun"

alias format="poetry run scripts/format"
alias test="poetry run scripts/test"
alias lint="poetry run scripts/lint"

# git
alias g='git'
alias gg='git grep -n'
alias gs='git st'
alias gd='git diff'
alias gl="git log --pretty=format:'%C(dim)%h%Creset  %C(green)%s%Creset %C(yellow)<%an>%Creset %C(dim)%cr%Creset %C(blue)%D%Creset' --name-only"
alias gdt='git difftool -d origin/dev .'
alias ga='git add'
alias b='git_branch'
alias push='git push'
alias pull='git pull -p'
alias p='bpython'
alias pytest3='python3 -m pytest -vvvv -o log_cli=true -p no:cacheprovider'
alias fco='git checkout | fzh'

#systemd shortcuts
alias dctl='systemctl'
alias dst='systemctl status'
alias dstart='systemctl start'
alias dstop='systemctl stop'
alias drestart='systemctl restart'
alias dlog='journalctl'

function ff_find(){
    #find file
	# shellcheck disable=SC2145
	find . -path "*$@*"
}

function fd_find(){
    # find directory
	# shellcheck disable=SC2145
	find . -type d -name "*$@*"
}

function rgrep_all(){
    # run rgrep .
    rgrep "$@" .
}

function fzf_git_checkout() {
    local branches branch
    branches=$(git branch -a --color=always | grep -v '/HEAD\s' | sort | uniq | fzf --ansi --multi --preview 'git log --oneline --graph --decorate --color=always --abbrev-commit $(echo {} | sed "s/.* //")')
    if [ -n "$branches" ]; then
        branch=$(echo "$branches" | sed 's/.* //' | sed 's#remotes/[^/]*/##')
        git checkout "$branch"
    fi
}

alias rg='rgrep_all '
alias fd='fd_find '
alias ff='ff_find '
alias s='ssh '

alias fh='history | fzf '
alias fco='fzf_git_checkout'

function pyclean () {
    find . -type f -name "*.py[co]" -delete
    find . -type d -name "__pycache__" -delete
}

function ftag() {
    git tag -f $1 && git push -f origin $1
}

function run() {
    local application b n
    b=$(tput bold)
    n=$(tput sgr0)
    case $1 in
        (t*) application=terminal ;;
        (d*) application=data_api ;;
        (w*) application=widgets ;;
        (""|app) application=app ;;
        (*)
        echo "Bad argument='$1'. Suports only: (${b}t${n}erminal|${b}d${n}ata_api|${b}w${n}idgets|<default>app)." >&2;
        return ;;
    esac
    main_filename=$(ls app | grep main)
    poetry run uvicorn app.${main_filename%.py}:$application --reload
}

complete -C /usr/bin/minio-cli minio-cli

function passgen() {
    local length=$1
    if [ -z "$length" ]
    then
        length=16
    fi
    openssl rand -base64 $length | tr -d "=+/" | cut -c1-$length
}
