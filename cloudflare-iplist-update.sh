#!/bin/bash

# Output file
OUTPUT_FILE="cloudflare_ips.conf"

# URLs for Cloudflare IP lists
IPV4_URL="https://www.cloudflare.com/ips-v4"
IPV6_URL="https://www.cloudflare.com/ips-v6"

# Fetch the IP lists
IPV4_LIST=$(curl -s $IPV4_URL)
IPV6_LIST=$(curl -s $IPV6_URL)

# Get current date and time
CURRENT_DATETIME=$(date +"%Y-%m-%d %H:%M:%S")

# Generate the configuration file
{
  # Metadata for humans reading the file
  echo "# https://www.cloudflare.com/en-gb/ips/"
  echo "# This is a list of Cloudflare IPv4 and IPv6 addresses"
  echo "# Last updated: $CURRENT_DATETIME"

  # List ipv4
  for ip in $IPV4_LIST; do
    echo "set_real_ip_from $ip;"
  done

  # List ipv6
  for ip in $IPV6_LIST; do
    echo "set_real_ip_from $ip;"
  done

  # Swap header values
  echo ""
  echo "real_ip_header CF-Connecting-IP;"
} > $OUTPUT_FILE

echo "Cloudflare IP list has been saved to $OUTPUT_FILE"
