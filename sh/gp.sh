#!/usr/bin/env bash

# INFO: data w formacie 2023-01-05-00:30:20
DATA=$(date +%F-%T)

mkdir -p $HOME/tmp
GIT_PULL_DR=$HOME/tmp/git-pull-dry-run

# główny katalo repozytorium
GIT_ROOT_DIR=$(git rev-parse --show-toplevel)

function pomoc() {
    echo
    echo "Parametry"
    echo "  -v          - wywoałany z Vima"
    echo "  -f plik     - nazwa pliku"
    echo "  -h          - pomoc"
    echo
    exit 0
}

while getopts :vf:h option
do
    case "$option" in
        v) vim="yes"
            ;;
        f) file="$OPTARG"
            ;;
        h) pomoc
            ;;
        :) echo
            echo "Parametr -$OPTARG wymaga parametru."
            exit 1
            ;;
        \?) echo
            echo " Nieznany parametr -$OPTARG."
            ;;
    esac
done

# przechodzi do katalogu gdzie znajduje się plik podany jako -f plik
if [ -n "$vim" ]; then
    cd "$(dirname $(readlink -m $file))"
fi

git pull --dry-run 2>$GIT_PULL_DR

if [ -s $GIT_PULL_DR ]; then
    echo "Istnieją zmiany w zdalnym repozytorium Git"
    if [ -n $DESKTOP ]; then
        notify-send -t 20000 -a "gp.sh" "GP" "Istnieją zmiany w zdalnym repozytorium Git"
    fi
    REMOTE=1
fi

if [ ! -z $REMOTE ]; then
    echo
    read -p "Czy chcesz pobrać zmiany w zdalnym repozytorium Git? [T/n] "
    case $REPLY in
        t | T)
            git pull
            ;;
        n | N) ;;
        *)
            git pull
            ;;
    esac
fi

# sprawdza czy w pliku konfiguracyjnym .git/config jest wpis o nazwie użytkownika
grep name $GIT_ROOT_DIR/.git/config >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Brak informacji o koncie użytkownika w pliku .git/config"
    if [ -n $DESKTOP ]; then
        notify-send -t 20000 -a "gp.sh" "GP" "Brak informacji o koncie użytkownika w pliku .git/config"
    fi
    exit
fi

# sprawdza czy w pliku konfiguracyjnym .git/config jest wpis o adresie e-mail
grep email $GIT_ROOT_DIR/.git/config >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Brak informacji o adresie e-mail użytkownika w pliku .git/config"
    if [ -n $DESKTOP ]; then
        notify-send -t 20000 -a "gp.sh" "GP" "Brak informacji o adresie e-mail użytkownika w pliku .git/config"
    fi
    exit
fi

# sprawdza czy isnieje podany ID klucza do podpisu
function check_sigkey() {
    grep signingkey $GIT_ROOT_DIR/.git/config >/dev/null 2>&1
    if [ $? == 0 ]; then
        SIGNINGKEY=$(grep signingkey $GIT_ROOT_DIR/.git/config | cut -f 2 -d '=' | tr -d ' ')
    else
        msg_error "SIGKEY: Brak informacji o kluczu podpisu GPG."
        notify-send -t 20000 -a "gp.sh" "GP" "Brak informacji o podpisie GPG w .git/config"
        exit
    fi
}

# Sprawdza pod jaką nazwą został wywołany skrypt
if [[ ("$(basename $0)" == "gps.sh") || ("$(basename $0)" == "gps") ]]; then
    check_sigkey
    git add -A && git commit -S -m $DATA && git push
else
    git add -A && git commit -m $DATA && git push
fi
