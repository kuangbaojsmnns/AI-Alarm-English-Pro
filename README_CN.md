# AI Alarm English Pro

面向 Windows 的 AI 英语学习闹钟应用。客户端使用 **Flutter**，后端使用 **FastAPI**。

## Flutter 客户端结构

```text
app/lib/
├── app/                    # 应用、路由、主题
├── core/                   # API 客户端、配置、共享组件
└── features/
    ├── alarms/             # 闹钟实体、持久化仓库、状态与页面
    ├── chat/               # AI Chat 演示页面
    ├── home/               # 首页与版本接口
    ├── lessons/
    ├── profile/
    ├── settings/           # 后端/登录/OpenAI 状态
    └── vocabulary/
```

路由集中在 `app/router/app_router.dart`。更完整的模块约定见 [app/ARCHITECTURE.md](app/ARCHITECTURE.md)。

## 开发环境

- Flutter stable（Dart SDK 3.5 或更新版本）
- Python 3.12
- Docker（可选，用于构建服务端镜像）

## Flutter 客户端

```bash
cd app
flutter pub get
flutter run
```

默认 API 地址会按平台选择：

- Android 模拟器：`http://10.0.2.2:8000/api`
- Windows/macOS/Linux 桌面与 iOS 模拟器：`http://localhost:8000/api`

Android/iOS 真机请把 IP 换成开发电脑的局域网地址：

```bash
flutter run --dart-define=API_BASE_URL=http://192.168.1.25:8000/api
```

### M1.3 功能骨架

- **AI Chat**：从 Lessons 页面进入；会话列表、会话切换、新建会话、输入框和消息气泡均可交互。当前会话仅保存在运行内存中，回复由本地演示逻辑生成，尚未连接 OpenAI。
- **Settings**：Profile → App settings 中分组显示 API 在线状态、后端名称/版本、登录能力、OpenAI key 配置状态和 API Base URL；支持重新检测与复制地址。
- **Alarms**：用 `SharedPreferencesAsync` 在本地保存闹钟列表和开关；首次启动写入默认闹钟。此存储适合当前简单设置骨架，不承担关键闹钟定时任务。

登录尚未实现。OpenAI 状态只检查服务端是否存在非空 `OPENAI_API_KEY`，不验证 key 是否有效，也不会把 key 返回客户端。闹钟的系统定时触发和通知后续再接入。

## FastAPI 服务端

```powershell
cd server
python -m venv .venv
.venv\Scripts\Activate.ps1
pip install -r requirements.txt
Copy-Item .env.example .env
```

如需显示 OpenAI 配置状态为已配置，在本机 `server/.env` 中设置 `OPENAI_API_KEY`。此文件已被 Git 忽略，不要提交真实密钥。

从 `server/` 目录启动服务。绑定 `0.0.0.0` 后，局域网中的真机才能访问；也请允许防火墙通过本机端口：

```bash
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

- 健康检查：`http://127.0.0.1:8000/api/health`
- 版本接口：`http://127.0.0.1:8000/api/version`
- 设置页状态接口：`http://127.0.0.1:8000/api/status`

## Docker

从仓库根目录构建并运行服务端：

```bash
docker build -f server/Dockerfile -t ai-alarm-english-pro-api ./server
docker run --rm -p 8000:8000 --env-file server/.env ai-alarm-english-pro-api
```

`server/.dockerignore` 会排除本机 `.env`；密钥只在容器运行时传入。

## CI 与后续开发

GitHub Actions 会解析 Flutter 依赖、运行客户端静态分析，并安装 Python 依赖、编译检查服务端代码。下一步可接入 OpenAI 对话 API、实现身份认证，并增加可靠的操作系统闹钟与通知能力。
