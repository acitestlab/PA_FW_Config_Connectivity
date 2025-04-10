
# Palo Alto HA Firewall Terraform Configuration

This project provides a Terraform configuration for setting up a Palo Alto High Availability (HA) firewall. It includes all necessary files to define, configure, and deploy the firewall resources using Terraform.

## Project Structure

```
paloalto-ha-firewall
├── terraform
│   ├── main.tf            # Main Terraform configuration file
│   ├── variables.tf       # Input variables for Terraform
│   ├── outputs.tf         # Output values from Terraform
│   └── terraform.tfvars    # Variable values for Terraform
├── scripts
│   ├── run_terraform.py    # Python script to run Terraform commands
│   └── config
│       └── variables.json  # JSON file containing variable values
├── requirements.txt        # Python dependencies for the project
└── README.md               # Project documentation
```

## Setup Instructions

1. **Install Terraform**: Ensure that Terraform is installed on your machine. You can download it from the [Terraform website](https://www.terraform.io/downloads.html).

2. **Install Python and Dependencies**:
   - Make sure you have Python installed. You can download it from the [Python website](https://www.python.org/downloads/).
   - Install the required Python libraries by running:
     ```
     pip install -r requirements.txt
     ```

3. **Configure Variables**:
   - Edit the `scripts/config/variables.json` file to set the necessary variables for your Palo Alto HA firewall configuration.

4. **Run the Terraform Script**:
   - Execute the Python script to apply the Terraform configuration:
     ```
     python scripts/run_terraform.py
     ```

## Usage

This project is designed to automate the deployment of a Palo Alto HA firewall using Terraform. By modifying the variable values in the JSON file, you can customize the deployment to fit your specific requirements.

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue for any enhancements or bug fixes.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.