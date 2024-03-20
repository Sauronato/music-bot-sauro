# Etapa de construcción
FROM ubuntu:latest


RUN apt-get update && apt-get install -y wget curl && adduser --disabled-password --home /home/container --uid 998 container



# Instala mongodb
RUN wget https://repo.mongodb.org/apt/ubuntu/dists/jammy/mongodb-org/7.0/multiverse/binary-amd64/mongodb-org-server_7.0.7_amd64.deb \
    && apt-get install -y ./mongodb-org-server_7.0.7_amd64.deb \
    && rm mongodb-org-server_7.0.7_amd64.deb

# Instala Git, FFmpeg y otras dependencias necesarias
RUN apt-get install -y git ffmpeg redis-server 

# Cambia al directorio del repositorio
WORKDIR /home/container/

ENV  USER=container HOME=/home/container
USER container

RUN touch /home/container/.bashrc
# Clona el repositorio de GitHub
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash \
    && export NVM_DIR="$HOME/.nvm" \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" \
    && nvm install node && npm install -g npm@latest && npm install -g pnpm 

    

# CMD ['/bin/bash',"/start.sh"]