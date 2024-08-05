import os
import shutil
import subprocess
import json

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
]

include_filenames = ["fast_dome.scad", "vw.scad", "vw-logo.svg"]

build_folder = "build"
delete_scad = True

# Build everything
with open(json_filename) as json_file:
    params = json.load(json_file)
buildsets = params["parameterSets"].keys()


def main():
    # Remove old build folder
    if os.path.exists(build_folder):
        shutil.rmtree(build_folder)

    # Make new folder for each build set
    os.mkdir(build_folder)
    for buildset in buildsets:
        os.mkdir(os.path.join(build_folder, buildset))

    # Copy openscad libraries first
    for include_filename in include_filenames:
        shutil.copyfile(include_filename, os.path.join(build_folder, include_filename))

    for model_filename in model_filenames:
        with open(params_filename, "rt") as params_file:
            params = params_file.read()

        with open(model_filename, "rt") as model_file:
            model = model_file.read()

        # 1. combine params with model
        output_model_str = (
            params + "\n" + model.replace(f"include <centercap_params.scad>", "")
        )

        output_filename = os.path.join(build_folder, model_filename)
        with open(output_filename, "wt") as output_model_file:
            output_model_file.write(output_model_str)

        # 2. execute openscad in shell with json file
        for buildset in buildsets:
            output_stl = os.path.join(
                build_folder,
                buildset,
                model_filename.replace(".scad", "_" + buildset + ".stl"),
            )
            subprocess.run(
                [
                    "openscad",
                    "--hardwarnings",
                    "-o",
                    output_stl,
                    "-p",
                    json_filename,
                    "-P",
                    buildset,
                    output_filename,
                ],
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
