# AI Alarm English Pro

面向 Windows 的 AI 英语学习闹钟应用。项目计划采用 **Flutter** 构建客户端、**FastAPI** 提供后端 API；当前仓库正在搭建跨端与服务端开发基础。

## 项目结构

- `app/`：Flutter 客户端
- `server/`：FastAPI 服务端与 Docker 镜像配置
- `.github/workflows/ci.yml`：Flutter 与 Python 依赖检查的 GitHub Actions 工作流

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

```bash
cd server
python -m venv .venv
# Windows PowerShell
.venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

服务端 API 入口尚未实现。后续添加 `server/main.py` 并导出 FastAPI 实例 `app` 后，可在 `server/` 目录启动：

```bash
uvicorn main:app --reload
```

Docker 镜像同样以 `main:app` 为启动目标；API 入口完成后，在仓库根目录构建并运行：

```bash
docker build -f server/Dockerfile -t ai-alarm-english-pro-api ./server
docker run --rm -p 8000:8000 ai-alarm-english-pro-api
```

## CI

GitHub Actions 会解析 Flutter 依赖、在客户端源码存在时运行静态分析和测试，并安装 Python 依赖、编译检查服务端 Python 文件。当前这些检查为新项目骨架提供基础门禁；随着应用代码加入，应补充有意义的客户端与 API 测试。

## 后续开发方向

1. 建立 Flutter 应用入口、导航与闹钟/课程界面。
2. 实现 FastAPI 健康检查、配置管理与课程 API。
3. 设计用户、闹钟、学习进度的数据模型及持久化方案。
4. 接入语音播放、AI 课程生成与 Windows 闹钟/通知能力。
