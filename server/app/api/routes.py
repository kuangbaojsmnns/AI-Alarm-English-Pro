from fastapi import APIRouter, Request

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
