#!/bin/bash

DOMAIN_NAME="aws.cts.care."
TAG_NAME="Name"
SUB_DOMAIN_PREFIX="<Your_Sub_Domain>"
ROUTE53_MAIN_DOMAIN_ID=(aws route53 list-hosted-zones | jq -r --arg domain "$DOMAIN_NAME" '.HostedZones[] | select(.Name==$domain) | .Id')
FULL_DOMAIN="${SUB_DOMAIN_PREFIX}.${DOMAIN_NAME}"

# Token creation
TOKEN=$(curl -X PUT -H "X-aws-ec2-metadata-token-ttl-seconds: 3600" http://169.254.169.254/latest/api/token)

# Get metadata using the token
curl http://169.254.169.254/latest/meta-data -H "X-aws-ec2-metadata-token: $TOKEN"

# Get the machines public IP address from EC2
IP_PUBLIC=$(curl http://169.254.169.254/latest/meta-data/public-ipv4 -H "X-aws-ec2-metadata-token: $TOKEN")

# Get the machines public IP address from route53
CURRENT_ROUTE53_IP=$(aws route53 list-resource-record-sets --hosted-zone-id "$ROUTE53_MAIN_DOMAIN_ID" \
  | jq -r --arg name "$FULL_DOMAIN" '.ResourceRecordSets[] | select(.Name==$name) | .ResourceRecords[].Value')

# If the addresses are not the same and the machine has a public IP address, update it in route 53
if [[ "$IP_PUBLIC" != "$CURRENT_ROUTE53_IP" && -n "$IP_PUBLIC" ]]; then
  aws route53 change-resource-record-sets --hosted-zone-id "$ROUTE53_MAIN_DOMAIN_ID" --change-batch "$(
    cat <<EOF
{
  "Changes": [
    {
      "Action": "UPSERT",
      "ResourceRecordSet": {
        "Name": "${FULL_DOMAIN}",
        "Type": "A",
        "TTL": 300,
        "ResourceRecords": [
          {
            "Value": "$IP_PUBLIC"
          }
        ]
      }
    }
  ]
}
EOF
  )"
else
  echo "No update needed."
fi
