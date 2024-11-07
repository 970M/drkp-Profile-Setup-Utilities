#!/usr/bin/env python3


import os
import hashlib
from collections import defaultdict
import glob
import argparse


def parse_arguments():
    parser = argparse.ArgumentParser(
        description="Find duplicate JPG files in a directory."
    )
    parser.add_argument(
        "directory", type=str, help="The directory to search for duplicate JPG files."
    )

    # parser.add_argument(
    #     "-e",
    #     "--extension",
    #     type=str,
    #     default="jpg",
    #     help="The file extension to search for duplicates (default: jpg).",
    # )

    # parser.add_argument(
    #     "-d",
    #     "--duplicate-threshold",
    #     type=int,
    #     default=1,
    #     help="The threshold for the number of duplicates (default: 1).",
    # )

    return parser.parse_args()


args = parse_arguments()
directory_path = args.directory


def find_paths_to_process(directory):

    ret = os.listdir(directory)

    # Parcourir le répertoire et ses sous-répertoires
    # for root, dirs, files in os.walk(directory):
    #     for file in files:

    for root, dirs, files in os.walk(directory):
        for directory in dirs:

            # if "--" in directory:

            #     name = directory.split("--")[0]
            #     date = directory.split("--")[1]

            #     new_directory = f"{date} -- {name}"
            #     print(f"Rename directory '{directory}' to '{new_directory}'")
            #     os.rename(
            #         os.path.join(root, directory), os.path.join(root, new_directory)
            #     )

            if " " in directory:
                parts = directory.split(" ", 1)
                if all(
                    c.isdigit() or c == "-" for c in parts[0]
                ):  # Check if the first part contains only digits or '-'
                    new_directory = directory.replace(" ", " -- ", 1)

                    # print(f"Rename directory '{directory}' to '{new_directory}'")
                    print(f"Renamed directory '{new_directory}'")
                    os.rename(
                        os.path.join(root, directory), os.path.join(root, new_directory)
                    )


if __name__ == "__main__":
    find_paths_to_process(directory_path)
