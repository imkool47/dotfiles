#!/usr/bin/env bash

# Find the Ethernet interface (if available)
eth_interface=$(nmcli device status | awk '$2 == "ethernet" {print $1; exit}')

build_wifi_menu() {
    wifi_menu_conn=""
    wifi_menu_saved=""
    wifi_menu_unsaved=""

    nmcli device wifi rescan >/dev/null 2>&1

    saved_connections=$(nmcli -g NAME connection)

    while IFS=: read -r in_use ssid signal security; do
        [ -z "$ssid" ] && continue

        connected=0
        [ "$in_use" = "*" ] && connected=1

        saved=0
        echo "$saved_connections" | grep -Fxq "$ssid" && saved=1

        idx=$((signal / 20))
        [ $idx -gt 4 ] && idx=4

        if [ $connected -eq 1 ]; then
            icons=("󰤯" "󰤟" "󰤢" "󰤥" "󰤨")
        elif [ $saved -eq 1 ]; then
            icons=("󱛏" "󱛋" "󱛌" "󱛍" "󱛎")
        else
            icons=("󰤬" "󰤡" "󰤤" "󰤧" "󰤪")
        fi

        icon=${icons[$idx]}
        line="${icon}  ${ssid}"

        if [ $connected -eq 1 ]; then
            wifi_menu_conn+="    ${line}\n"
        else
            if [ $saved -eq 1 ]; then
                wifi_menu_saved+="  ${line}\n"
            else
                wifi_menu_unsaved+="  ${line}\n"
            fi
        fi
    done < <(nmcli -t -f IN-USE,SSID,SIGNAL,SECURITY device wifi list)

    wifi_menu="${wifi_menu_conn}${wifi_menu_saved}${wifi_menu_unsaved}"
}

while true; do
    [ -n "$eth_interface" ] && eth_state=$(nmcli device status | awk -v iface="$eth_interface" '$1 == iface {print $3}')
    wifi_status=$(nmcli radio wifi)

    build_wifi_menu
    menu_list=""

    # Use visual spacing for display but tags for internal matching
    if [ -n "$eth_interface" ] && [ "$eth_state" != "unavailable" ]; then
        if [ "$eth_state" = "connected" ]; then
            menu_list+="  󰈁  Disable Ethernet [__DISABLE_ETH__]\n"
        else
            menu_list+="  󰈁  Enable Ethernet [__ENABLE_ETH__]\n"
        fi
    fi

    if [ "$wifi_status" = "enabled" ]; then
        menu_list+=" 󰖩  Disable Wi-Fi [__DISABLE_WIFI__]\n"
    else
        menu_list+=" 󰖩  Enable Wi-Fi  [__ENABLE_WIFI__]\n"
    fi

    menu_list+="${wifi_menu}"
    menu_list=$(printf "%b" "$menu_list" | sed '/^[[:space:]]*$/d')

    chosen=$(printf "%b" "$menu_list" | rofi -theme-str 'configuration { show-icons: false; } window { location: north east; x-offset: -269; y-offset: 155; width: 225px; } listview { columns: 1; lines: 5; } inputbar { enabled: false; } mode-switcher { enabled: false; }' -dmenu -i)
    [ -z "$chosen" ] && break

    case "$chosen" in
        *"[__DISABLE_ETH__]"*)
            nmcli device disconnect "$eth_interface"
            break
            ;;
        *"[__ENABLE_ETH__]"*)
            nmcli device connect "$eth_interface"
            break
            ;;
        *"[__DISABLE_WIFI__]"*)
            nmcli radio wifi off
            break
            ;;
        *"[__ENABLE_WIFI__]"*)
            nmcli radio wifi on
            notify-send -e --app-name="Network" "Connection Refreshing" "Listing Networks" -t 5000
            sleep 5
            continue
            ;;
        *)
            # Extract SSID
            if [[ "$chosen" == *""* ]]; then
                ssid=$(echo "$chosen" | awk -F'\t' '{print $3}')
            else
                ssid=$(echo "$chosen" | awk -F'\t' '{print $2}')
            fi
            ssid=$(echo "$ssid" | sed 's/ *\[.*//') # Remove the tag if copied accidentally

            saved_connections=$(nmcli -g NAME connection)

            if echo "$saved_connections" | grep -Fxq "$ssid"; then
                nmcli connection up id "$ssid" && notify-send -e --app-name="Network" "Connection Established" "Connected to \"$ssid\"." && break
                notify-send -e --app-name="Network" "Connectio Failed" "Failed to connect to \"$ssid\"."
                break
            else
                sec=$(nmcli -t -f SSID,SECURITY device wifi list | grep -F "$ssid" | cut -d: -f2 | head -n1)
                if [ "$sec" != "--" ] && [ -n "$sec" ]; then
                    while :; do
                        pass=$(rofi -dmenu -i -markup -eh 2 -replace \
                            -password \
                            -p "Wi-Fi Password" \
                            -mesg "  Enter Password" \
                            -config ~/.config/rofi/waybar-input-menu.rasi \
                            -theme-str 'window { location: north east; x-offset: -260; y-offset: 140; width: 225px; } listview { enabled: false; } mode-switcher { enabled: false; } element { enabled: false; }')
                        [ -z "$pass" ] && break

                        if nmcli device wifi connect "$ssid" password "$pass"; then
                            notify-send -e --app-name="Network" "Connection Established" "Connected to \"$ssid\"."
                            exit 0
                        else
                            notify-send -e --app-name="Network" "Connection Failed" "Incorrect password for \"$ssid\"."
                            nmcli connection delete "$ssid" >/dev/null 2>&1
                        fi
                    done
                else
                    if nmcli device wifi connect "$ssid"; then
                        notify-send -e --app-name="Network" "Connection Established" "Connected to \"$ssid\"."
                        exit 0
                    else
                        notify-send -e --app-name="Network" "Connection Failed" "Failed to connect to \"$ssid\"."
                        nmcli connection delete "$ssid" >/dev/null 2>&1
                        exit 0
                    fi
                fi
            fi
            ;;
    esac
done

exit 0
