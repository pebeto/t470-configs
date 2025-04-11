# Battery information
get_battery_info() {
    percentage=$(cat /sys/class/power_supply/BAT$1/capacity)%
	echo $percentage
}
internal_battery_percentage="IntBAT: $(get_battery_info 0)"
external_battery_percentage="ExtBAT: $(get_battery_info 1)"
battery_info="$internal_battery_percentage ~ $external_battery_percentage"

get_volume_info() {
    actual_volume=$(amixer get Master | grep -o '[0-9]\+%' | head -n 1)
    echo $actual_volume
}
volume_info="Volume: $(get_volume_info)"

get_brightness_info() {
    current_brightness=$(< /sys/class/backlight/intel_backlight/brightness)
    max_brightness=$(< /sys/class/backlight/intel_backlight/max_brightness)
    echo $(( current_brightness * 100 / max_brightness ))%
}
brightness_info="Brightness: $(get_brightness_info)"

datentime=$(date "+%Y-%m-%d %H:%M:%S")

echo "$brightness_info | $volume_info | $battery_info | $datentime"
