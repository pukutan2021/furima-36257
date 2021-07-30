function count (){
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
    const tax = 0.1
    addTaxDom.innerHTML = `${Math.floor(inputValue * tax)}`;
    const profitDom = document.getElementById("profit");
    profitDom.innerHTML = `${inputValue - inputValue * tax}`;
  });
};

window.addEventListener('load', count);