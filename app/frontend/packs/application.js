require("@rails/ujs").start()
import 'bootstrap/dist/js/bootstrap'
import '@fortawesome/fontawesome-free/js/all'
import 'ekko-lightbox/dist/ekko-lightbox'

import '../styles/application'

const images = require.context('../images', true)

$(document).on('click', '[data-toggle="lightbox"]', function(event) {
  event.preventDefault();
  $(this).ekkoLightbox();
});
