#URL discord tepbac
WEBHOOK_URL="https://discord.com/api/webhooks/130181834/TA2xAkV9BJ6MCwexxmm7wFVm"

# ID Tags forums on discord
applied_tags="[\"13028888681\"]"
tag_user="<@811769365696>" ## User discord Vinhtran

# Thread ID of the existing thread
thread_name="Alert Performance Server mycompany.com"

# Alert thresholds
DISK_THRESHOLD=80 # percentage
MEMORY_THRESHOLD=80  # percentage
CPU_THRESHOLD=80  # percentage

#Variable Date
DATE_TIME=$(date +"%T")

# Get hostname and IP address
HOSTNAME=$(hostname)
IP_ADDRESS=$(hostname -I | awk '{print $1}')

# Check disk usage
DISK_USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')

# Check memory usage
MEMORY_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')

# Check CPU usage
CPU_USAGE=$(top -b -n1 | grep "Cpu(s)" | awk '{print $4 + $2}')
#CPU_USAGE=$(sar 1 1 | grep "Average:" | awk '{print 100 - $NF}')
# Create alert message
ALERT_MESSAGE=""

# Check disk usage alert (above threshold)
if [ "$DISK_USAGE" -ge "$DISK_THRESHOLD" ]; then
  ALERT_MESSAGE="${ALERT_MESSAGE}:fire::flame: **Name_company Alerts Firing:** :fire::flame:\n"
  ALERT_MESSAGE="${ALERT_MESSAGE}**IP:** $IP_ADDRESS\n"
  ALERT_MESSAGE="${ALERT_MESSAGE}**Hostname:** $HOSTNAME\n"
  ALERT_MESSAGE="${ALERT_MESSAGE}**Serverity:** High\n"
  ALERT_MESSAGE="${ALERT_MESSAGE}**Alert name:** Disk_Usage\n"
  ALERT_MESSAGE="${ALERT_MESSAGE}**Description:** Disk usage is **$DISK_USAGE%** at $DATE_TIME. Please check immediately! $tag_user\n\n\n"
fi

# Check memory usage alert (above threshold)
MEMORY_USAGE_INT=${MEMORY_USAGE%.*}
if [ "$MEMORY_USAGE_INT" -ge "$MEMORY_THRESHOLD" ]; then
  ALERT_MESSAGE="${ALERT_MESSAGE}:fire::flame: **Name_company Alerts Firing:** :fire::flame:\n"
  ALERT_MESSAGE="${ALERT_MESSAGE}**IP:** $IP_ADDRESS\n"
  ALERT_MESSAGE="${ALERT_MESSAGE}**Hostname:** $HOSTNAME\n"
  ALERT_MESSAGE="${ALERT_MESSAGE}**Serverity:** Warning\n"
  ALERT_MESSAGE="${ALERT_MESSAGE}**Alert name:** Mem_Usage\n"
  ALERT_MESSAGE="${ALERT_MESSAGE}**Description:** Memory usage is **$MEMORY_USAGE%** at $DATE_TIME. Please check immediately! $tag_user>\n\n\n"
fi

# Check CPU usage alert (above threshold)
CPU_USAGE_INT=${CPU_USAGE%.*}
if [ "$CPU_USAGE_INT" -ge "$CPU_THRESHOLD" ]; then
  ALERT_MESSAGE="${ALERT_MESSAGE}:fire::flame: **Name_company Alerts Firing:** :fire::flame:\n"
  ALERT_MESSAGE="${ALERT_MESSAGE}**IP:** $IP_ADDRESS\n"
  ALERT_MESSAGE="${ALERT_MESSAGE}**Hostname:** $HOSTNAME\n"
  ALERT_MESSAGE="${ALERT_MESSAGE}**Serverity:** Warning\n"
  ALERT_MESSAGE="${ALERT_MESSAGE}**Alert name:** CPU_Usage\n"
  ALERT_MESSAGE="${ALERT_MESSAGE}**Description:** CPU usage is **$CPU_USAGE%** at $DATE_TIME. Please check immediately! $tag_user\n\n\n"
fi

# If there are any alerts, send the alert message via Discord Webhook
if [ -n "$ALERT_MESSAGE" ]; then
  curl -H "Content-Type: application/json" -X POST -d "{\"content\": \"$ALERT_MESSAGE\", \"thread_name\" : \"$thread_name\", \"applied_tags\": $applied_tags}" "$WEBHOOK_URL"
else
  echo "No alerts at $DATE_TIME."
fi
