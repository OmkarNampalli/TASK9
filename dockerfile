#Uses or downloads a base image maintained by dockerhub
FROM python:3.9-slim 
# Tells the container the working directory for our app
WORKDIR /app
# Copy the file names requirements.txt into working directory (.)
COPY requirements.txt .
# RUN is used to run a command in the container
RUN pip install --no-cache-dir -r requirements.txt
# copy app.py from this folder to containers working folder
COPY app.py .
# Expose or open the port 5000 of the container
EXPOSE 5000
# defining environment variables
ENV FLASK_APP=app.py
# run the following given commands in the shell/terminal
CMD [ "python","app.py" ]