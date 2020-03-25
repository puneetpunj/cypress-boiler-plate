export PERCY_TOKEN=<your percy token> 
# remove --spec all tests need to be executed
# npx cypress run --record --key 628bbf4f-987a-44a2-83dc-a5f690b1bf60 --spec "cypress/integration/examples/location.spec.js,cypress/integration/examples/aliasing.spec.js"
npx percy exec -- cypress run --record --key 628bbf4f-987a-44a2-83dc-a5f690b1bf60 --spec "cypress/integration/examples/location.spec.js,cypress/integration/examples/aliasing.spec.js"


#create new folder to store final report
mkdir -p execution-report

# merge all reports from repport folder and generate one json file
npx mochawesome-merge --reportDir reports/mochawesome-report > execution-report/report.json

# generate .html file from it and save it as detailed-report-<current timestamp>
outfile="detailed-report-$(date  "+%d-%m-%Y-%R")"
npx marge execution-report/*.json -f $outfile -o execution-report --overwrite false

# open file in google chrome immeditely on merging
# open -a "google chrome" "execution-report/$outfile.html"

# remove reports folder as it is not required anymore
rm -r -f reports