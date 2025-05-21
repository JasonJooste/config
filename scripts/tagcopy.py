#! /home/jason/scripts/tagcopy_venv/bin/python3
import os
import shutil
import argparse
from libxmp import XMPFiles, consts


def has_keyword(filepath: str, keyword: str) -> bool:
    """
    Use libxmp to check if the image at filepath contains the specified XMP dc:subject keyword.
    """
    try:
        xmpfile = XMPFiles(file_path=filepath, open_forupdate=False)
        xmp = xmpfile.get_xmp()
        if xmp and xmp.does_property_exist(consts.XMP_NS_DC, 'subject'):
            count = xmp.count_array_items(consts.XMP_NS_DC, 'subject')
            subjects = [xmp.get_array_item(consts.XMP_NS_DC, 'subject', i + 1) for i in range(count)]
            return keyword in subjects
    except Exception as e:
        print(f"Warning: failed to read XMP from {filepath}: {e}")
    finally:
        try:
            xmpfile.close_file()
        except Exception:
            pass
    return False


def copy_images_with_keywords(src_dir: str, dst_dir: str, extensions: list, keywords: list) -> None:
    """
    Copy images with any of the given extensions from src_dir to dst_dir
    only if they contain at least one of the specified keywords.

    Args:
        src_dir: Source directory to search for images.
        dst_dir: Destination directory for copied images.
        extensions: List of file extensions to filter (e.g. ['.jpg', '.jpeg']).
        keywords: List of keywords to check (e.g. ['vacation', 'family']).
    """
    os.makedirs(dst_dir, exist_ok=True)

    for root, _, files in os.walk(src_dir):
        for file in files:
            if any(file.lower().endswith(ext.lower()) for ext in extensions):
                src_path = os.path.join(root, file)
                if any(has_keyword(src_path, kw) for kw in keywords):
                    dst_path = os.path.join(dst_dir, file)
                    shutil.copy2(src_path, dst_path)
                    print(f"Copied: {src_path} -> {dst_path}")


def main():
    parser = argparse.ArgumentParser(
        description="Copy photos by extensions and XMP dc:subject keyword tags from one directory to another."
    )
    parser.add_argument("src_dir", help="Source directory path")
    parser.add_argument("dst_dir", help="Destination directory path")
    parser.add_argument(
        "--ext", dest="extensions", action="append",
        default=[".jpg", ".jpeg"],
        help=(
            "File extension to include (default: .jpg, .jpeg). Can be used multiple times, e.g."
            " --ext .png --ext .tiff"
        )
    )
    parser.add_argument(
        "--keyword", dest="keywords", action="append", required=True,
        help=(
            "Keyword to filter by (matches dc:subject). Can be used multiple times, e.g."
            " --keyword vacation --keyword family"
        )
    )
    args = parser.parse_args()

    copy_images_with_keywords(
        args.src_dir, args.dst_dir, args.extensions, args.keywords
    )


if __name__ == "__main__":
    main()
