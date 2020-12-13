// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
import { initMapbox } from '../plugins/init_mapbox';

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';
import { initStarRating } from '../plugins/init_star_rating';


const deliveryRadio = document.getElementById('order_delivery_delivery');
const selfCollectRadio = document.getElementById('order_delivery_self-collection');

const deliveryDisplay = () => {
  const selfCollectMsg = document.getElementById('self_collect_address');
  const deliveryAddress = document.querySelector('.order_address');
  if (deliveryRadio.checked) {
    selfCollectMsg.classList.add("d-none");
    deliveryAddress.classList.remove("d-none");
  } else if (selfCollectRadio.checked) {
    selfCollectMsg.classList.remove("d-none");
    deliveryAddress.classList.add("d-none");
  }
}

const isDelivery = () => {
  deliveryRadio.addEventListener('click', deliveryDisplay);
  selfCollectRadio.addEventListener('click', deliveryDisplay);
}

document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // initSelect2();
  initMapbox();
  initStarRating();
  deliveryDisplay();
  isDelivery();
});
