#!/bin/bash

_dir="$(dirname "$0")"
source "$_dir/config.sh"

AUTH_ID=$(curl -s -X GET "https://$API_HOST/dnsmgr?out=json&func=auth&username=$API_USERNAME&password=$API_PASSWORD" \
| python -c "import sys,json;print(json.load(sys.stdin)['doc']['auth']['\$id'])")

# Strip only the top domain to get the zone id
DOMAIN=$(expr match "$CERTBOT_DOMAIN" '.*\.\(.*\..*\)')
	
# Create TXT record
CREATE_DOMAIN="_acme-challenge"

OUT=$(curl -s -X GET "https://$API_HOST/dnsmgr?out=json&auth=$AUTH_ID&func=domain.record.edit&name=$CREATE_DOMAIN&plid=$CERTBOT_DOMAIN&rtype=txt&ttl=3600&value=$CERTBOT_VALIDATION&sok=ok")

# Save info for cleanup
# if [ ! -d /tmp/CERTBOT_$CERTBOT_DOMAIN ];then
#         mkdir -m 0700 /tmp/CERTBOT_$CERTBOT_DOMAIN
# fi

# echo $RECORD_ID > /tmp/CERTBOT_$CERTBOT_DOMAIN/RECORD_ID

# Sleep to make sure the change has time to propagate over to DNS
sleep 5
