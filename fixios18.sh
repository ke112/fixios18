#!/bin/bash

# 定义要查找的文件路径
FILE="./ios/.symlinks/plugins/flutter_inappwebview_ios/ios/Classes/InAppWebView/InAppWebView.swift"

# 检查文件是否存在
if [ -f "$FILE" ]; then
    # 查找目标代码
    if grep -q 'public override func evaluateJavaScript(_ javaScriptString: String, completionHandler: ((Any?, Error?) -> Void)? = nil)' "$FILE"; then
        # 修改代码
        sed -i '' 's/public override func evaluateJavaScript(_ javaScriptString: String, completionHandler: ((Any?, Error?) -> Void)? = nil)/public override func evaluateJavaScript(_ javaScriptString: String, completionHandler: (@MainActor @Sendable (Any?, (any Error)?) -> Void)? = nil)/' "$FILE"

        if [ $? -eq 0 ]; then
            echo "代码修改成功。"
        else
            echo "代码修改失败。"
        fi
    else
        echo "目标代码未找到，无法进行修改。"
    fi
else
    echo "文件不存在。"
fi 
