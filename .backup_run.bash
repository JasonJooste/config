#!/usr/bin/bash
HOME_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
/usr/bin/rclone sync --exclude-from "$HOME_DIR/.backup_exclude" "$HOME_DIR/Documents" backblaze-backup:portable-ubuntu-backup
code=$?
if [[ $code == 0 ]]; then
	echo "Backup finished at $(date)"
else
	echo "Backup failed at $(date) with code $code"
fi
