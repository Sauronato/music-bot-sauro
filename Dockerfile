# Etapa de construcción
FROM ubuntu:latest

RUN adduser --disabled-password container
RUN usermod -aG sudo container
RUN groupadd -g 998 pterodactyl

RUN apt-get update && apt-get install -y wget curl



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

# Clona el repositorio de GitHub
RUN git clone https://github.com/Sauronato/music-bot-sauro.git ~/tmpr/.

RUN  mv ~/tmpr/music-bot-sauro/* ~/.
RUN rm -rf ~/tmpr

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash \
    && export NVM_DIR="$HOME/.nvm" \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" \
    && nvm install node && npm install -g npm@latest && npm install -g pnpm && pnpm install --frozen-lockfile

