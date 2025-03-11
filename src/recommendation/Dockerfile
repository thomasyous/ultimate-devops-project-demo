FROM python:3.12-bullseye AS base 

WORKDIR /usr/src/app 

COPY requirements.txt ./ 

RUN pip install --upgrade pip
# A good practice is to upgrade the pip for 
# the very first time before using it 

RUN pip install -r requirements.txt 

COPY . . 

ENTRYPOINT ["python", "recommendation_server.py"]
# In python we don't have to create the binary 
# We can directly execute the program. 
# In the ENTRYPOINT we have the command to execute the python program 




