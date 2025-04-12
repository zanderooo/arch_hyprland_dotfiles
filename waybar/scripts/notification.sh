#!/bin/bash
COUNT=$(swaync-client -c)
if [ "$COUNT" -gt 0 ]; then
    echo "{\"text\":\"󰂚 $COUNT\", \"class\":\"notification\"}"
else
    echo "{\"text\":\"󰂛\", \"class\":\"notification\"}"
fi
