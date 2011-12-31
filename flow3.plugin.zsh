_flow3() {
  if [ -f flow3 ]; then
    if (( $CURRENT > 2 )); then
      CURRENT=$CURRENT-1
      local cmd=${words[2]}
      shift words

      _flow3_subcommand
    else
      _flow3_main_commands
    fi
  fi
}

_flow3_main_commands() {
  if [ ! -f Data/Temporary/Development/.flow3-autocompletion-maincommands ]; then
    ./flow3 help | grep  "^[* ][ ]" | php $ZSH/custom/plugins/flow3/helper-postprocess-cmdlist.php > Data/Temporary/Development/.flow3-autocompletion-maincommands
  fi

  # fills up cmdlist variable
  eval "`cat Data/Temporary/Development/.flow3-autocompletion-maincommands`"

  _describe 'flow3 command' cmdlist
}

_flow3_subcommand() {
  if [ ! -f Data/Temporary/Development/.flow3-autocompletion-command-$cmd ]; then
    ./flow3 help $cmd > Data/Temporary/Development/.flow3-autocompletion-command-$cmd
  fi

  compadd -x "`cat Data/Temporary/Development/.flow3-autocompletion-command-$cmd`"
}




compdef _flow3 flow3
