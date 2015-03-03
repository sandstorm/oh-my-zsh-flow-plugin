######################################
# Section: TYPO3 Flow Autocompletion Helper
######################################

#
# the ZSH autocompletion function for TYPO3 Flow (main entry point)
#
_flow() {
  if _flow_is_inside_base_distribution; then

    local startDirectory=`pwd`
    while [ ! -f flow ]; do
      cd ..
    done
    if (( $CURRENT > 2 )); then
      CURRENT=$CURRENT-1
      local cmd=${words[2]}
      shift words

      _flow_subcommand
    else
      _flow_main_commands
    fi
    cd $startDirectory
  fi
}
compdef _flow flow

#
# Autocompletion function for the main commands. Is executed
# from the root of the FLOW3 distribution.
#
_flow_main_commands() {
  if [ ! -f Data/Temporary/Development/.flow-autocompletion-maincommands ]; then
    mkdir -p Data/Temporary/Development/
    ./flow help | grep  "^[* ][ ]" | php $ZSH/custom/plugins/flow/helper-postprocess-cmdlist.php > Data/Temporary/Development/.flow-autocompletion-maincommands
  fi

  # fills up cmdlist variable
  eval "`cat Data/Temporary/Development/.flow-autocompletion-maincommands`"

  _describe 'flow command' cmdlist
}

#
# Autocompletion function for a single commands. Is executed
# from the root of the TYPO3 Flow distribution.
#
_flow_subcommand() {
  if [ ! -f Data/Temporary/Development/.flow-autocompletion-command-$cmd ]; then
    ./flow help $cmd > Data/Temporary/Development/.flow-autocompletion-command-$cmd
  fi

  compadd -x "`cat Data/Temporary/Development/.flow-autocompletion-command-$cmd`"
}

######################################
# Section: Internal Utility Functions
######################################

#
# Returns 0 if INSIDE a Flow distribution, and 1 otherwise.
# can be used like:
#     if _flow_is_inside_base_distribution; then ... ;fi
#
_flow_is_inside_base_distribution() {
  local startDirectory=`pwd`
  while [[ ! -f flow ]]; do

    if [[ `pwd` == "/" ]]; then
      cd $startDirectory
      return 1
    fi
    cd ..
  done
  cd $startDirectory
  return 0
}

######################################
# Section: Flow Command from subdir
######################################

#
# Implementation of a FLOW3 command which can be executed inside
# sub directories of the FLOW3 distribution; just finds the base
# distribution directory and calls the appropriate FLOW3 command
#
flow() {
  if _flow_is_inside_base_distribution; then
  else
    echo "ERROR: TYPO3 Flow not found inside a parent of current directory"
    return 1
  fi

  local startDirectory=`pwd`
  while [ ! -f flow ]; do
    cd ..
  done
  ./flow $@
  cd $startDirectory
}

######################################
# Section: Unit / Functional Test
######################################

#
# Implementation of a command to run unit tests
#
funittest() {
  if _flow_is_inside_base_distribution; then
  else
    echo "ERROR: TYPO3 Flow not found inside a parent of current directory"
    return 1
  fi

  local startDirectory=`pwd`
  while [ ! -f flow ]; do
    cd ..
  done
  local flowBaseDir=`pwd`
  local phpunit="phpunit"
  if [ -f bin/phpunit ]
  	local phpunit="$flowBaseDir/bin/phpunit"

  cd $startDirectory

  $phpunit -c $flowBaseDir/Build/BuildEssentials/PhpUnit/UnitTests.xml --colors $@
}

#
# Implementation of a command to run functional tests
#
ffunctionaltest() {
  if _flow_is_inside_base_distribution; then
  else
    echo "ERROR: TYPO3 Flow not found inside a parent of current directory"
    return 1
  fi

  local startDirectory=`pwd`
  while [ ! -f flow ]; do
    cd ..
  done
  local flowBaseDir=`pwd`
  local phpunit="phpunit"
  if [ -f bin/phpunit ]
  	local phpunit="$flowBaseDir/bin/phpunit"

  cd $startDirectory

  $phpunit -c $flowBaseDir/Build/BuildEssentials/PhpUnit/FunctionalTests.xml --colors $@
}

######################################
# Section: Behat (Behavioral) Tests
######################################
fbehattest() {
  if _flow_is_inside_base_distribution; then
  else
    echo "ERROR: TYPO3 Flow not found inside a parent of current directory"
    return 1
  fi

  local startDirectory=`pwd`
  while [ ! -f flow ]; do
    cd ..
  done
  local flowBaseDir=`pwd`

  if [ ! -f bin/behat ]; then
    echo "Behat not found, downloading flowpack/behat"
    composer require --dev --prefer-source --no-interaction flowpack/behat dev-master
    rm -Rf Data/Temporary
    rm -Rf Build/Behat
    echo "Setting up Behat..."
    ./flow behat:setup
  fi

  cd $startDirectory

  $flowBaseDir/bin/behat -c $@
}



######################################
# Section: f-package-foreach
######################################

f-package-foreach() {
  if _flow_is_inside_base_distribution; then
  else
    echo "ERROR: TYPO3 Flow not found inside a parent of current directory"
    return 1
  fi

  local startDirectory=`pwd`
  while [ ! -f flow ]; do
    cd ..
  done

  local flowBaseDir=`pwd`

  command=$*
  baseDirectory=`pwd`
  for directory in `composer status -vvv 2>&1 | grep "Executing command" | cut -d'(' -f2 | cut -d')' -f1 | grep -v "Packages/Libraries" | grep Packages`
  do
    cd "$directory"

    echo ''
    echo '--------------------------------------------'
    echo $directory
    echo '--------------------------------------------'
    eval $command

    cd "$baseDirectory"
  done

  cd $startDirectory

}

##################################################################################################
##################################################################################################



######################################
# Section: FLOW3 Autocompletion Helper (deprecated)
######################################

#
# the ZSH autocompletion function for FLOW3 (main entry point)
#
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
compdef _flow3 flow3

#
# Autocompletion function for the main commands. Is executed
# from the root of the FLOW3 distribution.
#
_flow3_main_commands() {
  if [ ! -f Data/Temporary/Development/.flow3-autocompletion-maincommands ]; then
    mkdir -p Data/Temporary/Development/
    ./flow3 help | grep  "^[* ][ ]" | php $ZSH/custom/plugins/flow3/helper-postprocess-cmdlist.php > Data/Temporary/Development/.flow3-autocompletion-maincommands
  fi

  # fills up cmdlist variable
  eval "`cat Data/Temporary/Development/.flow3-autocompletion-maincommands`"

  _describe 'flow3 command' cmdlist
}

#
# Autocompletion function for a single commands. Is executed
# from the root of the FLOW3 distribution.
#
_flow3_subcommand() {
  if [ ! -f Data/Temporary/Development/.flow3-autocompletion-command-$cmd ]; then
    ./flow3 help $cmd > Data/Temporary/Development/.flow3-autocompletion-command-$cmd
  fi

  compadd -x "`cat Data/Temporary/Development/.flow3-autocompletion-command-$cmd`"
}

######################################
# Section: Internal Utility Functions
######################################

#
# Returns 0 if INSIDE a FLOW3 distribution, and 1 otherwise.
# can be used like:
#     if _flow3_is_inside_base_distribution; then ... ;fi
#
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

######################################
# Section: FLOW3 Command from subdir
######################################

#
# Implementation of a FLOW3 command which can be executed inside
# sub directories of the FLOW3 distribution; just finds the base
# distribution directory and calls the appropriate FLOW3 command
#
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

######################################
# Section: Unit / Functional Test
######################################

#
# Implementation of a command to run unit tests
#
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

#
# Implementation of a command to run functional tests
#
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

######################################
# Section: FLOW3 Distribution maintenance helpers
######################################

#
# Utility to choose the current FLOW3 distribution. Sets cdpath correctly,
# such that packages inside a distribution are found automatically.
#
f-set-distribution() {
  echo "Enter the TYPO3 Flow distribution path number which should be active currently!"
  echo "--------------------------------------------------------------------------"
  local i=1
  for thePath in $flow_distribution_paths; do
    echo -n $i
    echo -n "  "
    echo $thePath
    i=` expr $i + 1`
  done
  echo -n "Your Choice: "
  read choice
  echo $flow_distribution_paths[$choice] > $ZSH/custom/plugins/flow3/f-environment-choice.txt

  # Now, after updating f-environment-choice.txt, send USR2 signal to
  # all running ZSH instances such that they reload
  ps xwwo pid,command | grep -v login | while read pid command; do
    if echo $command | egrep -- "(bin/|-)zsh" >/dev/null; then
      kill -USR2 $pid
    fi
  done
}

#
# Callback being executed when USR2 signal is fired
#
TRAPUSR2() {
  _f-update-distribution-path
}

#
# Internal helper to update cdpath
#
_f-update-distribution-path() {
  if [ -f $ZSH/custom/plugins/flow3/f-environment-choice.txt ]; then
  else
    return
  fi
  local fBasePath=`cat $ZSH/custom/plugins/flow/f-environment-choice.txt`

  # we need to add "." to the current CDPath, else Composer etc breaks...
  cdpath=(. $fBasePath/Packages/Framework/ $fBasePath/Packages/Application/ $fBasePath/Packages/Sites/)
  export CDPATH
}

# This helper needs to be run initially to set the CDPath correctly
_f-update-distribution-path

######################################
# Section: Open Flow Log in iTerm 2
######################################

flogs() {
  if _flow_is_inside_base_distribution; then
  else
    echo "ERROR: TYPO3 Flow not found inside a parent of current directory"
    return 1
  fi

  local startDirectory=`pwd`
  while [ ! -f flow ]; do
    cd ..
  done
  local flowBaseDir=`pwd`
  cd $startDirectory

  flow_path="$flowBaseDir" osascript $ZSH/custom/plugins/flow/flowlog.applescript

}