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
        discharging)
	        battery_info=$(acpiconf -i $1 | awk '/Remaining capacity/{print $3}')
            ;;
    esac

	echo $battery_info
}

datentime=$(date "+%Y-%m-%d %H:%M:%S")

internal_battery_percentage="IntBAT: $(get_battery_info 0)"
external_battery_percentage="ExtBAT: $(get_battery_info 1)"
battery_info="$internal_battery_percentage - $external_battery_percentage"

echo "$battery_info | $datentime"
