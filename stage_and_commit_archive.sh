#!/bin/bash

# Make a file to ensure the post-commit hook runs only once
touch NO_POST_COMMIT

ARCHIVE_DIR=".archive"

# Stage all changes in the .archive directory
git add "$ARCHIVE_DIR"

# Check if there are any changes to commit
if git diff --cached --quiet; then
    echo "No .archive changes to commit. If you commited any OpenRocket files, something probably broke."
    exit 0
fi

# Commit the staged changes
git commit --no-verify -m "Unzipped .ork files into $ARCHIVE_DIR"
echo "Successfully committed unzipped .ork files."

# Delete the blocker file
rm NO_POST_COMMIT

exit 0
