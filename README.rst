==========================
FLOW3 Helper for Oh-my-ZSH
==========================
(c) 2012 Sebastian Kurfürst, sandstorm|media

Installation
============

First, you need to install oh-my-zsh from https://github.com/robbyrussell/oh-my-zsh.git

Then, install this repository inside ``custom/plugins`` of your oh-my-zsh directory::

	mkdir -p .oh-my-zsh/custom/plugins
	cd .oh-my-zsh/custom/plugins
	git clone git://github.com/sandstorm/oh-my-zsh-flow3-plugin.git flow3


Usage
=====

The FLOW3 plugin makes the ``flow3`` command available *inside every subdirectory* of the FLOW3
distribution. Thus, you can use ``flow3`` instead of ``./flow3``, and you do not have to be in
the base directory of your distribution for it.

You can use *tab completion* on the flow3 subcommands, and the system will intelligently auto-
complete it. When autocompleting a fully written command, the full command reference is displayed::

	flow3 <TAB>                            # list all currently installed commands with a short description
	flow3 k<TAB>                           # autocompletes to "kickstart:"
	flow3 kickstart:<TAB>                  # show all commands starting with "kickstart:"
	flow3 kickstart:actioncontroller <TAB> # show the full help for kickstart:actioncontroller from FLOW3


*f3unittest* TODO

*f3functionaltest* TODO

Internals
=========

The system caches temporary files inside `Data/Temporary/Development/.flow3-autocompletion*` in
order to not invoke ./flow3 too often (to improve performance).

License
=======

You can choose to use the LGPL or MIT license when you use this work.