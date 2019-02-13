# Set background
exec --no-startup-id ~/.fehbg

# Set font
font pango:Noto Sans 8

# Start up compton compositor
exec --no-startup-id compton -b

# Unclutter removes the mouse cursor after it hasn't been used for awhile.
exec --no-startup-id unclutter &
