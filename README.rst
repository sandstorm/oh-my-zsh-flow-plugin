===================================
Flow Framework Helper for Oh-my-ZSH
===================================

Copyright 2012-2019 Sebastian Kurfürst, sandstorm|media

Installation
============

oh-my-zsh
---------

First, you need to install oh-my-zsh from https://github.com/robbyrussell/oh-my-zsh.git

Then, install this repository inside ``custom/plugins`` of your oh-my-zsh directory::

	mkdir -p .oh-my-zsh/custom/plugins
	cd .oh-my-zsh/custom/plugins
	git clone git@github.com:sandstorm/oh-my-zsh-flow-plugin.git flow

Afterwards, add the ``flow`` plugin to your oh-my-zsh config list.

antigen
-------

If you're using the Antigen framework (https://github.com/zsh-users/antigen), add ``antigen bundle sandstorm/oh-my-zsh-flow-plugin`` to your ``.zshrc`` Antigen will automatically clone and install the plugin the next time you open a new terminal session.

zgenom
------

If you're using the zgen framework (https://github.com/jandamm/zgenom), add ``zgenom load sandstorm/oh-my-zsh-flow-plugin`` to your ``.zshrc`` with your other ``zgenom load`` and/or ``zgen load`` statements. Zgenom will automatically clone and install the plugin the next time you run ``zgenom save``.

Usage
=====

Here, the features of the Flow helper are explained:

flow Command
------------

The Flow plugin makes the ``flow`` command available *inside every subdirectory* of the Flow
distribution. Thus, you can use ``flow`` instead of ``./flow``, and you do not have to be in
the base directory of your distribution for it. Example::

	cd <YourFlowDistribution>
	./flow help    # this is the command you know already ;-)
	flow help      # shortcut to the one above, saves you two keystrokes -- yeah!
	cd Packages/Application/Acme.Demo
	flow help      # now, that's actually quite cool, as the system will find the correct
	               # flow CLI executable by traversing the parent directories

Tab Completion
--------------

You can use *tab completion* on the flow subcommands, and the system will intelligently auto-
complete it. When autocompleting a fully written command, the full command reference is displayed::

	flow <TAB>                            # list all currently installed commands with a short description
	flow k<TAB>                           # autocompletes to "kickstart:"
	flow kickstart:<TAB>                  # show all commands starting with "kickstart:"
	flow kickstart:actioncontroller <TAB> # show the full help for kickstart:actioncontroller from Flow

Unit and Functional Testing
---------------------------

In order to save a few keystrokes when typing ``phpunit -c ..../Build/Common/PhpUnit/UnitTests.xml path/to/MyTest.php``,
there are two commands available: ``ffunctionaltest`` and ``funittest``.

They, as well, can be called inside every subfolder of the Flow distribution::

	cd <YourFlowDistribution>
	funittest Packages/Application/Acme.Demo/Tests/Unit       # Runs all unit tests; lot of typing necessary
	cd Packages/Application/Acme.Demo/
	funittest Tests/Unit                                      # runs all unit tests, but with a lot less typing ;-)
	ffunctionaltest Tests/Functional                          # runs the functional tests

Directly accessing Flow Packages using cd
-----------------------------------------

Often, I find myself working for longer timespans in a particular Flow distribution, jumping between
the different packages of the distribution very often. In order to save some keystrokes, I found the "cdpath"
variable in ZSH, which can be defined like::

	cdpath=(/..../FlowBase/Packages/Framework /..../FlowBase/Packages/Application)

Then, you can directly ``cd`` into *any subdirectory* of the directories in ``cdpath``.
This enables you to directly jump to all packages inside the distribution::

	cd Acme.Demo
	cd SandstormMedia.Plumber

In order to work with multiple distributions more easily, you should set the ``flow_distribution_paths``
variable inside your .zshrc to the base directories of all distributions::

	flow_distribution_paths=(/Volumes/data/htdocs/FlowBase /Volumes/data/htdocs/PackageRepositoryDistribution /Volumes/data/htdocs/SandstormMediaFlowDistribution)

Then, you can use the ``f-set-distribution`` command to choose which distribution shall be *active*
right now.

The system automatically updates the ``cdpath`` *in ALL running zsh instances* :-)


f-package-foreach
-----------------

Often, I need to run some command in all packages. Before using composer,
this was easy using ``git submodule foreach``. This is why we install
``f-package-foreach`` which loops through all Flow packages; skipping
all ``Packages/Libraries``.

Usage:

``f-package-foreach <your-command>``

This command can be run from any subdirectory inside the current Flow
distribution, and will always loop through all packages.

Internals
=========

The system caches temporary files inside `Data/Temporary/Development/.flow-autocompletion*` in
order to not invoke ./flow too often (to improve performance).

Future Ideas
============

If you have suggestions on how to improve this software, pull requests etc are highly appreciated :-)

Or you can contact me directly as well, I usually hang out as ``sebastian`` in ``slack.neos.io``.

License
=======

You can choose to use the LGPL or MIT license when you use this work.
