# Stegosaurus Messenger

**Description**:  
Stegosaurus Messenger is a bash-based tool that allows users to securely send encrypted messages hidden inside images using steganography. After the message is accessed, both the message and the image self-destruct, ensuring one-time access and privacy. The project consists of two scripts: one for sending (encrypting and embedding) and one for receiving (extracting and decrypting). This tool is ideal for those who want to share sensitive information in a secure and single-use manner.

**Features**:  
- **Public-Key Encryption**: Messages are encrypted using the recipient’s public key, ensuring only the intended recipient can read the message.  
- **Steganography**: The encrypted message is hidden inside an image file, providing an additional layer of secrecy.  
- **Self-Destruct**: Once the message is accessed, both the message and the image self-destruct, making the message accessible only once.  
- **Single-Use Access**: Ensures the message can only be accessed once by the intended recipient.

**Requirements**:  
Before running the scripts, ensure you have the following tools installed:  
- **OpenSSL** (for encryption):  
  ```bash  
  sudo apt-get install openssl
- **Steghide** (for image Steganography)
  ```bash
   sudo apt-get install steghide


**Usage**:
1. **Sender Script** (for encrypting and embedding the message):  
   The sender script encrypts a secret message and embeds it into an image file.
   
   **Before Running**:  
   Replace the following variables in the script:  
   - `recipient_public_key="/path/to/recipient_public_key.pem"`: Path to the recipient’s public key.  
   - `image_file="/path/to/your/image.jpg"`: Path to the image file you wish to use for embedding the message.  
   
   **Run the script**:  
   ```bash
   sudo ./StegosaurusMessengerSender.sh

  2. **Receiver Script** (for extracting and decrypting the message):  
    The receiver script extracts the hidden message from the image and decrypts it using their private key.

     **Before Running**:  
     Replace the following variable:  
      - `private_key="/path/to/recipient_private_key.pem"`: Path to the recipient’s private key.

     **Run the script in the directory with the received image**:
      ```bash
      - sudo ./StegosaurusMessengerRecipient.sh

  **Output**:  
   The script will create a `stego_image.jpg` file that can be securely sent to the recipient.

  **Example Workflow**:  
   - **Sender**: Encrypts a secret message, embeds it into an image. The sender will then manually send the `stego_image.jpg` file to the recipient, via email or any other method.  
   - **Recipient**: Extracts and decrypts the message from the image. Once accessed, the files self-destruct, making the message inaccessible afterward.

  **Security Considerations**:  
   - Ensure that your private key is securely stored and never shared.  
   - The self-destruct mechanism provides extra security by ensuring the message can only be accessed once, with all files being destroyed after viewing.


