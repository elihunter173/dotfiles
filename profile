# Set static wallpaper
feh --bg-fill ~/Pictures/wallpaper
# Set random wallpaper (every 20 minutes or 1200 seconds)
#watch -n 1200 feh --randomize --bg-fill ~/Pictures/wallpapers/*

PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin" # Adds rubygem to current PATH
export GEM_HOME=$HOME/.gem # Allows the user to install rubygems
