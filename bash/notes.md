what did I have to look up to convert trade() to memorize()?

```bash
getlines() {
    if [ $# -ne 2 ]; then
        echo "Usage: getlines <start_line> <end_line>"
        return 1
    fi

    if ! [[ "$1" =~ ^[0-9]+$ ]] || ! [[ "$2" =~ ^[0-9]+$ ]]; then
        echo "Error: Arguments must be numbers"
        return 1
    fi

}


head -n $1 test.txt

sed -n "$1,$2p" test.txt


if [[ $# -eq 0 ]]; then

elif [ $# -eq 1 ]; then

else 
	
fi

```

I had to look up how to extract lines from a file. 
