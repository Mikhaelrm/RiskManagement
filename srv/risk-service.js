const cds = require('@sap/cds')

/**
 * Implementation for Risk Management service defined in ./risk-service.cds
 */
module.exports = cds.service.impl(async function() {

    this.after('READ', 'Risks', risksData => {
        const risks = Array.isArray(risksData) ? risksData : [risksData];
        risks.forEach(risk => {
            if (risk.impact >= 100000) {
                risk.criticality = 1;
            } else {
                risk.criticality = 2;
            }
        });
    });

});

module.exports = cds.service.impl(async function () {

    //these are the entities from address-manager-service.cds file
    const { BusinessPartners } = this.entities;

    //cds will connect to the external service API_BUSINESS_PARTNER
    //which is declared in package.json in the cds requires section
    const service = await cds.connect.to('API_BUSINESS_PARTNER');

    //this event handler is triggered when we call
    //GET http://localhost:4004/address-manager/BusinessPartners
    this.on('READ', BusinessPartners, async (req) => {
        req.query.where("LastName <> '' and FirstName <> '' ");

        return await service.transaction(req).send({
            query: req.query,
            headers: {
                apikey: process.env.apikey,
            },
        });
    });
});
