#!/bin/bash

# 定义正确的密码
correct_password="Yt20010322."

# 提示用户输入密码
read -s -p "请输入密码: " password
echo

# 验证密码
if [ "$password" != "$correct_password" ]; then
    echo "密码错误，脚本退出。"
    exit 1
fi

# 定义 Compose 文件名称数组
compose_files=(
    "nastool"
    "moviepilot"
    "jellyfin"
    "emby"
    "qbaittorrent"
    "transmission"
    "iyuuplus"
    "xunlei"
    "jackett"
    "apipan"
    "vertex"
    "iptv-api"
    "metatube"
    "navidrome"
    "music-tag-web"
    "reader"
    "komga"
    "wps-office"
    "verysync"
    "stirling-pdf"
    "kkfileview"
    "siyuan-note-unlock"
    "alist"
    "newsnow"
    "firefox"
    "npc"
    "frpc"
    "v2raya"
    "sun-panel"
    "emulatorjs"
    "teamspeak"
    "1panel"
    "qinglong"
    "homeassistant"
)

# 定义系统名称数组
systems=("fnOS" "Synology" "Ugreen" "UgreenNew" "ZSpace")
# 定义友好的系统显示名称数组
friendly_system_names=("飞牛系统" "群晖系统" "绿联（旧系统）" "绿联（新系统）" "极空间（暂不支持）")

# 首次选择系统
echo "请选择系统（输入 1 - 5 之间的序号）："
for i in "${!systems[@]}"; do
    num=$((i + 1))
    echo "$num. ${friendly_system_names[$i]}"
done

while true; do
    read -p "请输入系统序号: " system_choice
    if [[ $system_choice =~ ^[0-9]+$ && $system_choice -ge 1 && $system_choice -le ${#systems[@]} ]]; then
        break
    else
        echo "无效的系统选择，请输入 1 - 5 之间的序号。"
    fi
done

system_index=$((system_choice - 1))
selected_system="${systems[$system_index]}"
friendly_selected_system="${friendly_system_names[$system_index]}"

if [[ $friendly_selected_system == *"暂不支持"* ]]; then
    echo "该系统暂不支持，无法进行操作，脚本退出。"
    exit 1
fi

while true; do
    # 显示选项列表
    echo "请选择要下载和运行的 Compose 文件（输入 1 - 34 之间的序号，输入 0 退出）："
    num_columns=3  # 定义分栏数量
    num_files=${#compose_files[@]}
    for ((i = 0; i < num_files; i += num_columns)); do
        for ((j = 0; j < num_columns; j++)); do
            index=$((i + j))
            if [ $index -lt $num_files ]; then
                printf "%2d. %-20s" $((index + 1)) "${compose_files[$index]}"
            fi
        done
        echo
    done

    # 获取用户选择
    while true; do
        read -p "请输入序号: " choice
        if [[ $choice == 0 ]]; then
            echo "退出脚本。"
            exit 0
        elif [[ $choice =~ ^[0-9]+$ && $choice -ge 1 && $choice -le ${#compose_files[@]} ]]; then
            break
        else
            echo "无效的选择，请输入 1 - 34 之间的序号，输入 0 退出。"
        fi
    done

    # 根据选择获取文件名
    index=$((choice - 1))
    file_name="${compose_files[$index]}.yml"
    # 构造下载链接
    download_url="https://raw.githubusercontent.com/ATaKi-Myt/Compose_Shop/refs/heads/main/${selected_system}/${file_name}"

    # 下载文件
    wget -q "$download_url" -O "$file_name"
    if [ $? -eq 0 ]; then
        echo "文件 $file_name 下载成功。"
        # 运行 Compose 文件
        docker compose -f "$file_name" up -d
        if [ $? -eq 0 ]; then
            echo "Compose 文件 $file_name 运行成功。"
        else
            echo "运行 Compose 文件 $file_name 失败。"
        fi
    else
        echo "下载文件 $file_name 失败。"
    fi
done
