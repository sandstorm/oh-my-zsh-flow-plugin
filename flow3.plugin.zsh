_flow3() {
  if _flow3_is_inside_base_distribution; then

    local startDirectory=`pwd`
    while [ ! -f flow3 ]; do
      cd ..
    done
    if (( $CURRENT > 2 )); then
      CURRENT=$CURRENT-1
      local cmd=${words[2]}
      shift words

      _flow3_subcommand
    else
      _flow3_main_commands
    fi
    cd $startDirectory
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

_flow3_is_inside_base_distribution() {
  local startDirectory=`pwd`
  while [[ ! -f flow3 ]]; do

    if [[ `pwd` == "/" ]]; then
      cd $startDirectory
      return 1
    fi
    cd ..
  done
  cd $startDirectory
  return 0
}

# FLOW3 command which can be executed inside sub directories of
# the FLOW3 distribution
flow3() {
  if _flow3_is_inside_base_distribution; then
  else
    echo "ERROR: FLOW3 not found inside a parent of current directory"
    return 1
  fi

  local startDirectory=`pwd`
  while [ ! -f flow3 ]; do
    cd ..
  done
  ./flow3 $@
  cd $startDirectory
}

f3unittest() {
  if _flow3_is_inside_base_distribution; then
  else
    echo "ERROR: FLOW3 not found inside a parent of current directory"
    return 1
  fi

  local startDirectory=`pwd`
  while [ ! -f flow3 ]; do
    cd ..
  done
  local flow3BaseDir=`pwd`
  cd $startDirectory
  phpunit -c $flow3BaseDir/Build/Common/PhpUnit/UnitTests.xml --colors $@
}

f3functionaltest() {
  if _flow3_is_inside_base_distribution; then
  else
    echo "ERROR: FLOW3 not found inside a parent of current directory"
    return 1
  fi

  local startDirectory=`pwd`
  while [ ! -f flow3 ]; do
    cd ..
  done
  local flow3BaseDir=`pwd`
  cd $startDirectory
  phpunit -c $flow3BaseDir/Build/Common/PhpUnit/FunctionalTests.xml --colors $@
}

compdef _flow3 flow3
