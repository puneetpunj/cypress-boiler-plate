FROM cypress/browsers:node12.14.1-chrome83-ff77

RUN npm i cypress
COPY package.json .
RUN npm i

RUN mkdir -p mnt

COPY . mnt/

CMD cd mnt && npm run cy:run
