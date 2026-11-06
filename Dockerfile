FROM ghcr.io/osgeo/gdal:ubuntu-small-latest

EXPOSE 3000

ENV NODE_VERSION=20.10.0

# RUN apk add --update nodejs npm
# RUN apk add --update npm

RUN apt-get update
RUN apt install -y curl
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"
RUN node --version
RUN npm --version

WORKDIR /app/


COPY package.json /app/
RUN npm install

COPY . .

CMD ["npm", "run", "start"]

