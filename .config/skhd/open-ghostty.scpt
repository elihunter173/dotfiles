tell application "Ghostty"
    if it is running
        tell application "System Events" to tell process "Ghostty"
            click menu item "New Window" of menu "File" of menu bar 1
        end tell
    else
        activate
    end if
end tell
