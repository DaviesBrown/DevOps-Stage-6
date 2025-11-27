#!/bin/bash

set -e

cd infra/terraform

echo "Running terraform plan to check for drift..."
terraform plan -detailed-exitcode -out=tfplan 2>&1 | tee plan_output.txt

EXIT_CODE=${PIPESTATUS[0]}

if [ $EXIT_CODE -eq 2 ]; then
    echo "DRIFT_DETECTED=true" >> $GITHUB_ENV
    echo "✋ Infrastructure drift detected!"
    
    # Extract changes summary
    CHANGES=$(grep -A 50 "Terraform will perform" plan_output.txt || echo "Changes detected")
    
    echo "DRIFT_SUMMARY<<EOF" >> $GITHUB_ENV
    echo "$CHANGES" >> $GITHUB_ENV
    echo "EOF" >> $GITHUB_ENV
    
    exit 2
elif [ $EXIT_CODE -eq 0 ]; then
    echo "DRIFT_DETECTED=false" >> $GITHUB_ENV
    echo "✅ No infrastructure drift detected"
    exit 0
else
    echo "❌ Terraform plan failed"
    exit 1
fi
