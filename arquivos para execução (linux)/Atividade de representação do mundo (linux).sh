#!/bin/sh
printf '\033c\033]0;%s\a' Atividade de representação do mundo
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Atividade de representação do mundo (linux).x86_64" "$@"
