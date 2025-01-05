
function trade() {
    # Path to the file where details are saved
    save_file="/Users/yourusername/Documents/a_files_for_trade.txt"

    # If an argument (filename) is provided, save the file and path
    if [[ $# -gt 0 ]]; then
        current_path=$(pwd)
        # Save the full file path to the save file
        echo "${current_path}/$1" >> "$save_file"
        echo "File '$1' from '$current_path' saved. Run 'trade' in the destination directory to move it here."
    else
        # Check if the save file exists and is not empty
        if [[ -f "$save_file" && -s "$save_file" ]]; then
            # Read each line from the save file
            while IFS= read -r file_path || [[ -n "$file_path" ]]; do
                # Skip empty lines
                if [[ -z "$file_path" ]]; then
                    continue
                fi

                if [[ -f "$file_path" ]]; then
                    filename=$(basename "$file_path")
                    # Move the file to the current directory
                    mv "$file_path" .
                    echo "Moved '$filename' to $(pwd)."
                else
                    echo "Error: File '$file_path' not found."
                fi
            done < "$save_file"

            # All files processed, print a completion message
            echo "All files have been moved successfully."

            # Safely clear the save file
            : > "$save_file"
            echo "The save file has been cleared."

            # List the files in the current directory
            echo "Current directory contents:"
            ls -lh
        else
            echo "No files marked for transfer. Use 'trade <filename>' to specify files."
        fi
    fi

    # Exit cleanly
    return 0
}

#usage: trade file_name.txt
#then navigate to folder that you want to trade in and write trade to move that file to this directory



function memorize() {
    # Path to the file where details are saved
    save_file="/Users/yourusername/desktop/admin_code/bash_filePaths/a_saved_file_for_memorize.txt"
    
    if [[ $# -eq 0 ]]; then
        # Check if save file exists and is not empty
        if [[ -f "$save_file" && -s "$save_file" ]]; then
            file_to_read=$(head -n 1 "$save_file")
            if [[ -f "$file_to_read" ]]; then
                cat "$file_to_read"
            else
                echo "Error: File '$file_to_read' not found."
            fi
        else
            echo "No files have been saved yet. Use 'new <filename>' to save a file."
        fi
    elif [[ $# -eq 1 ]]; then
        # Check if $1 is a number using regex
        if [[ ! $1 =~ ^[0-9]+$ ]]; then
            current_path=$(pwd)
            # Save the full file path to the save file
            echo "${current_path}/$1" > "$save_file"
            echo "File '$1' from '$current_path' saved."
        else 
            # Check if save file exists and is not empty
            if [[ -f "$save_file" && -s "$save_file" ]]; then
                file_to_read=$(head -n 1 "$save_file")
                if [[ -f "$file_to_read" ]]; then
                    head -n "$1" "$file_to_read"
                else
                    echo "Error: File '$file_to_read' not found."
                fi
            else
                echo "No files have been saved yet. Use 'new <filename>' to save a file."
            fi
        fi
    elif [[ $# -eq 2 ]]; then
        # Check if both arguments are numbers
        if [[ $1 =~ ^[0-9]+$ && $2 =~ ^[0-9]+$ ]]; then
            if [[ -f "$save_file" && -s "$save_file" ]]; then
                file_to_read=$(head -n 1 "$save_file")
                if [[ -f "$file_to_read" ]]; then
                    sed -n "${1},${2}p" "$file_to_read"
                else
                    echo "Error: File '$file_to_read' not found."
                fi
            else
                echo "No files have been saved yet. Use 'new <filename>' to save a file."
            fi
        else
            echo "Error: Both arguments must be numbers when using range."
        fi
    else
        echo "Usage: new [filename] or new [number_of_lines] or new [start_line] [end_line]"
    fi
}

#usage: memorize will read the file that is saved (like from trade)
# memorize 3 will only read 3 lines from that file the first three lines
# memorize 1 5 will read from lines 1 to 5
# memorize 5 7 will read from lines 5 to 7


#update:



function memorize() {
    # Path to the file where details are saved
    save_file="/Users/yourusername/desktop/admin_code/bash_filePaths/a_saved_file_for_memorize.txt"
    
    # Function to check if save file exists and has content
    check_save_file() {
        if [[ ! -f "$save_file" || ! -s "$save_file" ]]; then
            echo "No files have been saved yet. Use 'memorize <filename>' to save a file."
            return 1
        fi
        return 0
    }

    # Function to get and validate the saved file path
    get_saved_file() {
        local file_path=$(head -n 1 "$save_file")
        if [[ ! -f "$file_path" ]]; then
            echo "Error: File '$file_path' not found."
            return 1
        fi
        echo "$file_path"
        return 0
    }

    # Case 1: No arguments - display entire file
    if [[ $# -eq 0 ]]; then
        check_save_file || return 1
        local file_to_read=$(get_saved_file) || return 1
        echo "File: $file_to_read"
        cat "$file_to_read"
        return 0
    fi

    # Case 2: One argument
    if [[ $# -eq 1 ]]; then
        # If argument is not a number, treat it as a filename to save
        if [[ ! $1 =~ ^[0-9]+$ ]]; then
            current_path=$(pwd)
            echo "${current_path}/$1" > "$save_file"
            echo "File '$1' from '$current_path' saved."
            return 0
        fi

        # If argument is a number, display that many lines from saved file
        check_save_file || return 1
        local file_to_read=$(get_saved_file) || return 1
        echo "File: $file_to_read"
        head -n "$1" "$file_to_read"
        return 0
    fi

    # Case 3: Two arguments - must both be numbers for line range
    if [[ $# -eq 2 ]]; then
        if [[ ! $1 =~ ^[0-9]+$ || ! $2 =~ ^[0-9]+$ ]]; then
            echo "Error: Both arguments must be numbers when using range."
            return 1
        fi

        check_save_file || return 1
        local file_to_read=$(get_saved_file) || return 1
        echo "File: $file_to_read"
        sed -n "${1},${2}p" "$file_to_read"
        return 0
    fi

    echo "Usage: memorize [filename] or memorize [number_of_lines] or memorize [start_line] [end_line]"
    return 1
}








