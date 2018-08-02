Phone = require('./Phone')

argentina = require('./countries/ARG')
bolivia   = require('./countries/BOL')
brazil    = require('./countries/BRA')
canada    = require('./countries/CAN')
chile     = require('./countries/CHL')
colombia  = require('./countries/COL')
costarica = require('./countries/CRI')
ecuador   = require('./countries/ECU')
spain     = require('./countries/ESP')
gbr       = require('./countries/GBR')
guatemala = require('./countries/GTM')
korea     = require('./countries/KOR')
mexico    = require('./countries/MEX')
panama    = require('./countries/PAN')
peru      = require('./countries/PER')
paraguay  = require('./countries/PRY')
uruguay   = require('./countries/URY')
usa       = require('./countries/USA')
venezuela = require('./countries/VEN')

window.vtex = window.vtex || {}
window.vtex.phone = Phone

module.exports = Phone
