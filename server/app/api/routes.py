from fastapi import APIRouter, Request

from app.core.settings import settings

router = APIRouter()


@router.get("/health", tags=["health"])
async def health_check() -> dict[str, str]:
    return {"status": "ok"}


@router.get("/version", tags=["meta"])
async def get_version(request: Request) -> dict[str, str]:
    return {
        "name": request.app.title,
        "version": request.app.version,
    }


@router.get("/status", tags=["meta"])
async def get_system_status(request: Request) -> dict[str, object]:
    return {
        "backend": {
            "status": "online",
            "name": request.app.title,
            "version": request.app.version,
        },
        "authentication": {
            "enabled": False,
            "authenticated": False,
        },
        "openai": {
            "configured": bool(
                settings.openai_api_key and settings.openai_api_key.strip()
            ),
        },
    }
