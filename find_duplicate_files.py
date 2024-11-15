#!/usr/bin/env python3


import datetime
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

    parser.add_argument(
        "-e",
        "--extension",
        type=str,
        default="all",
        help="The file extension to search for duplicates (default: jpg).",
    )

    parser.add_argument(
        "-t",
        "--duplicate-threshold",
        type=int,
        default=1,
        help="The threshold for the number of duplicates (default: 1).",
    )

    # parser.add_argument(
    #     "-d", "--delete", action="store_true", help="Delete duplicate files."
    # )

    # Generate file list
    parser.add_argument(
        "-f",
        "--file-list",
        action="store_true",
        help="Generate a list of duplicate files.",
    )

    # Exclude expression in path
    parser.add_argument(
        "-x",
        "--exclude",
        type=str,
        default="",
        help="Exclude files that contain this expression in their path.",
    )

    return parser.parse_args()


args = parse_arguments()
directory_path = args.directory
extension = args.extension
duplicate_threshold = args.duplicate_threshold

# Si l'option -f est utilisée, on crée un fichier texte avec la liste des fichiers en doublons
if args.file_list:
    date = datetime.datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    filename = f"Duplicate_files_{date}.txt"


def hash_file(file_path, block_size=65536):
    """Calcule un hash SHA-1 pour un fichier donné."""
    sha1 = hashlib.sha1()
    try:
        with open(file_path, "rb") as file:
            while chunk := file.read(block_size):
                sha1.update(chunk)
    except IOError as e:
        print(f"Erreur lors de l'ouverture du fichier {file_path}: {e}")
    return sha1.hexdigest()


def find_duplicate_files_by_extention(directory, extension):
    # Dictionnaire pour stocker les fichiers par leur hash
    hash_dict = defaultdict(list)

    ret = os.listdir(directory)
    extension
    # Parcourir le répertoire et ses sous-répertoires
    for root, _, files in os.walk(directory):
        for file in files:
            # Vérifier si le fichier a bien l'extention mise en paramètre si l'option -e est utilisée
            if (file.lower().endswith(f".{extension}")) or (extension == "all"):
                file_path = os.path.join(root, file)

                if args.exclude:
                    if args.exclude in file_path:
                        continue
                # Calculer le hash du fichier
                file_hash = hash_file(file_path)
                # Ajouter le fichier à la liste des fichiers de même hash
                hash_dict[file_hash].append([root, file])

    # Afficher les doublons
    print("Fichiers en doublons trouvés :")
    for paths in hash_dict.values():
        if len(paths) > duplicate_threshold:
            for path in paths:
                root = path[0]
                file = path[1]
                file_path = os.path.join(root, file)

                print(f"{file}: {root}")

                # if args.delete:
                #     print(f"Deleting {root}/{file}")
                #     # os.remove(file_path)

                # Si l'option -f est utilisée, on écrit le nom du fichier en doublon dans le fichier texte
                if args.file_list:
                    file = open(filename, "a")
                    file.write(f"{file_path}\n")
                    file.close()

            print("-" * 50)

    return hash_dict


if __name__ == "__main__":
    find_duplicate_files_by_extention(directory_path, extension)
