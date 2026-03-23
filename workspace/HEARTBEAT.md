# HEARTBEAT.md

# Keep this file empty (or with only comments) to skip heartbeat API calls.

# Add tasks below when you want the agent to check something periodically.

## 定时任务

### 每日备份（每天 23:00）
- 当收到 "backup-openclaw" 系统事件时
- 执行备份脚本：/root/.openclaw/workspace/scripts/backup-openclaw.sh
- 推送变更到 GitHub 远程分支

### AI 资讯推送（每天 9:00）
- 当收到 "搜集AI资讯" 系统事件时
- 搜索 AI 前沿资讯
- 整理 5-10 条，附带原文链接
- 发送到钉钉用户
