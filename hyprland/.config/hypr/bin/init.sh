#!/usr/bin/env bash

sleep 1
for ((i = 1; i <= 12; i++)); do
	hyprctl dispatch exec '[workspace special:'"$i"'] $HOME/.config/hypr/bin/placeholder -n '"$i"
done
