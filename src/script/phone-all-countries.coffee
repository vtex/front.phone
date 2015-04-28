Phone = require('./Phone')

argentina = require('./countries/argentina')
brazil    = require('./countries/brazil')
chile     = require('./countries/chile')
colombia  = require('./countries/colombia')
ecuador   = require('./countries/ecuador')
gbr       = require('./countries/gbr')
mexico    = require('./countries/mexico')
paraguay  = require('./countries/paraguay')
peru      = require('./countries/peru')
uruguay   = require('./countries/uruguay')
usa       = require('./countries/usa')

window.vtex = window.vtex || {}
window.vtex.phone = Phone

module.exports = Phone