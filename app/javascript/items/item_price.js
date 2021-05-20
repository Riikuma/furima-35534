window.addEventListener('load', () => {
  if (document.URL.match("items/new")) {
    const priceInput = document.getElementById("item-price");
    priceInput.addEventListener("input", () => {
      const inputValue = priceInput.value;
      const addTaxDom = document.getElementById("add-tax-price");
      const inputAddTaxValue = Math.floor(inputValue * 0.1);
        addTaxDom.innerHTML = inputAddTaxValue;
      const profitDom = document.getElementById("profit");
        profitDom.innerHTML = Math.floor(inputValue - inputAddTaxValue);
    });
  };
});
