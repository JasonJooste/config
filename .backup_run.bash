#!/usr/bin/bash
HOME_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
/usr/bin/rclone sync --exclude-from "$HOME_DIR/.backup_exclude" "$HOME_DIR/Documents" backblaze-backup:portable-ubuntu-backup
