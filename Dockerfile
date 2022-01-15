FROM python:3.8-slim-buster

RUN apt-get update && apt-get install -y git python3-dev gcc \
    && rm -rf /var/lib/apt/lists/*


COPY requirements.txt .

RUN pip install --upgrade -r requirements.txt
RUN pip uninstall keras -y
RUN pip install keras==2.6.0
RUN apt-get update && apt-get install -y python3-opencv
RUN pip install opencv-python
COPY app app/

RUN python app/server.py

EXPOSE 8080

CMD ["python", "app/server.py", "serve"]
