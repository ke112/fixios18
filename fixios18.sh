#!/bin/bash

# 定义要查找的文件路径
FILE="./ios/.symlinks/plugins/flutter_inappwebview_ios/ios/Classes/InAppWebView/InAppWebView.swift"
FILE2="$HOME/.pub-cache/hosted/pub.flutter-io.cn/flutter_inappwebview_ios-1.0.13/ios/Classes/InAppWebView/InAppWebView.swift"

# 定义一个函数来处理文件修改逻辑
modify_file() {
    local file_path=$1

    # 检查文件是否存在
    if [ -f "$file_path" ]; then
        # 查找已修改的代码
        if grep -q 'public override func evaluateJavaScript(_ javaScriptString: String, completionHandler: (@MainActor @Sendable (Any?, (any Error)?) -> Void)? = nil)' "$file_path"; then
            echo "文件 $file_path 代码已修改，无需再次修改。"
        # 查找原始代码
        elif grep -q 'public override func evaluateJavaScript(_ javaScriptString: String, completionHandler: ((Any?, Error?) -> Void)? = nil)' "$file_path"; then
            # 修改代码
            sed -i '' 's/public override func evaluateJavaScript(_ javaScriptString: String, completionHandler: ((Any?, Error?) -> Void)? = nil)/public override func evaluateJavaScript(_ javaScriptString: String, completionHandler: (@MainActor @Sendable (Any?, (any Error)?) -> Void)? = nil)/' "$file_path"

            if [ $? -eq 0 ]; then
                echo "文件 $file_path 代码修改成功。"
            else
                echo "文件 $file_path 代码修改失败。"
            fi
        else
            echo "文件 $file_path 中未找到目标代码，无法进行修改。"
        fi
    else
        echo "文件 $file_path 不存在。"
    fi
}

# 修改 FILE 和 FILE2
modify_file "$FILE"
modify_file "$FILE2"
