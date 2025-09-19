#!/usr/bin/env bash

if [[ ! -f "/usr/share/psd/browsers/brave" ]] && [[ -f "/usr/share/psd/contrib/brave" ]] && [[ -d "/usr/share/psd/browsers" ]]; then
    cp /usr/share/psd/contrib/brave /usr/share/psd/browsers/brave
fi
