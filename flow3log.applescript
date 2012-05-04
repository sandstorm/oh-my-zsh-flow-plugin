-- iTerm launching script for samo9789

set flow3_path to system attribute "flow3_path"


launch "iTerm"

tell application "iTerm"
	activate

	-- talk to the new terminal
	tell the first terminal

		-- create the project tab
		launch session "Default"

		tell the last session
			set name to "SystemLog"
			write text "tail -f " & flow3_path & "/Data/Logs/System_Development.log"
		end tell

		tell i term application "System Events" to keystroke "d" using command down

		tell the last session
			set name to "SecurityLog"
			write text "tail -f " & flow3_path & "/Data/Logs/Security_Development.log"
		end tell

	end tell

end tell