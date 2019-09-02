/// <reference types="Cypress" />
require('../../plugins/index')
describe('My First Test', function () {
    it('Visits the Jetstar webiste and login', function () {

        cy.server();
        cy.route('/en-AU/apiservices/flightschedulev2/getflightschedules', [{ id: 1, name: 'Pat' }]).as('getFlightSchedules')

        cy.visit('https://www.jetstar.com/');
        cy.percySnapshot('jetstar home page');

        cy.fixture('punj').as('credentials')
        cy.get('.mainmenu__global-login-cta').click()

        cy.get('.j-button--primary')
            .contains('Sign in').click({ force: true });

        cy.get('@credentials').then((user) => {
            cy.get('#input-7456722').type(user.username)
        })

    })
})