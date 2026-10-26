# AI Alarm English Pro

面向 Windows 的 AI 英语学习闹钟应用。客户端使用 **Flutter**，后端使用 **FastAPI**；仓库目前提供基础项目结构和健康检查接口。

## 项目结构

```text
app/                    # Flutter 客户端
server/
├── app/
│   ├── main.py          # FastAPI 应用入口
│   └── api/
│       └── routes.py    # API 路由（含健康检查）
├── Dockerfile
└── requirements.txt
.github/workflows/ci.yml # Flutter 与 Python CI
```

后端以 `server/app` 为 Python 包根目录，按职责扩展 `api/`、`models/`、`core/`、`db/` 等模块。

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

目前仅准备了 Flutter 包清单；应用页面和入口仍待开发。

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

健康检查地址：`http://127.0.0.1:8000/api/health`。

## Docker

从仓库根目录构建并运行服务端：

```bash
docker build -f server/Dockerfile -t ai-alarm-english-pro-api ./server
docker run --rm -p 8000:8000 ai-alarm-english-pro-api
```

容器使用 `uvicorn app.main:app --host 0.0.0.0 --port 8000` 启动。

## CI 与后续开发

GitHub Actions 会解析 Flutter 依赖、在客户端源码存在时运行静态分析和测试，并安装 Python 依赖、编译检查服务端代码。后续可在此基础上加入 SQLAlchemy 数据模型、Alembic 迁移、pytest 测试、配置管理以及课程 API。
