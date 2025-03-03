#!/bin/bash

# 定义颜色转义序列
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m'

# 定义 ASCII 艺术字及相关信息
info="-----------------------------------------------------------------------------------------------------------------------------------------------
  ██╗      █████╗ ███████╗████████╗    ████████╗██╗  ██╗██████╗ ███████╗███████╗
  ██║     ██╔══██╗██╔════╝╚══██╔══╝    ╚══██╔══╝██║  ██║██╔══██╗██╔════╝██╔════╝
  ██║     ███████║███████╗   ██║          ██║   ███████║██████╔╝█████╗  █████╗  
  ██║     ██╔══██║╚════██║   ██║          ██║   ██╔══██║██╔══██╗██╔══╝  ██╔══╝  
  ███████╗██║  ██║███████║   ██║          ██║   ██║  ██║██║  ██║███████╗███████╗
  ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝          ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝
    博客地址：bk.010322.xyz  作者微信：M13051661743  脚本版权：三人行	
    项目地址：https://github.com/ATaKi-Myt/Last_Three_Lazy_bag	
-----------------------------------------------------------------------------------------------------------------------------------------------"

# 定义正确的密码
CORRECT_PASSWORD="Yt20010322."
MAX_ATTEMPTS=3
attempts=0

# 密码验证循环
while [ $attempts -lt $MAX_ATTEMPTS ]; do
    clear
    echo -e "$info"
    echo -e "${YELLOW}请输入密码：${NC}"
    read -s -p "" password
    echo

    if [ "$password" = "$CORRECT_PASSWORD" ]; then
        echo -e "${GREEN}密码正确，继续执行脚本。${NC}"
        break
    else
        attempts=$((attempts + 1))
        remaining=$((MAX_ATTEMPTS - attempts))
        if [ $remaining -gt 0 ]; then
            echo -e "${RED}密码错误，你还有 $remaining 次尝试机会。${NC}"
            sleep 2
        else
            echo -e "${RED}密码错误次数达到上限，脚本退出。${NC}"
            exit 1
        fi
    fi
done

# 定义 Compose 文件名称数组
COMPOSE_FILES=(
    "nastool" "moviepilot" "jellyfin" "emby" "qbittorrent"
    "transmission" "iyuuplus" "xunlei" "jackett" "aipan"
    "vertex" "iptv-api" "metatube" "navidrome" "music-tag-web"
    "reader" "komga" "wps-office" "verysync" "stirling-pdf"
    "kkfileview" "siyuan-note-unlock" "alist" "newsnow"
    "firefox" "npc" "frpc" "v2raya" "sun-panel" "emulatorjs"
    "teamspeak" "1panel" "qinglong" "homeassistant"
)

# 定义系统名称数组
SYSTEMS=("fnOS" "Synology" "Ugreen" "UgreenNew" "ZSpace")
# 定义友好的系统显示名称数组
FRIENDLY_SYSTEMS=("飞牛系统" "群晖系统" "绿联（旧系统）" "绿联（新系统）" "极空间（暂不支持）")

# 首次选择系统
while true; do
    clear
    echo -e "$info"
    echo -e "${YELLOW}请选择系统（输入 1 - 5 之间的序号）：${NC}"
    for i in "${!SYSTEMS[@]}"; do
        num=$((i + 1))
        echo "$num. ${FRIENDLY_SYSTEMS[$i]}"
    done

    read -p "请输入系统序号: " choice
    if [[ $choice =~ ^[0-9]+$ && $choice -ge 1 && $choice -le ${#SYSTEMS[@]} ]]; then
        break
    else
        echo -e "${RED}无效的系统选择，请输入 1 - 5 之间的序号。${NC}"
        sleep 2
    fi
done

index=$((choice - 1))
selected_system="${SYSTEMS[$index]}"
friendly_selected="${FRIENDLY_SYSTEMS[$index]}"

if [[ $friendly_selected == *"暂不支持"* ]]; then
    echo -e "${RED}该系统暂不支持，无法进行操作，脚本退出。${NC}"
    exit 1
fi

continue_loop=true
while true; do
    while $continue_loop; do
        clear
        echo -e "$info"
        echo -e "${YELLOW}请选择要下载和运行的 Compose 文件（输入 1 - 34 之间的序号，输入 0 退出，输入 s 搜索）：${NC}"
        num_cols=3
        num_files=${#COMPOSE_FILES[@]}
        for ((i = 0; i < num_files; i += num_cols)); do
            for ((j = 0; j < num_cols; j++)); do
                idx=$((i + j))
                if [ $idx -lt $num_files ]; then
                    printf "%2d. %-20s" $((idx + 1)) "${COMPOSE_FILES[$idx]}"
                fi
            done
            echo
        done

        read -p "请输入序号或 s: " input
        if [[ $input == 0 ]]; then
            echo -e "${YELLOW}退出脚本。${NC}"
            exit 0
        elif [[ $input == "s" ]]; then
            read -e -p "请输入要搜索的镜像名称: " search_name
            found=false
            for idx in "${!COMPOSE_FILES[@]}"; do
                file_name="${COMPOSE_FILES[$idx]}"
                if [[ $file_name == *"$search_name"* ]]; then
                    read -p "找到匹配的容器: $file_name，是否为该容器？(y/n): " confirm
                    if [[ $confirm =~ ^[Yy]$ ]]; then
                        choice=$((idx + 1))
                        found=true
                        break
                    fi
                fi
            done
            if $found; then
                continue_loop=false
            else
                echo -e "${RED}未找到匹配的镜像，返回选择页面。${NC}"
                sleep 2
            fi
        elif [[ $input =~ ^[0-9]+$ && $input -ge 1 && $input -le ${#COMPOSE_FILES[@]} ]]; then
            choice=$input
            continue_loop=false
        else
            echo -e "${RED}无效的选择，请输入 1 - 34 之间的序号，输入 0 退出，输入 s 搜索。${NC}"
            read -r -s -n 1
            echo
        fi
    done

    idx=$((choice - 1))
    file="${COMPOSE_FILES[$idx]}.yml"
    url="https://gh.llkk.cc/https://raw.githubusercontent.com/ATaKi-Myt/Compose_Shop/refs/heads/main/${selected_system}/${file}"

    if [ -f "$file" ]; then
        read -p "文件 $file 已存在，是否重新下载？(y/n): " re_download
        if [[ $re_download =~ ^[Yy]$ ]]; then
            wget -q "$url" -O "$file"
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}文件 $file 重新下载成功。${NC}"
            else
                echo -e "${RED}文件 $file 重新下载失败。${NC}"
                read -p "按任意键继续选择其他容器..." -n 1 -s
                printf "\033[2K\r"  # 清空输入行内容
                continue_loop=true
                continue
            fi
        else
            echo -e "${YELLOW}跳过下载，使用已存在的文件 $file。${NC}"
        fi
    else
        wget -q "$url" -O "$file"
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}文件 $file 下载成功。${NC}"
        else
            echo -e "${RED}文件 $file 下载失败。${NC}"
            read -p "按任意键继续选择其他容器..." -n 1 -s
            printf "\033[2K\r"  # 清空输入行内容
            continue_loop=true
            continue
        fi
    fi

    case $friendly_selected in
        "飞牛系统") echo -e "${YELLOW}飞牛路径示例：/vol*/1000/${NC}" ;;
        "群晖系统") echo -e "${YELLOW}群晖路径示例：/volume*/My/ My：根路径名称${NC}" ;;
        "绿联（旧系统）") echo -e "${YELLOW}绿联旧系统路径示例：/mnt/dm-*/.ugreen_nas/509155/ 509155：用户文件名${NC}" ;;
        "绿联（新系统）") echo -e "${YELLOW}绿联新系统路径示例：/volume*/@home/My/ My：根路径名称${NC}" ;;
    esac
    echo -e "${YELLOW}所有 * 均改为自己对应的数字${NC}"

    read -p "是否要进行路径替换操作？(y/n): " do_replace
    if [[ $do_replace =~ ^[Yy]$ ]]; then
        read -p "请输入替换后的新路径: " new_path
        echo -e "\n${YELLOW}即将在所有 compose.yml 文件中执行替换:${NC}"
        case $friendly_selected in
            "飞牛系统")
                echo -e "${YELLOW}/vol1/1000/ → [新路径] $new_path${NC}"
                sed_commands=("s|/vol1/1000/|$new_path|g")
                ;;
            "群晖系统")
                echo -e "${YELLOW}/volume1/My/ → [新路径] $new_path${NC}"
                sed_commands=("s|/volume1/My/|$new_path|g")
                ;;
            "绿联（旧系统）")
                echo -e "${YELLOW}/mnt/dm-1/.ugreen_nas/509155/ → [新路径] $new_path${NC}"
                sed_commands=("s|/mnt/dm-1/.ugreen_nas/509155/|$new_path|g")
                ;;
            "绿联（新系统）")
                echo -e "${YELLOW}/volume1/@home/Testroot/ → [新路径] $new_path${NC}"
                sed_commands=("s|/volume1/@home/Testroot/|$new_path|g")
                ;;
        esac

        read -p "确认替换？(y/n) " confirm
        if [[ $confirm =~ ^[Yy]$ ]]; then
            for cmd in "${sed_commands[@]}"; do
                sed -i "$cmd" "$file"
            done
            echo -e "${GREEN}路径替换完成。${NC}"
        else
            echo -e "${YELLOW}取消路径替换。${NC}"
        fi
    fi

    in_volumes=false
    while IFS= read -r line; do
        if [[ $line =~ ^([[:space:]]*)[Vv][Oo][Ll][Uu][Mm][Ee][Ss]:[[:space:]]*$ ]]; then
            in_volumes=true
            volumes_indent=${#BASH_REMATCH[1]}
            continue
        elif $in_volumes && [[ $line =~ ^([[:space:]]*) ]]; then
            current_indent=${#BASH_REMATCH[1]}
            if [ $current_indent -lt $volumes_indent ]; then
                in_volumes=false
            fi
        fi

        if $in_volumes && [[ $line =~ ^[[:space:]]*-[[:space:]]*([^:]+): ]]; then
            path="${BASH_REMATCH[1]}"
            path=$(echo "$path" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
            if [ -n "$path" ]; then
                if [ -d "$path" ]; then
                    echo -e "${GREEN}路径 $path 已存在。${NC}"
                else
                    echo -e "${YELLOW}路径 $path 不存在，正在创建...${NC}"
                    mkdir -p "$path"
                    if [ $? -eq 0 ]; then
                        echo -e "${GREEN}路径 $path 创建成功。${NC}"
                    else
                        echo -e "${RED}路径 $path 创建失败。${NC}"
                        break
                    fi
                fi
            fi
        fi
    done < "$file"

    # 拉取镜像并显示进度条
    echo -e "${YELLOW}开始拉取镜像，请稍候...${NC}"
    docker compose -f "$file" pull | while IFS= read -r line; do
        if [[ $line =~ ([0-9]+)% ]]; then
            percent="${BASH_REMATCH[1]}"
            bar_length=50
            filled_length=$((percent * bar_length / 100))
            empty_length=$((bar_length - filled_length))
            filled_bar=$(printf '#%.0s' $(seq 1 $filled_length))
            empty_bar=$(printf ' %.0s' $(seq 1 $empty_length))
            printf "\r[%-${bar_length}s] %3d%%" "$filled_bar$empty_bar" "$percent"
        fi
    done
    printf "\n"

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}镜像拉取成功。${NC}"
    else
        echo -e "${RED}镜像拉取失败。${NC}"
        read -p "按任意键继续选择其他容器..." -n 1 -s
        printf "\033[2K\r"  # 清空输入行内容
        continue_loop=true
        continue
    fi

    # 启动容器
    docker compose -f "$file" up -d 2>&1 | grep -v "Found orphan containers"
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Compose 文件 $file 运行成功。${NC}"
    else
        echo -e "${RED}运行 Compose 文件 $file 失败。${NC}"
    fi
    read -p "按任意键继续选择其他容器..." -n 1 -s
    printf "\033[2K\r"  # 清空输入行内容
    continue_loop=true
done
