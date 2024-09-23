#!/bin/bash

# Get the absolute path of the directory where the current script is located
script_path=$(
    cd "$(dirname "$0")"
    pwd
)

# Project root directory
workspace_dir=$(dirname "$(dirname "$script_path")")

# Define the file path to be searched
FILE="$workspace_dir/ios/.symlinks/plugins/flutter_inappwebview_ios/ios/Classes/InAppWebView/InAppWebView.swift"
BASE_DIR="$HOME/.pub-cache/hosted/pub.flutter-io.cn/flutter_inappwebview_ios"

# Define a function to handle file modification logic
modify_file() {
    local file_path=$1

    # Check if the file exists
    if [ -f "$file_path" ]; then
        # Look for the already modified code
        if grep -q 'public override func evaluateJavaScript(_ javaScriptString: String, completionHandler: (@MainActor @Sendable (Any?, (any Error)?) -> Void)? = nil)' "$file_path"; then
            echo "The file $file_path code is already modified, no need to modify again."
        # Look for the original code
        elif grep -q 'public override func evaluateJavaScript(_ javaScriptString: String, completionHandler: ((Any?, Error?) -> Void)? = nil)' "$file_path"; then
            # Modify the code
            sed -i '' 's/public override func evaluateJavaScript(_ javaScriptString: String, completionHandler: ((Any?, Error?) -> Void)? = nil)/public override func evaluateJavaScript(_ javaScriptString: String, completionHandler: (@MainActor @Sendable (Any?, (any Error)?) -> Void)? = nil)/' "$file_path"

            if [ $? -eq 0 ]; then
                echo "The file $file_path code has been successfully modified."
            else
                echo "The file $file_path code modification failed."
            fi
        else
            echo "The target code was not found in the file $file_path, unable to modify."
        fi
    else
        echo "The file $file_path does not exist."
    fi
}

# Modify the file under ./ios/.symlinks
modify_file "$FILE"

# Iterate over all versions in the .pub-cache/hosted/pub.flutter-io.cn/flutter_inappwebview_ios directory
for dir in "$BASE_DIR"-*; do
    FILE_PATH="$dir/ios/Classes/InAppWebView/InAppWebView.swift"
    modify_file "$FILE_PATH"
done
