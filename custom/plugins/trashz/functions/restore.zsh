function restore_trash() {
    # 检查是否传入了文件名
    if [ "$#" -eq 0 ]; then
        echo "No specific file provided. Restoring all files in .trash..."
        set -- "$HOME/.trash"/*
    fi

    for trash_file in "$@"; do
        if [ ! -f "$trash_file" ]; then
            echo "File does not exist: $trash_file"
            continue
        fi

        local base_name=$(basename "$trash_file")
        # 使用正则表达式去除时间戳，假设时间戳是一串数字
        local rel_path_underscore=$(echo "$base_name" | sed 's/\.[0-9]*$//')

        # 将下划线转换回斜线以获取原始的相对路径
        local rel_path=$(echo "$rel_path_underscore" | tr '_' '/')

        # 构建原始文件的绝对路径
        local original_path="$HOME/$rel_path"

        # 检查目标路径的目录是否存在，如果不存在，则创建它
        local dir_path=$(dirname "$original_path")
        if [ ! -d "$dir_path" ]; then
            mkdir -p "$dir_path"
        fi

        # 将文件从.trash移动到原始路径
        if mv "$trash_file" "$original_path"; then
            echo "Successfully restored '$trash_file' to '$original_path'"
        else
            echo "Failed to restore '$trash_file'"
        fi
    done
}
