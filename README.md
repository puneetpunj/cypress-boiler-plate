# cyress-test-framework

cypress framework with docker, percy integration and inbuilt mochawesome reporting

### Prerequisite

Nodejs >8 must be installed (if not using docker)

## Installation

Run below command to install cypress package (use npm or yarn or any other node package manager)

```bash
npm install
```

Please use below command if above does not work

```bash
sudo npm install cypress --unsafe-perm=true --allow-root
```

## Cypress Test Runner Window

Once installation is completed successfully, run below command

```bash
npx cypress open
```

- This would open a cypress run window
- Click on any of the spec file to execute tests
- Identify Object using Cypress native object locator

## Headless Execution

#### To execute all specs headlessly

```bash
npx cypress run
```

#### To run specific spec

```bash
npx cypress run --spec "cypress/integration/mytests/jetstar.spec.js,cypress/integration/examples/location.spec.js"
```

#### Local Execution

Use below command to run locally. This is a custom shell file with commands to run specific or all spec files and generate mochawesome report.

```bash
npm run execute-tests
```

#### Screenshots

Cypress automatically takes screenshot on every failure. But this can be turned off using cypress.json configuration (`jsscreenshotOnRunFailure: false`)
Screenshots will be saved automated at cypress/screenshots directory

#### Video Recording

Headless execution automatically store the video of execution (`jsvideoUploadOnPasses=false`)
Videos will be saved automated at cypress/videos directory

<p>
    <img src="/images/Video recording.png"/>
</p>

#### Reporting

All mocha specific reports are available in Cypress. To list few :

- Mochawesome
- Junit
- Good-html-reporter

This framework is setup to generate mochawesome report but can be enahnced to add other report types, as needed.

<p>
    <img src="/images/report snapshot.png"/>
</p>

## Cypress Dashboard

The Cypress Dashboard is a service that gives you access to recorded tests - typically when running Cypress tests from your CI provider.

The Dashboard provides you insight into what happened when your tests ran.

More details on Cypress Website - [Cypress Dashboard Features](https://docs.cypress.io/guides/dashboard/introduction.html#Features)

<p>
    <img src="/images/Cypress Dashboard.png"/>
</p>

### Record Execution

```bash
npx cypress run --record --key 3d09d5fa-3166-47ed-9ae4-9569c17eff74 --spec "cypress/integration/examples/jetstar.spec.js,cypress/integration/examples/location.spec.js"
```

- Output
- Screenshot
- Video

### Github Integration

- Go to Organisation> Integrations
- Select repository contains Cypress tests
- Execute test using above "Record Execution" option
- Once execution result is posted to Cypress Dashboard, it would be synched with git commit in near real time

<p>
    <img src="/images/github-snapshot.png"/>
</p>

## CICD Integration

dockerfile is added in the framework

Navigate to framework directory and execute below commands:

```bash
docker build -t cypressimage .
docker run -i -v "`pwd`/cypress":/cypress cypressimage
```

## Working with XHR

https://docs.cypress.io/guides/guides/network-requests.html

Sample Code -

```js
cy.server();
cy.route("/en-AU/apiservices/flightschedulev2/getflightschedules", [
  { id: 1, name: "Pat" }
]).as("getFlightSchedules");
```

- cy.server is to create a mock server

- cy.route is to create new route.

  - Default method is GET
  - specify endpoint to be tested
  - There is an option to mock response for this XHR (second argument above)
  - Create an alias and use it for subsequent tests

## Visual Testing

Install Percy

```bash
npm i @percy/cypress
```

Cypress Configuration
Add below code in cypress/support/command.js

```js
import "@percy/cypress";
```

In cypress/plugins/index.js

```js
let percyHealthCheck = require("@percy/cypress/task");

module.exports = (on, config) => {
  on("task", percyHealthCheck);
};
```

Token Configuration

This is required to push screenshots to Percy cloud. Execute below shell command to set Percy Token

```bash
export PERCY_TOKEN=71ab8ae46ac2a6de43666c0edf9fa96b2424ede2047330be4b96c8cb042e1f4b
```

Capture Screenshot
Go to respective test and add below code for screenshot capture and percy's comparison

```js
cy.percySnapshot("jetstar home page");
```

Note: change the snapshot name and it must be unique for every screenshot

Execution
Execute cypress tests using

```bash
percy exec -- cypress run
```

### Destroy Docker Containers and Images

```bash
sh destroy-containers and images.sh
```

This is to destory all the Docker images and containers conveniently. it is not specially related to cypress framework but useful to manage docker images/containers
