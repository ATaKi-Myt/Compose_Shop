# Compose 商店（Compose_Shop）
## 一、项目简介
Compose 商店致力于为您提供便捷高效的 Docker 容器配置解决方案。通过我们精心整理的 Docker Compose 配置文件，您可以轻松摆脱繁琐的可视化配置流程，直接使用.yml 文件对 Docker 容器进行精准配置。商店内汇集了丰富实用的 Docker Compose 配置文件，您只需简单操作，输入相应的序号或者 Docker 名称，即可一键完成 Docker 的安装，真正实现一步到位的便捷体验。

## 二、Docker 清单
| 序号 | Docker 名称 | 作用 |
| :---: | :---: | --- |
| 1 | 1panel | 服务器面板 |
| 2 | aipan | 网盘资源索引器 |
| 3 | alist | 网盘挂载 |
| 4 | babybuddy | 育儿管理面板 |
| 5 | cashbook | 记账工具 |
| 6 | chinesesubfinder | 字幕下载工具 |
| 7 | clouddrive2 | 网盘挂载 |
| 8 | cloudsaver | 网盘资源转存工具 |
| 9 | emby | 媒体服务器 |
| 10 | emulatorjs | 掌机模拟器 |
| 11 | ezbookkeeping | 记账工具 |
| 12 | firefox | 火狐浏览器 |
| 13 | frpc | frpc 穿透客户端 |
| 14 | homeassistant | 开源智能家居管理面板 |
| 15 | homebox | 家庭资产管理面板 |
| 16 | icloudpd | icloud 图片转存工具 |
| 17 | ip-tool | ip 检测工具箱 |
| 18 | iptv-api | iptv |
| 19 | iyuuplus | 转种辅种 |
| 20 | jackett | 索引器 |
| 21 | jellyfin | 媒体服务器 |
| 22 | kkfileview | 多格式文件在线预览 |
| 23 | komga | 动漫库 |
| 24 | lyricapi | 音流刮削器 |
| 25 | mariadb | 数据库 |
| 26 | mediago | B站资源下载器 |
| 27 | metatube | 小姐姐刮削服务器 |
| 28 | moviepilot | 家庭影院 |
| 29 | music-tag-web | 音乐刮削器 |
| 30 | mysql | 数据库 |
| 31 | nastool | 家庭影院 |
| 32 | navidrome | 音乐服务器 |
| 33 | newsnow | 各大平台十条热搜 |
| 34 | npc | npc 穿透客户端 |
| 35 | ollama | 智能体工具 |
| 36 | open-webui | 可视化智能体对话面板 |
| 37 | postgres | 数据库 |
| 38 | qbittorrent | 下载器 |
| 39 | qinglong | 青龙脚本面板 |
| 40 | reader | 电子书库 |
| 41 | siyuan-note-unlock | 免登录版思源笔记 |
| 42 | stirling-pdf | pdf 工具箱 |
| 43 | sun-panel | 集成 Docker 状态及美化面板 |
| 44 | teamspeak | 低占用无广告游戏语音服务器 |
| 45 | transmission | 下载器 |
| 46 | v2raya | 代理 |
| 47 | vertex | 刷流 |
| 48 | verysync | 微力同步 |
| 49 | wallos | 订阅服务统计 |
| 50 | watchtower | 自动检测更新镜像 |
| 51 | wechat | 网页版微信 |
| 52 | wps-office | 在线文档编辑器 |
| 53 | xiaoaimusic | 小爱同学面板 |
| 54 | xunlei | 下载器 |

### 持续更新容器中......

* 打开 **FinalShell** 软件
* 进入 **root** 权限，输入`sudo -i` 并输入飞牛 **密码**，进入 root 权限
* 输入`cd /vol1/1000/` 进入用户文件夹根目录，`mkdir Compose` 创建 Compose 文件夹
* 输入`cd Compose` 进入 Compose 文件夹，并输入如下命令

```
wget https://gh.llkk.cc/https://raw.githubusercontent.com/ATaKi-Myt/Last_Three_Lazy_bag/refs/heads/main/Last_Three_Service_Package.sh
```

* 拉取完成，`bash Last_Three_Service_Package.sh` 运行脚本，选择服务 3 拉取 Compose\_Shop 脚本
* 输入解密密码进行解密，解密密码找作者免费获取
* 拉取完成，运行脚本，输入脚本密码，脚本密码找作者免费获取
* 选择系统，选择 Docker 安装即可
  
## 四、内置功能
### 1、检测是否为 root 权限运行
由于脚本运行需要 root 权限，系统会自动检测运行模式。若未处于 root 模式，将提示用户进入 root 模式，否则退出脚本。同时，系统支持直接引导用户进入 root 模式。
### 2、检测文件存在机制
下载完成后，系统自动检测文件是否存在。用户可选择重复下载或不重复下载。
### 3、自定义安装路径
执行 Compose.yml 文件时，系统自动读取文件内容，将路径替换为用户输入的自定义路径。
### 4、自定义容器端口
执行 Compose.yml 文件时，系统自动读取文件内容，将端口替换为用户输入的自定义端口。并且，系统支持容器多端口检测，会提示用户多端口更改的数量。
### 5、自动创建文件夹
执行 Compose.yml 文件时，系统自动读取文件内容，对于不存在的路径文件夹，优先执行创建操作，然后再运行 Compose.yml 文件。
### 6、自动检测 Docker Compose 是否安装
鉴于各大 Nas 系统在运行 docker compose 时版本存在差异，可能不适配脚本指令，故系统加入检测机制。但由于需要从 github 拉取安装包，此功能不适用于墙内用户，已移至服务包供用户手动检测。
## 五、更新日志
### v 1.0
此版本新增 46 个容器，以适配飞牛系统、绿联（新旧）、黑群晖系统。后续计划适配极空间及其他 Nas 系统。
### v 1.0.1
此版本增至 54 个容器，其中包括（babybuddy、clouddrive2、homebox、icloudpd、mediago、ollama、open-webui）以适配飞牛系统、绿联（新旧）、黑群晖系统。后续计划适配极空间及其他 Nas 系统。
## 六、作者信息
### 1、哔哩哔哩：[最后三人行](https://space.bilibili.com/3546844344879871?spm_id_from=333.1007.0.0)
### 2、作者博客：[最后三人博客](https://bk.010322.xyz/)
### 3、作者微信：M13051661743 (注明来意)
