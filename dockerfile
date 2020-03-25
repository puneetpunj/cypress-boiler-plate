FROM cypress/browsers:chrome67

RUN npm i cypress
COPY package.json .
RUN npm i

RUN mkdir -p mnt

COPY . mnt/

CMD cd mnt && npm run cy:run