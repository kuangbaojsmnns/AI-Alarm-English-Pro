# AI Alarm English Pro

面向 Windows 的 AI 英语学习闹钟应用。客户端使用 **Flutter**，后端使用 **FastAPI**。

## 项目结构

```text
app/
├── lib/
│   ├── main.dart
│   ├── app/
│   │   ├── app.dart
│   │   ├── router/
│   │   └── theme/
│   ├── core/
│   │   ├── constants/
│   │   ├── errors/
│   │   ├── network/
│   │   └── widgets/
│   └── features/
│       ├── alarms/
│       ├── home/
│       ├── lessons/
│       ├── profile/
│       ├── settings/
│       └── vocabulary/
├── analysis_options.yaml
└── pubspec.yaml
server/
├── app/
│   ├── api/
│   ├── core/
│   └── main.py
├── .env.example
├── Dockerfile
└── requirements.txt
.github/workflows/ci.yml
```

客户端采用 **feature-first** 组织：每个业务模块独立维护页面与业务代码。页面路由集中在 `app/router/app_router.dart`，全局主题在 `app/theme/`，通用组件与网络能力放在 `core/`。更多模块边界见 [app/ARCHITECTURE.md](app/ARCHITECTURE.md)。

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

Android/iOS 真机请将下面示例中的 IP 替换为开发电脑在同一局域网中的地址：

```bash
flutter run --dart-define=API_BASE_URL=http://192.168.1.25:8000/api
```

Home 页调用 `GET /api/version`；Profile → App settings 可刷新查看后端状态、后端版本、登录状态和 OpenAI 配置状态。登录能力当前尚未接入。客户端只收到 OpenAI key 是否配置的布尔值，不会收到密钥。

## FastAPI 服务端

```powershell
cd server
python -m venv .venv
.venv\Scripts\Activate.ps1
pip install -r requirements.txt
Copy-Item .env.example .env
```

如需启用 OpenAI 功能，在本机 `server/.env` 中设置 `OPENAI_API_KEY`。此文件已被 Git 忽略，不要提交真实密钥。

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
docker run --rm -p 8000:8000 --env OPENAI_API_KEY=<your-key> ai-alarm-english-pro-api
```

容器使用 `uvicorn app.main:app --host 0.0.0.0 --port 8000` 启动。

## CI 与后续开发

GitHub Actions 会解析 Flutter 依赖、运行客户端静态分析，并安装 Python 依赖、编译检查服务端代码。后续可加入 SQLAlchemy 数据模型、Alembic 迁移、pytest 测试、持久化闹钟、课程 API 和真实 Windows 闹钟集成。
