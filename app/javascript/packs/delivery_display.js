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

deliveryDisplay();
isDelivery();