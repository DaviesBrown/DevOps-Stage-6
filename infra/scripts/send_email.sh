SMTP_HOST="${SMTP_HOST:-smtp.gmail.com}"
SMTP_PORT="${SMTP_PORT:-587}"
SMTP_USER="${SMTP_USER}"
SMTP_PASSWORD="${SMTP_PASSWORD}"
TO_EMAIL="${ALERT_EMAIL}"
SUBJECT="$1"
BODY="$2"

if [ -z "$SMTP_USER" ] || [ -z "$SMTP_PASSWORD" ] || [ -z "$TO_EMAIL" ]; then
    echo "Error: Email credentials not configured"
    exit 1
fi

# Create email message
EMAIL_MESSAGE="From: ${SMTP_USER}
To: ${TO_EMAIL}
Subject: ${SUBJECT}

${BODY}
"

# Send email using curl
echo "$EMAIL_MESSAGE" | curl -v --ssl-reqd \
    --url "smtps://${SMTP_HOST}:${SMTP_PORT}" \
    --user "${SMTP_USER}:${SMTP_PASSWORD}" \
    --mail-from "${SMTP_USER}" \
    --mail-rcpt "${TO_EMAIL}" \
    --upload-file -

if [ $? -eq 0 ]; then
    echo "✅ Email sent successfully to ${TO_EMAIL}"
else
    echo "❌ Failed to send email"
    exit 1
fi
