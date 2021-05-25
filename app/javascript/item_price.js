function post (){
  const priceForm = document.getElementById("item-price");
  priceForm.addEventListener("input", () => {
    const currentPrice = priceForm.value;
    const addTaxPrice = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");
    addTaxPrice.innerHTML = Math.floor(currentPrice * 0.1)
    profit.innerHTML = Math.floor(currentPrice * 0.9)
  });
 };
 
 window.addEventListener('load', post);