#!/usr/bin/env sh

# Synopsis:
# Run the test runner on a solution.

# Arguments:
# $1: exercise slug
# $2: path to solution folder
# $3: path to output directory

# Output:
# Writes the test results to a results.json file in the passed-in output directory.
# The test results are formatted according to the specifications at https://github.com/exercism/docs/blob/main/building/tooling/test-runners/interface.md

# Example:
# ./bin/run.sh two-fer path/to/solution/folder/ path/to/output/directory/

# If any required arguments is missing, print the usage and exit
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
    echo "usage: ./bin/run.sh exercise-slug path/to/solution/folder/ path/to/output/directory/"
    exit 1
fi

slug="$1"

solution_dir=$(realpath "${2%/}")
output_dir=$(realpath "${3%/}")
results_file="${output_dir}/results.json"

# Create the output directory if it doesn't exist
mkdir -p "${output_dir}"

echo "${slug}: testing..."

rm -f test.elv
rm -f solution.elv
rm -f ./**/test.elv
rm -f ./**/solution.elv
test_original="$solution_dir/$slug.test.elv"
cp -f "$slug/test-original.elv" "$test_original"
solution_original="$solution_dir/$slug.elv"
cp -f "$test_original" "./test.elv"
cp -f "$test_original" "./bin/test.elv"
cp -f "$solution_original" "./solution.elv"
cp -f "$solution_original" "./bin/solution.elv"
elvish "./bin/run.elv" > "$results_file"

echo "wrote json results to $results_file"

echo "${slug}: done"
