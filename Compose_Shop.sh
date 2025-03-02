#!/bin/bash

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

# 定义每个文件的下载和运行函数
for file in "${compose_files[@]}"; do
    func_name="${file//-/_}"  # 将文件名中的 - 替换为 _ 以符合函数命名规则
    cat << EOF
function $func_name() {
    file_name="${file}.yml"
    download_url="https://raw.githubusercontent.com/ATaKi-Myt/Compose_Shop/refs/heads/main/fnOS/\$file_name"
    wget -q \$download_url -O \$file_name
    if [ \$? -eq 0 ]; then
        echo "文件 \$file_name 下载成功。"
        docker-compose -f \$file_name up -d
        if [ \$? -eq 0 ]; then
            echo "Compose 文件 \$file_name 运行成功。"
        else
            echo "运行 Compose 文件 \$file_name 失败。"
        fi
    else
        echo "下载文件 \$file_name 失败。"
    fi
}
EOF
done

# 提示用户输入密码
read -s -p "请输入密码: " password
echo

# 显示选项列表
echo "请选择要下载和运行的 Compose 文件（输入 1 - 34 之间的序号）："
for i in "${!compose_files[@]}"; do
    num=$((i + 1))
    func_name="${compose_files[$i]//-/_}"  # 将文件名中的 - 替换为 _ 以符合函数命名规则
    echo "$num. ${compose_files[$i]}"
done

# 获取用户选择
while true; do
    read -p "请输入序号: " choice
    if [[ $choice =~ ^[0-9]+$ && $choice -ge 1 && $choice -le ${#compose_files[@]} ]]; then
        break
    else
        echo "无效的选择，请输入 1 - 34 之间的序号。"
    fi
done

# 根据选择调用相应的函数
index=$((choice - 1))
func_name="${compose_files[$index]//-/_}"  # 将文件名中的 - 替换为 _ 以符合函数命名规则
$func_name
