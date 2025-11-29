#!/bin/bash
set -e

echo "🔧 Starting drift detection..."
echo "Current directory: $(pwd)"
echo "Contents:"
ls -la

# Change to terraform directory
cd infra/terraform || { echo "❌ Failed to cd to infra/terraform"; exit 1; }

echo "✅ Changed to terraform directory: $(pwd)"
echo "Terraform files:"
ls -la

echo "🚀 Running terraform plan to check for drift..."
# Run terraform plan and capture exit code properly
terraform plan -detailed-exitcode -out=tfplan 2>&1 | tee plan_output.txt
PLAN_EXIT_CODE=${PIPESTATUS[0]}

echo "📊 Terraform plan exit code: $PLAN_EXIT_CODE"

# Handle the exit codes from terraform plan
case $PLAN_EXIT_CODE in
    0)
        echo "✅ No infrastructure drift detected"
        echo "No changes. Infrastructure is up-to-date."
        exit 0
        ;;
    1)
        echo "❌ Terraform plan failed with errors"
        echo "Error occurred during terraform plan"
        exit 1
        ;;
    2)
        echo "✋ Infrastructure drift detected!"
        echo "Changes are required to reach the desired state."
        
        # Extract meaningful summary of changes
        CHANGES=$(grep -A 20 -B 5 "Terraform will perform" plan_output.txt || \
                 grep -A 10 "Plan:" plan_output.txt || \
                 echo "Changes detected - see full plan_output.txt for details")
        
        echo "=== DRIFT SUMMARY ==="
        echo "$CHANGES"
        echo "====================="
        
        # Write to the dummy GITHUB_ENV file (for remote debugging)
        if [ -n "$GITHUB_ENV" ]; then
            echo "DRIFT_DETECTED=true" >> "$GITHUB_ENV"
            echo "DRIFT_SUMMARY<<EOF" >> "$GITHUB_ENV"
            echo "$CHANGES" >> "$GITHUB_ENV"
            echo "EOF" >> "$GITHUB_ENV"
        fi
        
        exit 2
        ;;
    *)
        echo "❓ Unexpected exit code: $PLAN_EXIT_CODE"
        exit 1
        ;;
esac
