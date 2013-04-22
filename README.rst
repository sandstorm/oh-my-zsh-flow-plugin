===============================
TYPO3 Flow Helper for Oh-my-ZSH
===============================
Copyright 2012-2013 Sebastian Kurfürst, sandstorm|media

Installation
============

First, you need to install oh-my-zsh from https://github.com/robbyrussell/oh-my-zsh.git

Then, install this repository inside ``custom/plugins`` of your oh-my-zsh directory::

	mkdir -p .oh-my-zsh/custom/plugins
	cd .oh-my-zsh/custom/plugins
	git clone git://github.com/sandstorm/oh-my-zsh-flow3-plugin.git flow

Afterwards, add the ``flow`` plugin to your oh-my-zsh config list.

Usage
=====

Here, the features of the TYPO3 Flow helper are explained:

flow Command
------------

The Flow plugin makes the ``flow`` command available *inside every subdirectory* of the TYPO3 Flow
distribution. Thus, you can use ``flow`` instead of ``./flow``, and you do not have to be in
the base directory of your distribution for it. Example::

	cd <YourFlowDistribution>
	./flow help    # this is the command you know already ;-)
	flow help      # shortcut to the one above, saves you two keystrokes -- yeah!
	cd Packages/Framework/TYPO3.Flow
	flow help      # now, that's actually quite cool, as the system will find the correct
	                # flow CLI executable by traversing the parent directories

NOTE: For Backwards Compatibility, the "flow3" command is still supported for
pre-2.0 instances.

Tab Completion
--------------

You can use *tab completion* on the flow subcommands, and the system will intelligently auto-
complete it. When autocompleting a fully written command, the full command reference is displayed::

	flow <TAB>                            # list all currently installed commands with a short description
	flow k<TAB>                           # autocompletes to "kickstart:"
	flow kickstart:<TAB>                  # show all commands starting with "kickstart:"
	flow kickstart:actioncontroller <TAB> # show the full help for kickstart:actioncontroller from TYPO3 Flow

Unit and Functional Testing
---------------------------

In order to save a few keystrokes when typing ``phpunit -c ..../Build/Common/PhpUnit/UnitTests.xml path/to/MyTest.php``,
there are two commands available: ``ffunctionaltest`` and ``funittest``.

They, as well, can be called inside every subfolder of the FLOW3 distribution::

	cd <YourFlowDistribution>
	funittest Packages/Framework/TYPO3.Flow/Tests/Unit       # Runs all unit tests; lot of typing necessary
	cd Packages/Framework/TYPO3.Flow/
	funittest Tests/Unit                                      # runs all unit tests, but with a lot less typing ;-)
	ffunctionaltest Tests/Functional                          # runs the functional tests

Directly accessing TYPO3 Flow Packages using cd
-----------------------------------------------

Often, I find myself working for longer timespans in a particular Flow distribution, jumping between
the different packages of the distribution very often. In order to save some keystrokes, I found the "cdpath"
variable in ZSH, which can be defined like::

	cdpath=(/..../FlowBase/Packages/Framework /..../FlowBase/Packages/Application)

Then, you can directly ``cd`` into *any subdirectory* of the directories in ``cdpath``.
This enables you to directly jump to all packages inside the distribution::

	cd TYPO3.Flow
	cd SandstormMedia.Plumber

In order to work with multiple distributions more easily, you should set the ``flow_distribution_paths``
variable inside your .zshrc to the base directories of all distributions::

	flow_distribution_paths=(/Volumes/data/htdocs/FlowBase /Volumes/data/htdocs/FlowTypo3Org /Volumes/data/htdocs/PackageRepositoryDistribution /Volumes/data/htdocs/SandstormMediaFlowDistribution)

Then, you can use the ``f-set-distribution`` command to choose which distribution shall be *active*
right now.

The system automatically updates the ``cdpath`` *in ALL running zsh instances* :-)

Internals
=========

The system caches temporary files inside `Data/Temporary/Development/.flow-autocompletion*` in
order to not invoke ./flow too often (to improve performance).

Future Ideas
============

If you have suggestions on how to improve this software, pull requests etc are highly appreciated :-)

Or you can contact me directly as well, I usually hang out as ``skurfuerst`` in ``irc.freenode.net #typo3-flow``.

License
=======

You can choose to use the LGPL or MIT license when you use this work.