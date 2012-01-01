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

Here, the features of the FLOW3 helper are explained:

flow3 Command
-------------

The FLOW3 plugin makes the ``flow3`` command available *inside every subdirectory* of the FLOW3
distribution. Thus, you can use ``flow3`` instead of ``./flow3``, and you do not have to be in
the base directory of your distribution for it. Example::

	cd <YourFlow3Distribution>
	./flow3 help    # this is the command you know already ;-)
	flow3 help      # shortcut to the one above, saves you two keystrokes -- yeah!
	cd Packages/Framework/TYPO3.FLOW3
	flow3 help      # now, that's actually quite cool, as the system will find the correct
	                # flow3 CLI executable by traversing the parent directories

Tab Completion
--------------

You can use *tab completion* on the flow3 subcommands, and the system will intelligently auto-
complete it. When autocompleting a fully written command, the full command reference is displayed::

	flow3 <TAB>                            # list all currently installed commands with a short description
	flow3 k<TAB>                           # autocompletes to "kickstart:"
	flow3 kickstart:<TAB>                  # show all commands starting with "kickstart:"
	flow3 kickstart:actioncontroller <TAB> # show the full help for kickstart:actioncontroller from FLOW3

Unit and Functional Testing
---------------------------

In order to save a few keystrokes when typing ``phpunit -c ..../Build/Common/PhpUnit/UnitTests.xml path/to/MyTest.php``,
there are two commands available: ``f3functionaltest`` and ``f3unittest``.

They, as well, can be called inside every subfolder of the FLOW3 distribution::

	cd <YourFlow3Distribution>
	f3unittest Packages/Framework/TYPO3.FLOW3/Tests/Unit       # Runs all unit tests; lot of typing necessary
	cd Packages/Framework/TYPO3.FLOW3/
	f3unittest Tests/Unit                                      # runs all unit tests, but with a lot less typing ;-)
	f3functionaltest Tests/Functional                          # runs the functional tests

Directly accessing FLOW3 Packages using cd
------------------------------------------

Often, I find myself working for longer timespans in a particular FLOW3 distribution, jumping between
the different packages of the distribution very often. In order to save some keystrokes, I found the "cdpath"
variable in ZSH, which can be defined like::

	cdpath=(/..../FLOW3Base/Packages/Framework /..../FLOW3Base/Packages/Application)

Then, you can directly ``cd`` into *any subdirectory* of the directories in ``cdpath``.
This enables you to directly jump to all packages inside the distribution::

	cd TYPO3.FLOW3
	cd SandstormMedia.Plumber

In order to work with multiple distributions more easily, you should set the ``flow3_distribution_paths``
variable inside your .zshrc to the base directories of all distributions::

	flow3_distribution_paths=(/Volumes/data/htdocs/FLOW3Base /Volumes/data/htdocs/Flow3Org /Volumes/data/htdocs/PackageRepositoryDistribution /Volumes/data/htdocs/SandstormMediaFlow3Distribution)

Then, you can use the ``f3-set-distribution`` command to choose which distribution shall be *active*
right now.

The system automatically updates the ``cdpath`` *in ALL running zsh instances* :-)

Internals
=========

The system caches temporary files inside `Data/Temporary/Development/.flow3-autocompletion*` in
order to not invoke ./flow3 too often (to improve performance).

Future Ideas
============

If you have suggestions on how to improve this software, pull requests etc are highly appreciated :-)

Or you can contact me directly as well, I usually hang out as ``skurfuerst`` in ``irc.freenode.net #flow3``.

License
=======

You can choose to use the LGPL or MIT license when you use this work.