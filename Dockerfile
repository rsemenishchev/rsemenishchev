# Использовать официальный образ python из хаба docker
FROM python:3.10.13-bullseye
# предотвращает копирование файлов pyc в контейнер
ENV PYTHONDONTWRITEBYTECODE 1
# Обеспечивает протоколирование вывода python в терминале контейнера
ENV PYTHONUNBUFFERED 1
RUN apt-get update \
  # зависимости для сборки пакетов Python
  && apt-get install -y build-essential \
  # зависимости psycopg2
  && apt-get install -y libpq-dev \
  # Зависимости перевода
  && apt-get install -y gettext \
  # очистка неиспользуемых файлов
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && rm -rf /var/lib/apt/lists/*
# Скопировать файл 'requirements.txt' из локального контекста сборки в файловую систему контейнера.
COPY ./requirements.txt /requirements.txt
# Установить зависимости python
RUN pip install -r /requirements.txt --no-cache-dir
# Установить рабочий каталог
WORKDIR /app
# Запустите программу Uvicorn для запуска веб-приложения на языке Python
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]