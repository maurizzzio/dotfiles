#!/bin/bash

# when charging
#
# Now drawing from 'AC Power'
#  -InternalBattery-0     98%; charging; 0:28 remaining
# Now drawing from 'AC Power'
#  -InternalBattery-0     98%; charging; (no estimate)
#
# when discharging
#
# Now drawing from 'Battery Power'
#  -InternalBattery-0     98%; discharging; 7:00 remaining
# Now drawing from 'Battery Power'
#  -InternalBattery-0     98%; discharging; (no estimate)
#
# when charged
#
# Now drawing from 'AC Power'
#  -InternalBattery-0     100%; charged; 0:00 remaining
#
info="$(pmset -g ps)"

if [[ $info =~ ([0-9]{1,3})%\;[[:space:]]*([a-z]*)\;[[:space:]](.*) ]]; then
  # battery left
  # e.g.  100
  battery_left=${BASH_REMATCH[1]}
  battery_status=${BASH_REMATCH[2]}
  battery_estimate=${BASH_REMATCH[3]}
  # output examples
  # - 100% - charged
  # - 50% - (1:23 remaining) - discharging
  output="$battery_left%"
  if [[ ! $battery_estimate == "0:00 remaining" ]]; then
    output="$output - $battery_estimate"
  fi

  if [[ ! $battery_status == "charged" ]]; then
    output="$output - $battery_status"
  fi

  echo "$output"
fi

