#!/bin/bash

# Path to the recipient's public key (replace this with the correct path)
recipient_public_key="/path/to/recipient_public_key.pem"  # User must replace with actual recipient's public key path

# File where the secret message is stored
message_file="secret_message.txt"

# Output file for the encrypted message
encrypted_message_file="encrypted_message.txt"

# Placeholder for the image file where the message will be hidden
image_file="/path/to/your/image.jpg"  # User must replace with the image path
stego_image_file="stego_image.jpg"

# --- Step 1: Input the secret message ---
echo "Please type your secret message:"
read secret_message

# Save the secret message to a file
echo "$secret_message" > "$message_file"

# --- Step 2: Encrypt the secret message using the recipient's public key ---
echo "Encrypting the secret message..."
openssl pkeyutl -encrypt -pubin -inkey "$recipient_public_key" -in "$message_file" -out "$encrypted_message_file"

if [ $? -ne 0 ]; then
    echo "Error: Encryption failed!"
    exit 1
fi
echo "Message successfully encrypted."

# --- Step 3: Embed the encrypted message in an image (Steganography) ---
echo "Embedding encrypted message in the image..."
steghide embed -cf "$image_file" -ef "$encrypted_message_file" -sf "$stego_image_file"

if [ $? -ne 0 ]; then
    echo "Error: Failed to embed the encrypted message in the image."
    exit 1
fi
echo "Message successfully embedded into the image."

# --- Step 4: Clean up sensitive files ---
echo "Deleting sensitive files..."
rm -f "$message_file" "$encrypted_message_file"
echo "Sensitive files deleted."

echo "Send the image $stego_image_file to the recipient."
