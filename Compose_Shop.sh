#!/bin/bash

# 定义颜色转义序列
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # 恢复默认颜色

# 定义 ASCII 艺术字及相关信息
info="-----------------------------------------------------------------------------------------------------------------------------------------------

  ██╗      █████╗ ███████╗████████╗    ████████╗██╗  ██╗██████╗ ███████╗███████╗
  ██║     ██╔══██╗██╔════╝╚══██╔══╝    ╚══██╔══╝██║  ██║██╔══██╗██╔════╝██╔════╝
  ██║     ███████║███████╗   ██║          ██║   ███████║██████╔╝█████╗  █████╗  
  ██║     ██╔══██║╚════██║   ██║          ██║   ██╔══██║██╔══██╗██╔══╝  ██╔══╝  
  ███████╗██║  ██║███████║   ██║          ██║   ██║  ██║██║  ██║███████╗███████╗
  ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝          ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝

    博客地址：bk.010322.xyz  作者微信：M13051661743  脚本版权：三人行	
    项目地址：https://github.com/ATaKi-Myt/Compose_Shop	

-----------------------------------------------------------------------------------------------------------------------------------------------"

# 定义正确的密码
correct_password="Yt20010322."

# 定义最大尝试次数
max_attempts=3
attempts=0

while [ $attempts -lt $max_attempts ]; do
    clear
    echo -e "$info"
    echo -e "${YELLOW}请输入密码：${NC}"
    read -s -p "" password
    echo

    if [ "$password" = "$correct_password" ]; then
        echo -e "${GREEN}密码正确，继续执行脚本。${NC}"
        break
    else
        attempts=$((attempts + 1))
        remaining_attempts=$((max_attempts - attempts))
        if [ $remaining_attempts -gt 0 ]; then
            echo -e "${RED}密码错误，你还有 $remaining_attempts 次尝试机会。${NC}"
            sleep 2
        else
            echo -e "${RED}密码错误次数达到上限，脚本退出。${NC}"
            exit 1
        fi
    fi
done

# 定义 Compose 文件名称数组，将 qbaittorrent 改为 qbittorrent
compose_files=(
    "nastool"
    "moviepilot"
    "jellyfin"
    "emby"
    "qbittorrent"
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
while true; do
    clear
    echo -e "$info"
    echo "请选择系统（输入 1 - 5 之间的序号）："
    for i in "${!systems[@]}"; do
        num=$((i + 1))
        echo "$num. ${friendly_system_names[$i]}"
    done

    read -p "请输入系统序号: " system_choice
    if [[ $system_choice =~ ^[0-9]+$ && $system_choice -ge 1 && $system_choice -le ${#systems[@]} ]]; then
        break
    else
        echo "无效的系统选择，请输入 1 - 5 之间的序号。"
        sleep 2
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
    clear
    echo -e "$info"
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
            sleep 2
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

        # 根据不同系统显示路径示例
        case $friendly_selected_system in
            "飞牛系统")
                echo "飞牛路径示例：/vol*/1000/"
                ;;
            "群晖系统")
                echo "群晖路径示例：/volume*/My/ My：根路径名称"
                ;;
            "绿联（旧系统）")
                echo "绿联旧系统路径示例：/mnt/dm-*/.ugreen_nas/509155/ 509155：用户文件名"
                ;;
            "绿联（新系统）")
                echo "绿联新系统路径示例：/volume*/@home/My/ My：根路径名称"
                ;;
        esac
        echo "所有 * 均改为自己对应的数字"

        read -p "是否要进行路径替换操作？(y/n): " do_replace
        if [[ $do_replace =~ ^[Yy]$ ]]; then
            read -p "请输入替换后的新路径: " new_path

            echo -e "\n即将在所有 compose.yml 文件中执行替换:"
            echo "/vol1/1000/ → [新路径] $new_path"
            echo "/mnt/dm-1/.ugreen_nas/509155/ → [新路径] $new_path"
            echo "/volume1/My/ → [新路径] $new_path"
            echo "/volume1/@home/Testroot/ → [新路径] $new_path"
            read -p "确认替换？(y/n) " confirm
            if [[ $confirm =~ ^[Yy]$ ]]; then
                sed -i "s|/vol1/1000/|$new_path|g" "$file_name"
                sed -i "s|/mnt/dm-1/.ugreen_nas/509155/|$new_path|g" "$file_name"
                sed -i "s|/volume1/My/|$new_path|g" "$file_name"
                sed -i "s|/volume1/@home/Testroot/|$new_path|g" "$file_name"
                echo "路径替换完成。"
            else
                echo "取消路径替换。"
            fi
        fi

        # 运行 Compose 文件，过滤掉孤儿容器警告信息
        docker compose -f "$file_name" up -d 2>&1 | grep -v "Found orphan containers"
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}Compose 文件 $file_name 运行成功。${NC}"
        else
            echo -e "${RED}运行 Compose 文件 $file_name 失败。${NC}"
        fi
        read -p "按任意键继续选择其他容器..." -n 1 -s
    else
        echo "下载文件 $file_name 失败。"
        read -p "按任意键继续选择其他容器..." -n 1 -s
    fi
done
