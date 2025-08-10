FROM python:3.12-slim AS base

WORKDIR /usr/src/app/

COPY requirements.txt ./

RUN pip install -r requirements.txt


COPY . .

ENV RECOMMENDATION_PORT 1010

CMD ["python", "recommendation_server.py"]
