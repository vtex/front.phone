Phone = require('./Phone')

argentina = require('./countries/ARG')
bolivia   = require('./countries/BOL')
brazil    = require('./countries/BRA')
chile     = require('./countries/CHL')
canada    = require('./countries/CAN')
colombia  = require('./countries/COL')
ecuador   = require('./countries/ECU')
guatemala = require('./countries/GTM')
gbr       = require('./countries/GBR')
mexico    = require('./countries/MEX')
paraguay  = require('./countries/PRY')
peru      = require('./countries/PER')
uruguay   = require('./countries/URY')
usa       = require('./countries/USA')

window.vtex = window.vtex || {}
window.vtex.phone = Phone

module.exports = Phone
