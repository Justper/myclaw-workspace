#!/bin/bash

# OpenClaw 备份脚本
# 推送到 GitHub 远程分支

cd /root/.openclaw

# 检查是否有变更
if [[ -n $(git status --porcelain) ]]; then
    # 添加所有变更文件
    git add -A
    
    # 提交变更（包含日期时间）
    DATE=$(date "+%Y-%m-%d %H:%M")
    git commit -m "backup: $DATE"
    
    # 推送到远程分支
    git push origin my_personal_assistant
    
    echo "Backup completed at $DATE"
else
    echo "No changes to backup at $(date)"
fi
