#!/bin/bash -eu

find "${HOME}/.config/autostart/" -type f -executable ! -name autostart.sh -exec {} \;

