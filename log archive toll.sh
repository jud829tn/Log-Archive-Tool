
For this task, I will create a Linux shell script that can be run from the CLI to archive logs with date and time in the archive filename. The script will:
- Take the log file or log directory as input.
- Compress the log file or all logs in the directory into a tar.gz archive.
- Name the archive with the current date and time for uniqueness.
- Support a usage message for the user if no input is provided or help is requested.

Plan:
Create a single shell script file named `log-archive.sh` that accomplishes this task. The script will:
- Check for input argument (log file/dir).
- Create an archive in the current directory named logs-YYYYMMDD-HHMMSS.tar.gz
- Use tar command with gzip compression.
- Show usage instructions if the input is missing or invalid.

No dependent files needed.

After creation, user can run it like:
`./log-archive.sh /var/log/syslog`
or
`./log-archive.sh /var/log`

This will create an archive in the current directory with date and time in the filename.

Now I will create the shell script with these specifications.


`log-archive.sh`
```sh
#!/bin/bash

# Log Archive Tool
# Usage: ./log-archive.sh <log_file_or_directory>
# Archives the given log file or directory into a tar.gz archive with current date and time.

usage() {
  echo "Usage: $0 <log_file_or_directory>"
  echo "Archives the specified log file or directory with date-time stamped filename."
  exit 1
}

if [ $# -ne 1 ]; then
  usage
fi

TARGET=$1

if [ ! -e "$TARGET" ]; then
  echo "Error: Target file or directory does not exist: $TARGET"
  exit 1
fi

# Get current date-time stamp
DATE_TIME=$(date +"%Y%m%d-%H%M%S")

# Get base name of the target for archive naming (remove trailing slash if any)
BASE_NAME=$(basename "$TARGET" | sed 's:/*$::')

ARCHIVE_NAME="${BASE_NAME}-logs-${DATE_TIME}.tar.gz"

# Create the archive
tar -czf "$ARCHIVE_NAME" -C "$(dirname "$TARGET")" "$BASE_NAME"

if [ $? -eq 0 ]; then
  echo "Archive created: $ARCHIVE_NAME"
else
  echo "Error: Failed to create archive"
  exit 1
fi

```