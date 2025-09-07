#!/bin/bash

# Function to fix GitHub Actions syntax in a file
fix_file() {
    local file="$1"
    echo "Fixing $file..."
    
    # Use sed to replace all ${{{ patterns
    # This handles the common patterns we've seen
    sed -i.bak 's/\${{ *\([^}]*\) *}}/{{{\githubVarsOpen}}} \1 {{{\githubVarsClose}}}/g' "$file"
    
    # Clean up backup file
    rm -f "${file}.bak"
    
    echo "✅ Fixed $file"
}

# Fix all workflow files
for file in template/.github/workflows/*.yml.mustache; do
    if [[ -f "$file" && "$file" != *"Appinfra-010-init"* ]]; then
        fix_file "$file"
    fi
done

echo "🎉 All workflow files fixed!"
