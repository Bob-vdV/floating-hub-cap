import os
import shutil
import subprocess
import json
import re

openscad_path = "openscad"

params_filename = "centercap_params.scad"
json_filename = "centercap_params.json"  # Actual param values stored here

model_filenames = [
    "centercap_base.scad",
    "centercap_swing_screws.scad",
    "centercap_top_plain.scad",
    "centercap_top_vw_flat.scad",
    "centercap_top_vw_curved.scad",
    "hubcap_tester.scad",
    "centercap_assembly.scad"
]

include_filenames = ["fast_dome.scad", "vw.scad", "vw-logo.svg"]

build_folder = "build"
delete_scad = True

# Openscad flags
use_manifold = True
hard_warnings = False

# Build everything
with open(json_filename) as json_file:
    params = json.load(json_file)
parametersets = params["parameterSets"]
buildsets = parametersets.keys()


def main():
    # Remove old build folder
    if os.path.exists(build_folder):
        shutil.rmtree(build_folder)

    # Make new folder for each build set
    os.mkdir(build_folder)
    for buildset in buildsets:
        os.mkdir(os.path.join(build_folder, buildset))

    with open(params_filename, "rt") as params_file:
        original_params = params_file.read()

    # Copy openscad libraries first
    for include_filename in include_filenames:
        shutil.copyfile(include_filename, os.path.join(build_folder, include_filename))

    for model_filename in model_filenames:
        shutil.copyfile(model_filename, os.path.join(build_folder, model_filename))            

    for parameterset in parametersets:
        # Replace all given variables of json in params filename
        build_params = original_params
        for parameter in parametersets[parameterset]:
            pattern_str = r"\s" + parameter + r"\s*=\s*\S*;" 
            if len(re.findall(pattern_str, build_params)) == 0: 
                print(f"WARNING: {parameter} is not replaced for {parameterset}")
            build_params = re.sub(pattern_str , f"\n{parameter} = {parametersets[parameterset][parameter]};", build_params)

        # Write changed params to file
        with open(os.path.join(build_folder, params_filename), "wt") as build_file:
            build_file.write(build_params)
        
        for model_filename in model_filenames:
            output_stl = os.path.join(
                build_folder,
                parameterset,
                model_filename.replace(".scad", "_" + parameterset + ".stl"),
            )
            command = [
                    "openscad",
                    "-o",
                    output_stl,
                    os.path.join(build_folder, model_filename),
                ]
            if use_manifold:
                command += ["--enable", "manifold"]
            if hard_warnings:
                command += ["--hardwarnings"]
            subprocess.run(
                command,
                shell=False,
                check=True,
            )

    # 3. delete openscad files
    if delete_scad:
        print("Deleting openscad files...")
        for file in os.listdir(build_folder):
            if file.endswith(".scad") or file.endswith(".svg"):
                os.remove(os.path.join(build_folder, file))

    print("\nDone")


if __name__ == "__main__":
    main()
