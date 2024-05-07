function restore_trash() {
    # 检查是否有任何参数传入
    if [ $# -eq 0 ]; then
        echo "No file specified for restoration."
        echo "Use '--all' to restore all files or specify one or more files to restore."
        return 1
    fi

    if (( $# > 1 )) && [[ "$@" = *"--all"* ]]; then
        echo "Invalid usage: '--all' must be used alone."
        return 1
    fi

    # 处理恢复所有文件的情况
    if [ "$1" == "--all" ]; then
        for trash_file in "$HOME/.trash/"*; do
            restore_file "$trash_file"
        done
        return 0
    fi

    # 处理单个或多个文件的恢复
    for trash_file in "$@"; do
        restore_file "$trash_file"
    done
}

function restore_file() {
    local trash_file="$1"
    local base_name=$(basename "$trash_file")
    
    # 使用正则表达式去除时间戳，假设时间戳是一串数字
    local rel_path_underscore=$(echo "$base_name" | sed 's/\.[0-9]*$//')
    
    # 将下划线转换回斜线以获取原始的相对路径
    local rel_path=$(echo "$rel_path_underscore" | tr '__' '/')
    local original_path="$HOME/$rel_path"
    
    # 检查文件是否存在
    if [ ! -f "$trash_file" ]; then
        echo "File does not exist: $trash_file"
        return 1
    fi
    
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
}
