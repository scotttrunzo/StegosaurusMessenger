#!/bin/bash

# Path to the recipient's private key (replace this with the correct path)
private_key="/path/to/recipient_private_key.pem"  # User must replace with actual recipient's private key path

# Image file received from the sender
stego_image_file="stego_image.jpg"

# Placeholder to track access
access_flag="access_flag"

# --- Step 1: Extraction and Self-Destruction ---
echo "Waiting for the recipient to access the message..."

# Check if the message has already been accessed
if [ -f "$access_flag" ]; then
    echo "Error: Message has already been accessed! Deleting the image..."
    rm -f "$stego_image_file"
    exit 1
else
    # Extract the message for the first time
    steghide extract -sf "$stego_image_file" -xf extracted_message.txt

    if [ $? -ne 0 ]; then
        echo "Error: Failed to extract the message."
        exit 1
    fi

    # Set access flag to prevent future access
    touch "$access_flag"

    # Decrypt the message
    openssl pkeyutl -decrypt -inkey "$private_key" -in extracted_message.txt -out decrypted_message.txt

    if [ $? -eq 0 ]; then
        echo "Message extracted and decrypted successfully."
        echo "The message is: "
        cat decrypted_message.txt

        # Immediately delete the decrypted message and other sensitive files
        rm -f decrypted_message.txt extracted_message.txt access_flag
    fi

    # --- Step 2: Unique Self-Destruction Mechanism ---
    echo "Message has been accessed. Self-destructing the image and the encrypted message."

    # Multi-pass overwrite for added security
    for i in {1..3}; do
        dd if=/dev/urandom of="$stego_image_file" bs=1M count=5
    done

    # Final deletion of the image and the encrypted message file
    rm -f "$stego_image_file"
    echo "Self-destruction complete."
fi
