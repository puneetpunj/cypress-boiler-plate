FROM cypress/browsers:chrome67

COPY package.json .
RUN npm install cypress --unsafe-perm=true --allow-root
RUN npm i


COPY cypress.json .
COPY cypressrunner.sh cypressrunner.sh
COPY execution-report execution-report

# RUN $(npm bin)/cypress

CMD npm run execute-tests
# CMD  ls -la