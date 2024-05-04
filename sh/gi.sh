#!/usr/bin/env bash

# INFO: Skrypt pobierający informacje o repozytorium Git

# główny katalo repozytorium
function git_root_dir() {
    if [ "$1" == "vim" ]; then
        MSG=echo
    else
        MSG=msg_info
    fi
    GIT_ROOT=$(git rev-parse --show-toplevel)
    if [ ! "$?" -eq 0 ]; then
        $MSG "To nie jest repozytorium Git"
        exit
    fi
}

function check_git_dir() {
    if [ "$1" == "vim" ]; then
        MSG=echo
        git_root_dir vim
    else
        MSG=msg_info
        git_root_dir
    fi
    # git_root_dir
    $MSG "DIR: $GIT_ROOT "
}

function check_git_url() {
    if [ "$1" == "vim" ]; then
        MSG=echo
        git_root_dir vim
    else
        MSG=msg_info
        git_root_dir
    fi
    # git_root_dir
    grep url $GIT_ROOT/.git/config >/dev/null 2>&1
    if [ $? == 0 ]; then
        URL=$(grep url $GIT_ROOT/.git/config | cut -f 2 -d '=' | tr -d ' ')
        # msg_info "REPO: $URL "
        $MSG "REPO: $URL "
    fi
}

function check_git_user_name() {
    if [ "$1" == "vim" ]; then
        MSG_INFO=echo
        MSG_ERROR=echo
    else
        MSG_INFO=msg_info
        MSG_ERROR=msg_error
    fi
    git_root_dir
    grep name $GIT_ROOT/.git/config >/dev/null 2>&1
    if [ $? == 0 ]; then
        NAME=$(grep name $GIT_ROOT/.git/config | cut -f 2 -d '=' | tr -d ' ')
        # msg_info "USER:  $NAME"
        $MSG_INFO "USER:  $NAME"
    else
        # msg_error "USER:  Brak informacji o koncie użytkownika."
        $MSG_ERROR "USER:  Brak informacji o koncie użytkownika."
    fi
}

function check_git_user_email() {
    if [ "$1" == "vim" ]; then
        MSG_INFO=echo
        MSG_ERROR=echo
    else
        MSG_INFO=msg_info
        MSG_ERROR=msg_error
    fi
    git_root_dir
    grep email $GIT_ROOT/.git/config >/dev/null 2>&1
    if [ $? == 0 ]; then
        EMAIL=$(grep email $GIT_ROOT/.git/config | cut -f 2 -d '=' | tr -d ' ')
        # msg_info "EMAIL: $EMAIL"
        $MSG_INFO "EMAIL: $EMAIL"
    else
        # msg_error "EMAIL: Brak informacji o adresie e-mail użytkownika."
        $MSG_ERROR "EMAIL: Brak informacji o adresie e-mail użytkownika."
    fi
}

function check_git_sigkey() {
    if [ "$1" == "vim" ]; then
        MSG_INFO=echo
        MSG_ERROR=echo
    else
        MSG_INFO=msg_info
        MSG_ERROR=msg_error
    fi
    git_root_dir
    grep signingkey $GIT_ROOT/.git/config >/dev/null 2>&1
    if [ $? == 0 ]; then
        SIGNINGKEY=$(grep signingkey $GIT_ROOT/.git/config | cut -f 2 -d '=' | tr -d ' ')
        # msg_info "SIGKEY: $SIGNINGKEY"
        $MSG_INFO "SIGKEY: $SIGNINGKEY"
    else
        # msg_error "SIGKEY: Brak informacji o kluczu podpisu GPG."
        $MSG_ERROR "SIGKEY: Brak informacji o kluczu podpisu GPG."
    fi
}

if [ "$1" == "vim" ]; then
    check_git_url vim
    check_git_dir vim
    check_git_user_name vim
    check_git_user_email vim
    check_git_sigkey vim
else
    check_git_url
    check_git_dir
    check_git_user_name
    check_git_user_email
    check_git_sigkey
fi
