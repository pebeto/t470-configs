# Battery information
get_battery_info() {
    state=$(acpiconf -i $1 | awk '/State/{print $2}')
    case $state in
        charging)
            battery_info="charging"
            ;;
        not)
            battery_info="NA"
            ;;
        discharging|high|critical)
	        battery_info=$(acpiconf -i $1 | awk '/Remaining capacity/{print $3}')
            ;;
    esac
	echo $battery_info
}
internal_battery_percentage="IntBAT: $(get_battery_info 0)"
external_battery_percentage="ExtBAT: $(get_battery_info 1)"
battery_info="$internal_battery_percentage - $external_battery_percentage"

get_volume_info() {
    actual_volume=$(mixer vol.volume | awk -F: '{print $2}')
    echo $actual_volume
}
volume_info="Volume: $(get_volume_info)"

get_brightness_info() {
    actual_brightness=$(backlight -f /dev/backlight/intel_backlight0 -q)
    echo $actual_brightness
}
brightness_info="Brightness: $(get_brightness_info)"

datentime=$(date "+%Y-%m-%d %H:%M:%S")

echo "$brightness_info | $volume_info | $battery_info | $datentime"
