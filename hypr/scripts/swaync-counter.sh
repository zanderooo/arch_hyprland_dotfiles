#!/bin/bash
COUNT=$(swaync-client -c)
[ "$COUNT" -gt 0 ] && echo "󰂚 $COUNT" || echo "󰂛"
