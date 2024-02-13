# Импортируем класс FastAPI из фреймворка FastAPI
from fastapi import FastAPI
# Импорт add_pagination
from fastapi_pagination import add_pagination
# Импорт 'router' из модуля 'app.api.v1.api'
from app.api.v1.api import router
# Импорт объекта 'settings' из модуля 'app.core.settings'
from app.core.settings import settings
# Создаем экземпляр приложения FastAPI
# - 'title' устанавливается в название проекта из 'settings'
# - 'openapi_url' задает URL для документации по OpenAPI
app = FastAPI(
    title=settings.PROJECT_NAME,
    openapi_url=f"{settings.API_V1_STR}/openapi.json"
)
# Добавить необходимые параметры пагинации во все маршруты, использующие paginate
add_pagination(app)
# Включите "маршрутизатор" (содержащий маршруты API) в приложение FastAPI
app.include_router(router)