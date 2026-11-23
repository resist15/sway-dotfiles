#!/bin/sh
# GPU usage and temperature, e.g. "6%·41°C" (dot dimmed)
nvidia-smi --query-gpu=utilization.gpu,temperature.gpu --format=csv,noheader,nounits |
    awk -F', ' '{ printf "%s%%<span color=\"#707880\">·</span>%s°C\n", $1, $2 }'
