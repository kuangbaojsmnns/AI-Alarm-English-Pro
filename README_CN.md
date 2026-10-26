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
│       │   ├── application/
│       │   ├── data/
│       │   ├── domain/
│       │   └── presentation/
│       ├── home/
│       │   ├── application/
│       │   ├── data/
│       │   ├── domain/
│       │   └── presentation/
│       ├── lessons/presentation/
│       ├── profile/presentation/
│       └── vocabulary/presentation/
├── analysis_options.yaml
└── pubspec.yaml
server/
├── app/
│   ├── main.py
│   └── api/routes.py
├── Dockerfile
└── requirements.txt
.github/workflows/ci.yml
```

客户端采用 **feature-first** 组织：每个业务模块独立维护页面与业务代码。闹钟模块提供了分层数据样例，Home 模块提供了后端版本 API 的联调样例。页面路由集中在 `app/router/app_router.dart`，全局主题在 `app/theme/`，通用组件与网络能力放在 `core/`。

更多模块边界和新增页面约定见 [app/ARCHITECTURE.md](app/ARCHITECTURE.md)。

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

Home 页调用 `GET /api/version` 并显示后端名称与版本；连接失败时可点击 Retry。其余课程、词汇和统计内容仍为演示数据。

默认 API 地址为 `http://localhost:8000/api`，配置位于 `app/lib/core/constants/app_constants.dart`。

## FastAPI 服务端

在仓库根目录创建虚拟环境并安装依赖：

```powershell
cd server
python -m venv .venv
.venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

从 `server/` 目录启动开发服务：

```bash
uvicorn app.main:app --reload
```

- 健康检查：`http://127.0.0.1:8000/api/health`
- 版本接口：`http://127.0.0.1:8000/api/version`

## Docker

从仓库根目录构建并运行服务端：

```bash
docker build -f server/Dockerfile -t ai-alarm-english-pro-api ./server
docker run --rm -p 8000:8000 ai-alarm-english-pro-api
```

容器使用 `uvicorn app.main:app --host 0.0.0.0 --port 8000` 启动。

## CI 与后续开发

GitHub Actions 会解析 Flutter 依赖、运行客户端静态分析，并安装 Python 依赖、编译检查服务端代码。后续可加入 SQLAlchemy 数据模型、Alembic 迁移、pytest 测试、持久化闹钟、课程 API 和真实 Windows 闹钟集成。
