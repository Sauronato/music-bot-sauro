# Etapa de construcción
FROM ubuntu:latest

RUN apt-get update && apt-get install -y wget

# Instala mongodb
RUN wget https://repo.mongodb.org/apt/ubuntu/dists/jammy/mongodb-org/7.0/multiverse/binary-amd64/mongodb-org-server_7.0.7_amd64.deb \
    && apt-get install -y ./mongodb-org-server_7.0.7_amd64.deb \
    && rm mongodb-org-server_7.0.7_amd64.deb

# Instala Git, FFmpeg y otras dependencias necesarias
RUN apt-get install -y git ffmpeg nodejs redis-server

RUN npm install -g npm@latest
# Instalar pnpm
RUN npm install -g pnpm

RUN mkdir /home/container/

# Clona el repositorio de GitHub
RUN git clone https://github.com/Sauronato/music-bot-sauro.git /home/container/

# Cambia al directorio del repositorio
WORKDIR /home/container/

# Instala los requisitos
RUN pnpm install --frozen-lockfile 
# Etapa de ejecución
RUN