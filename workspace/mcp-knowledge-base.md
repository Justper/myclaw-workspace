# Model Context Protocol (MCP) 知识库

> 最后更新: 2025-04-09
> 来源: https://modelcontextprotocol.io

---

## 什么是 MCP？

**Model Context Protocol (MCP)** 是一个开放协议，旨在让 AI 应用能够安全地访问外部数据和工具。它是 AI 领域的"USB-C 接口"——就像 USB-C 为设备连接提供了标准化方式一样，MCP 为 AI 应用与外部系统的连接提供了标准化方式。

> 核心定位：不关心 AI 如何使用 LLM，只专注于**上下文交换**

---

## MCP 架构概述

### 核心参与者

| 角色 | 说明 | 示例 |
|------|------|------|
| **MCP Host** | AI 应用，协调管理多个 MCP 客户端 | Claude Desktop, Claude Code, VS Code |
| **MCP Client** | 协议组件，与单个 MCP Server 保持连接 | 运行时对象 |
| **MCP Server** | 提供上下文数据的程序 | Filesystem Server, Sentry Server |

### 架构图

```
┌─────────────────────────────────────────────────────┐
│                    MCP Host                         │
│                   (AI 应用)                         │
│  ┌─────────────────────────────────────────────┐   │
│  │              MCP Client 1                   │   │
│  │     ──────────── connected to ───────────  │   │
│  └─────────────────────────────────────────────┘   │
│  ┌─────────────────────────────────────────────┐   │
│  │              MCP Client 2                   │   │
│  │     ──────────── connected to ───────────  │   │
│  └─────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────┘
              │                      │
              ▼                      ▼
    ┌──────────────────┐   ┌──────────────────────┐
    │   MCP Server 1    │   │    MCP Server 2      │
    │   (本地 STDIO)    │   │   (远程 HTTP)        │
    └──────────────────┘   └──────────────────────┘
```

---

## 协议分层

### 两层架构

1. **Data Layer (数据层)**
   - 基于 JSON-RPC 2.0 的交换协议
   - 定义消息结构和语义
   - 包括生命周期管理、核心原语

2. **Transport Layer (传输层)**
   - 通信机制和认证
   - 消息 framing
   - 安全通信

### 支持的传输方式

| 传输方式 | 说明 | 适用场景 |
|----------|------|----------|
| **STDIO** | 标准输入/输出流 | 本地进程通信 |
| **Streamable HTTP** | HTTP POST + SSE | 远程服务器，支持 OAuth 认证 |

---

## 核心原语 (Primitives)

### 服务器端原语

#### 1. Tools (工具)
- AI 模型可以**主动调用**的函数
- 执行操作：文件操作、API 调用、数据库查询
- 需要用户授权才能执行

**协议方法：**
| 方法 | 用途 |
|------|------|
| `tools/list` | 发现可用的工具 |
| `tools/call` | 执行特定工具 |

**工具定义示例：**
```json
{
  "name": "searchFlights",
  "description": "Search for available flights",
  "inputSchema": {
    "type": "object",
    "properties": {
      "origin": { "type": "string", "description": "Departure city" },
      "destination": { "type": "string", "description": "Arrival city" },
      "date": { "type": "string", "format": "date", "description": "Travel date" }
    },
    "required": ["origin", "destination", "date"]
  }
}
```

#### 2. Resources (资源)
- **被动**数据源，提供上下文信息
- 读取文件内容、数据库记录、API 响应
- 应用驱动，可主动获取

**协议方法：**
| 方法 | 用途 |
|------|------|
| `resources/list` | 列出可用资源 |
| `resources/templates/list` | 发现资源模板 |
| `resources/read` | 读取资源内容 |
| `resources/subscribe` | 监控资源变化 |

**资源 URI 示例：**
- 直接资源: `calendar://events/2024`
- 模板资源: `weather://forecast/{city}/{date}`

#### 3. Prompts (提示)
- 可复用的模板，帮助结构化与 LLM 的交互
- 用户**主动触发**，非自动执行

**协议方法：**
| 方法 | 用途 |
|------|------|
| `prompts/list` | 发现可用提示 |
| `prompts/get` | 获取提示详情 |

---

### 客户端原语（服务端可请求）

#### 1. Sampling (采样)
- 服务端可以请求 LLM 完成
- 无需嵌入 AI SDK，保持模型无关性

#### 2. Elicitation (引导)
- 服务端请求用户补充信息
- 动态工作流，灵活获取输入

#### 3. Logging (日志)
- 服务端发送日志到客户端
- 用于调试和监控

---

## 生命周期管理

### 初始化握手

```
Client                              Server
  │                                  │
  │─── initialize request ──────────▶│
  │    protocolVersion: "2025-06-18" │
  │    capabilities: {...}          │
  │    clientInfo: {...}             │
  │◅─── initialize response ────────│
  │    protocolVersion: "2025-06-18"│
  │    capabilities: {...}          │
  │    serverInfo: {...}             │
  │                                  │
  │─── notifications/initialized ──▶│
```

**关键要素：**
1. **协议版本协商** - 确保兼容性
2. **能力发现** - 双方声明支持的特性
3. **身份交换** - 用于调试

---

## 通信流程示例

### 完整交互流程

1. **初始化**
   - 客户端发送 `initialize`
   - 服务器响应并声明能力
   - 客户端发送 `notifications/initialized`

2. **工具发现**
   ```json
   {
     "jsonrpc": "2.0",
     "id": 2,
     "method": "tools/list"
   }
   ```

3. **工具执行**
   ```json
   {
     "jsonrpc": "2.0",
     "id": 3,
     "method": "tools/call",
     "params": {
       "name": "weather_current",
       "arguments": {
         "location": "San Francisco",
         "units": "imperial"
       }
     }
   }
   ```

4. **实时通知**
   - 服务器可发送 `notifications/tools/list_changed`
   - 客户端收到后刷新工具列表

---

## 远程 MCP 服务器

### 连接配置

```json
{
  "mcpServers": {
    "sentry": {
      "url": "https://sentry.io/mcp",
      "auth": "Bearer YOUR_TOKEN"
    }
  }
}
```

### 认证方式

- Bearer tokens
- API keys
- Custom headers
- OAuth (推荐)

---

## SDK 支持

| 语言 | 级别 | 仓库 |
|------|------|------|
| TypeScript | Tier 1 | modelcontextprotocol/typescript-sdk |
| Python | Tier 1 | modelcontextprotocol/python-sdk |
| C# | Tier 1 | modelcontextprotocol/csharp-sdk |
| Go | Tier 1 | modelcontextprotocol/go-sdk |
| Java | Tier 2 | modelcontextprotocol/java-sdk |
| Rust | Tier 2 | modelcontextprotocol/rust-sdk |
| Ruby | Tier 3 | modelcontextprotocol/ruby-sdk |
| Swift | Tier 3 | modelcontextprotocol/swift-sdk |
| Kotlin | TBD | modelcontextprotocol/kotlin-sdk |

---

## 官方服务器示例

### 本地服务器
- **Filesystem Server** - 文件系统访问
- **GitHub Server** - GitHub API 集成
- **SQLite Server** - 数据库查询

### 远程服务器
- **Sentry MCP Server** - 错误追踪
- **Slack MCP Server** - 团队通信

---

## 常见用例

### 1. 增强 AI 上下文
- 让 AI 访问文件、数据库、API
- 提供实时数据而非训练数据

### 2. 工具执行
- AI 可以执行实际操作
- 搜索航班、发送邮件、创建日历事件

### 3. 自动化工作流
- 组合多个服务器能力
- "Plan a vacation" = 天气 + 航班 + 酒店 + 日历

---

## 安全注意事项

### STDIO 服务器
- **禁止**使用 `print()` 写入 stdout
- 会破坏 JSON-RPC 消息
- 使用 `stderr` 或日志文件

### 本地服务器
- 可访问本地文件系统和进程
- 需要合适的权限配置
- Roots 定义文件系统边界（指导性，非强制）

---

## 与传统 AI Plugin 的区别

| 特性 | MCP | 传统 Plugin |
|------|-----|-------------|
| 标准化 | ✅ 开放协议 | ❌ 各自定义 |
| 可组合性 | ✅ 多服务器协作 | ❌ 单一集成 |
| 双向通信 | ✅ 服务器可请求客户端 | ❌ 单向调用 |
| 实时更新 | ✅ 通知机制 | ❌ 轮询 |
| 模型无关 | ✅ 协议解耦 | ❌ 特定模型 |

---

## 参考资源

- [MCP 官网](https://modelcontextprotocol.io)
- [MCP 规范](https://modelcontextprotocol.io/specification/latest)
- [GitHub](https://github.com/modelcontextprotocol)
- [Servers 仓库](https://github.com/modelcontextprotocol/servers)
- [Example Clients](https://modelcontextprotocol.io/clients)
- [Example Servers](https://modelcontextprotocol.io/examples)