#!/bin/bash

# Check for valid argument
if [[ "$1" != "major" && "$1" != "minor" && "$1" != "patch" ]]; then
    echo "Usage: $0 <major|minor|patch>"
    exit 1
fi

# Path to the Chart.yaml file, relative to the Jenkins workspace
CHART_PATH="$2"


# Get current version from Chart.yaml
CURRENT_VERSION=$(awk '/name: myproject/{getline; print $2}' "$CHART_PATH")
echo "Current Version: $CURRENT_VERSION" # Debugging line

# Split into array
IFS='.' read -ra ADDR <<< "$CURRENT_VERSION"

# Bump version based on argument
case $1 in
    major)
        MAJOR_VERSION=$(( ${ADDR[0]} + 1 ))
        NEW_VERSION="$MAJOR_VERSION.0.0"
        ;;
    minor)
        MINOR_VERSION=$(( ${ADDR[1]} + 1 ))
        NEW_VERSION="${ADDR[0]}.$MINOR_VERSION.0"
        ;;
    patch)
        PATCH_VERSION=$(( ${ADDR[2]} + 1 ))
        NEW_VERSION="${ADDR[0]}.${ADDR[1]}.$PATCH_VERSION"
        ;;
esac

# Replace in Chart.yaml
sed -i "/name: myproject/{n; s/version: $CURRENT_VERSION/version: $NEW_VERSION/;}" "$CHART_PATH"

echo "Version bumped to $NEW_VERSION"