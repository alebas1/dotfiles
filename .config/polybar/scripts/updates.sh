#! /bin/sh

if ! UPDATES_PACMAN=$(checkupdates 2> /dev/null | wc -l ); then
    UPDATES_PACMAN=0
fi

if ! UPDATES_AUR=$(yay -Qum 2> /dev/null | wc -l); then
# if ! UPDATES_AUR=$(paru -Qum 2> /dev/null | wc -l); then
    UPDATES_AUR=0
fi
# UPDATES_AUR=0

get_total_updates() { UPDATES=$((UPDATES_PACMAN + UPDATES_AUR)); }

while true; do
    get_total_updates

    # when there are updates available
    # every 200 seconds another check for updates is done
    while (( UPDATES > 0 )); do
        echo "$UPDATES"
        sleep 200
        get_total_updates
    done

    # when no updates are available, use a longer loop, this saves on CPU
    while (( UPDATES == 0 )); do
        echo "0"
        sleep 1800
        get_total_updates
    done
done
