npx cypress run --record --key 4ddf1d77-d5aa-4146-a2bd-1d64dd8ad70c --spec "cypress/integration/mytests/jetstar.spec.js,cypress/integration/examples/location.spec.js"
# npx cypress run --spec "cypress/integration/mytests/jetstar.spec.js,cypress/integration/examples/location.spec.js"
mkdir execution-report
npx mochawesome-merge --reportDir cypress/reports/mochawesome-report > execution-report/report.json
npx marge execution-report/*.json -f detailed-report -o execution-report
# open -a "google chrome" execution-report/detailed-report.html
rm -r -f cypress/reports