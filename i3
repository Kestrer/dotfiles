# i3 config file (v4)
# See https://i3wm.org/docs/userguide.html for a complete reference!

# default modifier is mod4 (Super_L)
set $mod mod4

# Font for window titles. Will also be used by the bar unless a different font is used in the bar {} block below.
font pango:monospace 8

# start st
bindsym $mod+Return exec "$TERMINAL"
# start qutebrowser
bindsym $mod+space exec "$BROWSER"
# start rofi (a program launcher)
bindsym $mod+d exec "rofi -show run"
# start menu-calc (a calculator)
bindsym $mod+equal exec "rofi -show calc -modi calc -no-show-match -no-sort"

# kill window
bindsym $mod+Shift+q kill
# enter fullscreen
bindsym $mod+f fullscreen toggle

# change focus
bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right
bindsym $mod+p focus parent
bindsym $mod+c focus child
bindsym $mod+w focus mode_toggle

# move window
bindsym $mod+Shift+h move left
bindsym $mod+Shift+j move down
bindsym $mod+Shift+k move up
bindsym $mod+Shift+l move right

# change container layout (tabbed, tiled)
bindsym $mod+Shift+a layout tabbed
bindsym $mod+Shift+t layout toggle split
bindsym $mod+Shift+w floating toggle

# split
bindsym $mod+Shift+s split horizontal

# screenshots

# full screen
bindsym --release Print exec "scrot ~/screenshots/screenshot_%Y-%m-%d-%H:%M:%S.png"
# select area
bindsym --release $mod+Print exec "scrot -s ~/screenshots/screenshot_%Y-%m-%d-%H:%M:%S.png"
# current window
bindsym --release $mod+Shift+Print exec "scrot -u ~/screenshots/screenshot_%Y-%m-%d-%H:%M:%S.png"

# defalt workspace names
set $ws0 "0"
set $ws1 "1a"
set $ws2 "2"
set $ws3 "3a"
set $ws4 "4"
set $ws5 "5a"
set $ws6 "6"
set $ws7 "7a"
set $ws8 "8 music"
set $ws9 "9 server"

# monitor names
set $m1 "HDMI1"
set $m2 "DP1"

# workspaces on monitors
workspace $ws0 output $m1
workspace $ws1 output $m2
workspace $ws2 output $m1
workspace $ws3 output $m2
workspace $ws4 output $m1
workspace $ws5 output $m2
workspace $ws6 output $m1
workspace $ws7 output $m2
workspace $ws8 output $m1
workspace $ws9 output $m1

# switch to workspace
bindsym $mod+0 workspace $ws1; workspace $ws0
bindsym $mod+1 workspace $ws0; workspace $ws1
bindsym $mod+2 workspace $ws3; workspace $ws2
bindsym $mod+3 workspace $ws2; workspace $ws3
bindsym $mod+4 workspace $ws5; workspace $ws4
bindsym $mod+5 workspace $ws4; workspace $ws5
bindsym $mod+6 workspace $ws7; workspace $ws6
bindsym $mod+7 workspace $ws6; workspace $ws7
bindsym $mod+8 workspace $ws8
bindsym $mod+9 workspace $ws9
bindsym $mod+Control+l workspace next
bindsym $mod+Control+h workspace prev

# move focused container to workspace
bindsym $mod+Shift+0 move container to workspace $ws0
bindsym $mod+Shift+1 move container to workspace $ws1
bindsym $mod+Shift+2 move container to workspace $ws2
bindsym $mod+Shift+3 move container to workspace $ws3
bindsym $mod+Shift+4 move container to workspace $ws4
bindsym $mod+Shift+5 move container to workspace $ws5
bindsym $mod+Shift+6 move container to workspace $ws6
bindsym $mod+Shift+7 move container to workspace $ws7
bindsym $mod+Shift+8 move container to workspace $ws8
bindsym $mod+Shift+9 move container to workspace $ws9
bindsym $mod+Shift+Control+l move container to workspace next
bindsym $mod+Shift+Control+h move container to workspace prev

# reload the configuration file
bindsym $mod+Control+c reload
# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Control+r restart
# exit i3 (logs you out of your X session)
#bindsym $mod+Control+e exec "i3-nagbar -t warning -m 'E.' -B 'Exit i3' 'i3-msg exit'"
bindsym $mod+Control+e exit
# lock
bindsym --release $mod+s exec "slock"

# hide borders on the edge
hide_edge_borders smart
# disable title bars
default_border pixel 2

# resize window
mode "resize" {
        # These bindings trigger as soon as you enter the resize mode

        # Pressing left  will shrink the window’s width.
        # Pressing right will grow   the window’s width.
        # Pressing up    will shrink the window’s height.
        # Pressing down  will grow   the window’s height.

        bindsym h resize shrink width 10 px or 10 ppt  
        bindsym j resize grow height 10 px or 10 ppt   
        bindsym k resize shrink height 10 px or 10 ppt 
        bindsym l resize grow width 10 px or 10 ppt    

        # back to normal: Enter or Escape or $mod+r
        bindsym Return mode "default"
        bindsym Escape mode "default"
        bindsym $mod+r mode "default"
}

bindsym $mod+Shift+r mode "resize"

# solarized
set $base03  "#002b36"
set $base02  "#073642"
set $base01  "#586e75"
set $base00  "#657b83"
set $base0   "#839496"
set $base1   "#93a1a1"
set $base2   "#eee8d5"
set $base3   "#fdf6e3"
set $yellow  "#b58900"
set $orange  "#cb4b16"
set $red     "#dc322f"
set $magenta "#d33682"
set $violet  "#6c71c4"
set $blue    "#268bd2"
set $cyan    "#2aa198"
set $green   "#859900"

set $none    "#000000"

# Start i3bar to display a workspace bar (plus the system information i3status finds out, if available)
bar {
    colors {
        background $base03

        statusline $base3
        separator $base00

        #                  border  background text
        focused_workspace  $blue   $blue      $base3
        inactive_workspace $base03 $base03    $base00
        urgent_workspace   $red    $red       $base3
    }
    status_command i3status
    position top
}

#class                  border   bg       text     indicator child_border
client.focused          $violet  $violet  $base3   $base3    $violet
client.focused_inactive $violet  $base03  $base3   $base3    $base00
client.unfocused        $base03  $base03  $base00  $base3    $base00
client.urgent           $red     $red     $base3   $base3    $red
client.placeholder      $none    $violet  $base3   $none     $base00

client.background $base03

