require("@rails/ujs").start()
import 'bootstrap/dist/js/bootstrap'
import '@fortawesome/fontawesome-free/js/all'
import 'ekko-lightbox/dist/ekko-lightbox'

import '../styles/application'

const images = require.context('../images', true)
