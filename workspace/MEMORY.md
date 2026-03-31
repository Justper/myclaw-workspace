# MEMORY.md - Your Long-Term Memory

## 学习记录
- 2026-03-31：《代码整洁之道》第1-3章（让小智学习，用于答疑解惑和制定学习计划）

---

## 注意事项
- 小智让我学习某本书后，要记录下来，学习目的是：为我答疑解惑和帮我制定学习计划

---

## 2026-03-25 教训：修复 Cron 消息推送失败

### 问题
AI每日资讯 cron 任务执行后无法发送到钉钉，提示 `Unknown target "heartbeat"`

### 错误尝试
1. **添加不存在的配置键** ❌
   - 尝试添加 `defaultMessageTarget: "user:xxx"`
   - 结果：配置验证失败，gateway 无法启动
   - 修复：`openclaw doctor --fix` 移除无效键

2. **添加错误的 heartbeat target** ❌
   - 尝试添加 `agents.defaults.heartbeat.target: "user:xxx"`
   - 结果：`unknown heartbeat target: user:xxx`
   - 原因：DingTalk heartbeat target 只接受 channel id（如 `dingtalk`），不接受 `user:` 格式

### 正确解决方案
使用 cron job 自带的 delivery 参数：
```bash
openclaw cron add --name "AI每日资讯" \
  --cron "0 9 * * *" \
  --message "搜集AI资讯" \
  --session isolated \
  --channel dingtalk \
  --to "user:3245006901-1174885266" \
  --announce
```

关键点：
- `--session isolated` + `--announce` 让任务完成后主动推送
- `--channel dingtalk --to user:xxx` 明确发送目标和渠道