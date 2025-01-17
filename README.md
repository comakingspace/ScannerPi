# Pi-Scanner

A Raspberry Pi-based automated document scanning solution that uploads scanned documents directly to Nextcloud. This project provides an Ansible playbook to automatically configure a Raspberry Pi as a network-connected scanner with automatic upload capabilities.

## Features

- Automatic document scanning with SANE
- OCR processing using Tesseract
- Automatic upload to Nextcloud
- Runs as system services for reliability
- Minimal configuration needed after setup

## Prerequisites

- Raspberry Pi (any model) with Raspberry OS installed
- Scanner compatible with SANE (check [SANE supported devices](http://www.sane-project.org/sane-supported-devices.html))
- Nextcloud instance with write access to a specific folder
- Ansible installed on your control machine
- SSH access to the Raspberry Pi

## Quick Start

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/Pi-Scanner.git
   cd Pi-Scanner
   ```

2. Set up SSH key access to your Raspberry Pi:
   ```bash
   ssh-copy-id pi@<your-pi-ip-address>
   ```

3. Run the Ansible playbook:
   ```bash
   ansible-playbook -i <your-pi-ip-address>, -u pi Ansible/playbook_setup_scanner-Pi.yml
   ```

   You will be prompted for:
   - Nextcloud server URL
   - Nextcloud username
   - Nextcloud password
   - New password for the Pi user

## What to Expect After Setup

1. The Raspberry Pi will be configured with the hostname "ScannerPi"
2. Two services will be running:
   - `scand`: Monitors for new documents and handles scanning
   - `uploadd`: Handles uploading scanned documents to Nextcloud

3. Scanned documents will be:
   - Automatically processed for better quality
   - Converted to searchable PDFs (with OCR)
   - Uploaded to your specified Nextcloud folder

## Troubleshooting

1. Check service status:
   ```bash
   sudo systemctl status scand
   sudo systemctl status uploadd
   ```

2. View logs:
   ```bash
   journalctl -u scand
   journalctl -u uploadd
   ```

3. Common issues:
   - If scanning fails, ensure your scanner is properly connected and recognized by SANE
   - If uploads fail, verify your Nextcloud credentials and connectivity
   - Check permissions if files aren't being created or uploaded

## Security Note

The Nextcloud credentials are stored unencrypted on the Raspberry Pi. This is considered acceptable as:
- The credentials only have access to a specific upload directory
- The Raspberry Pi should be physically secured and on a trusted network
- The credentials cannot be used to access other parts of your Nextcloud instance

## Contributing

Feel free to open issues or submit pull requests if you have suggestions for improvements.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details. 