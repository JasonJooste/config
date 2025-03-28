#!/usr/bin/env python3
import os
import shutil
import subprocess
from datetime import datetime
import argparse
from pathlib import Path

def get_exif_dates(directory, extensions):
    """Extracts 'Date Taken' (DateTimeOriginal) and filenames using a single exiftool call."""
    cmd = ["exiftool", "-T", "-DateTimeOriginal", "-filename", "-d", "%Y:%m:%d %H:%M:%S"]
    for ext in extensions:
        cmd.extend(["-ext", ext])
    cmd.append(directory)
    try:
        result = subprocess.run(cmd, capture_output=True, text=True, check=True)
    except Exception as e:
        print(f"Error extracting EXIF data: {e}")
        return {}
    exif_data = result.stdout.strip().split("\n")
    file_dates = {}
    for line in exif_data:
        date_str, filename = line.split("\t")
        try:
            file_dates[filename] = datetime.strptime(date_str, "%Y:%m:%d %H:%M:%S")
        except ValueError:
            pass  # Ignore files with missing or bad EXIF data
    return file_dates

def copy_new_photos(source_dir, dest_dir, filetype, extensions=["jpg", "jpeg", "arw"]):
    """Copies only photos with a 'Date Taken' later than the latest in the destination folder."""
    if not os.path.exists(dest_dir):
        os.makedirs(dest_dir)
    # Get EXIF dates for all destination files
    dest_dates = get_exif_dates(dest_dir, extensions)
    latest_time = max(dest_dates.values(), default=datetime.min)
    if latest_time != datetime.min:
        print("Latest photo in destination taken on:", latest_time)
    else:
        print("No photos found in destination. All matching photos will be copied.")
    # Get EXIF dates for all source files
    source_dates = get_exif_dates(source_dir, extensions)
    copied = 0
    for file, date_taken in source_dates.items():
        if Path(file).suffix != "." + filetype:
            continue
        if date_taken > latest_time:
            shutil.copy2(os.path.join(source_dir, file), dest_dir)
            copied += 1
            print("Copied:", os.path.basename(file))

    print(f"Total files copied: {copied}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Copy new photos from source to destination based on EXIF Date Taken.")
    parser.add_argument("source", help="Source directory containing photos")
    parser.add_argument("destination", help="Destination directory to copy photos to")
    parser.add_argument("--filetype", default="ARW", help="The extension of the files you want to transfer")
    args = parser.parse_args()

    copy_new_photos(args.source, args.destination, args.filetype)

