#!/bin/bash
# Pull clipboard content saved by the vercel_clipboard_manager web app from Dropbox
# and copy it to the local clipboard.
/opt/homebrew/bin/rclone copy "dropbox:/blob_vercel_replacement/blob_clipboard_content.txt" /tmp/
/usr/bin/pbcopy < /tmp/blob_clipboard_content.txt
echo "✓ Clipboard loaded from Dropbox"
