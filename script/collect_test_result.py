import os
import re
import sys
from collections import defaultdict

exception_list = []


def strip_ansi_escape_sequences(text):
    ansi_escape_pattern = re.compile(r"\x1B(?:[@-Z\\-_]|\[[0-?]*[ -/]*[@-~])")
    return ansi_escape_pattern.sub("", text)


def collect_test_results(base_dir, log_filename="stdout_stderr.log"):
    result_data = {}

    # Walk through all subdirectories
    for root, _, files in os.walk(base_dir):
        if log_filename in files:
            file_path = os.path.join(root, log_filename)

            with open(file_path, "r") as file:
                lines = file.readlines()

                log_result = []

                # Flags to determine when to start/stop extracting
                part1_start = False
                part2_start = False

                for line in lines:
                    # Detect and start collecting Part 1
                    if re.search(r".*tests passed.*tests failed", line):
                        part1_start = True

                    # Stop collecting Part 1 when reaching "Label Time Summary:"
                    if part1_start and "Label Time Summary:" in line:
                        part1_start = False

                    # Collect lines for Part 1
                    if part1_start:
                        log_result.append(line)

                    # Detect and start collecting Part 2
                    if "Total Test time (real) =" in line:
                        part2_start = True

                    # Stop collecting Part 2 when reaching "Errors while running CTest"
                    if part2_start and "Errors while running CTest" in line:
                        part2_start = False

                    # Collect lines for Part 2
                    if part2_start:
                        log_result.append(line)

                # Save the content from this line to the end of the files
                if log_result:
                    result_data[file_path] = strip_ansi_escape_sequences(
                        "".join(log_result)
                    )

    return result_data


def export_full_result(filename, collected_results):
    with open(filename, "w") as output_file:
        for file_path, content in collected_results.items():
            output_file.write(f"Results from: {file_path}\n\n")
            output_file.write(content)
            output_file.write("\n" + "=" * 80 + "\n")


def covert_to_dict(collected_results):
    # Initialize a defaultdict to store results
    results = defaultdict(list)

    # Regular expression patterns for extracting information
    failed_tests_pattern = re.compile(
        r"The following tests FAILED:\n((?:\t\s*\d+ - .+? \(.*?\)\n?)+)"
    )
    individual_failed_test_pattern = re.compile(r"\t\s*(\d+ - .+? \(.*?\))")

    for file_path, content in collected_results.items():
        package_name = file_path.split("/")[-2]
        failed_tests_block = failed_tests_pattern.search(content)
        if failed_tests_block:
            individual_failed_tests = individual_failed_test_pattern.findall(
                failed_tests_block.group(1)
            )
            if individual_failed_tests:
                results[package_name].extend(individual_failed_tests)

    # Convert defaultdict to a regular dictionary
    return dict(results)


def export_filtered_result(filename, filtered_result):
    output = ""
    fail_test_num = 0
    for pkg, fail_list in filtered_result.items():
        for f in fail_list:
            skip = False
            for e in exception_list:
                if e in f:
                    skip = True
                    break
            if not skip:
                output += pkg + ": " + f + "\n"
                fail_test_num += 1
    if fail_test_num != 0:
        output += "Failure number: " + str(fail_test_num)
    with open(filename, "w") as output_file:
        output_file.write(output)
    return (fail_test_num, output)


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Please assign the folder you want to collect logs")
        sys.exit()

    # Collect result from all directories
    base_directory = sys.argv[1] + "/log/latest_test/"
    collected_results = collect_test_results(base_directory)

    # Save results to a summary file
    export_filename = "log_" + sys.argv[1] + "_full.log"
    export_full_result(export_filename, collected_results)

    # Covert results to dict
    results_dict = covert_to_dict(collected_results)

    # Print out the results can filter the exception one
    export_filename = "log_" + sys.argv[1] + "_simplified.log"
    (failure_num, result) = export_filtered_result(export_filename, results_dict)

    # Check results
    if failure_num != 0:
        print(result)
