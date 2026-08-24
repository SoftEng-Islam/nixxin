#!/usr/bin/env bash

# Target to ping. You can change this to your gateway IP if you want to test local connection only.
TARGET="8.8.8.8"

echo "📡 Starting Antenna Alignment Helper..."
echo "Pinging $TARGET continuously."
echo "Move your antenna slowly and watch the latency (lower is better)."
echo "Press Ctrl+C to stop."
echo "---------------------------------------------------------"

while true; do
    # Run ping for 1 packet, wait up to 1 second
    result=$(ping -c 1 -W 1 $TARGET 2>&1)
    
    if [[ $result == *"100% packet loss"* ]] || [[ $result == *"Network is unreachable"* ]] || [[ $result == *"Destination Host Unreachable"* ]] || [[ $result == *"100.0% packet loss"* ]]; then
        # Red color for dropped packet
        echo -e "\e[31m[❌] Request timed out or host unreachable. (Packet Lost)\e[0m"
    else
        # Extract time (works with most standard linux ping utilities)
        time_ms=$(echo "$result" | grep -oP 'time=\K[\d.]+')
        
        if [ -z "$time_ms" ]; then
             echo -e "\e[31m[❌] Error parsing ping output or packet lost.\e[0m"
        else
            # Color code based on latency
            int_time=${time_ms%.*}
            # Fallback if conversion fails
            if ! [[ "$int_time" =~ ^[0-9]+$ ]]; then int_time=999; fi
            
            if [ "$int_time" -lt 60 ]; then
                color="\e[32m" # Green (Good)
            elif [ "$int_time" -lt 200 ]; then
                color="\e[33m" # Yellow (Okay)
            else
                color="\e[31m" # Red (Poor)
            fi
            
            # Print a visual bar proportional to latency
            bar=""
            bars=$((int_time / 10))
            if [ $bars -gt 40 ]; then bars=40; fi
            for ((i=0; i<bars; i++)); do bar="${bar}█"; done

            # Dynamic spacing
            printf "${color}[✅] Latency: %-7s ms | %s\e[0m\n" "${time_ms}" "${bar}"
        fi
    fi
    sleep 0.5
done
