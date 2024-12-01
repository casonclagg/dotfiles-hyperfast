cat > ~/.config/i3blocks/config << 'EOL'
# Global properties
separator_block_width=30
markup=pango

[cpu_usage]
command=grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {printf "%2.0f% CPU", usage}'
interval=5

[temperature]
command=echo "$(cat /sys/class/thermal/thermal_zone0/temp | awk '{printf "%d°C", $1/1000}')"
interval=5

[gpu-temp]
command=cat /sys/class/hwmon/hwmon*/temp*_input 2>/dev/null | awk '$1 > 0 {printf "GPU %d°C\n", $1/1000; exit}'
interval=5

[ethernet]
command=echo "$(ip addr show enp5s0 2>/dev/null | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)"
interval=60

[wifi]
command=echo "$(ip addr show wlp3s0 2>/dev/null | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)"
interval=60

[time]
command=date '+%l:%M %p | %A, %B %e %Y  '
interval=10
EOL