# This is Dockerfile for recommendation service which is coded in python language

### Stage-1 ###

FROM python:3.12-slim-bookworm AS builder
WORKDIR usr/src/app

COPY requirements.txt ./

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

COPY . .
ENV RECOMMENDATION_PORT 1010 
# ENV are missing in this but at the time of pod creation all the evnironments will be passed and if name key [ it will override the variable in Dockerfile ]
ENTRYPOINT ["python", "recommendation_server.py"]
