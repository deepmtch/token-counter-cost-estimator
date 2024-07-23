#!/bin/bash

total_tokens=0

echo "Enter the cost per million tokens in dollars (e.g., 30 for $30):"
read cost_per_million

echo "Individual file token counts:"
echo "-----------------------------"

for file in "$@"
do
    char_count=$(wc -c < "$file")
    tokens=$((char_count / 4))
    total_tokens=$((total_tokens + tokens))
    printf "%-50s %d tokens\n" "$file:" $tokens
done

echo "-----------------------------"
printf "%-50s %d tokens\n" "Total:" $total_tokens

# Calculate cost in cents
cost_cents=$(awk "BEGIN {printf \"%.0f\", $total_tokens * $cost_per_million / 10000}")

echo "-----------------------------"
printf "%-50s %d cents\n" "Total cost:" $cost_cents
