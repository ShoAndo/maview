if (window.location.pathname === '/orders/new' || window.location.pathname ==='orders/edit') {

  function calc(){
    const input = document.getElementById('order_award')
    const add_tax_price = document.getElementById('add-tax-price')
    const profit = document.getElementById('profit')

    input.addEventListener( 'input', (e) =>{
      const input_price = document.getElementById('order_award').value;
      if (input_price == 0){
        add_tax_price.innerHTML = '半角数字のみ入力可能'
        profit.innerHTML = '半角数字のみ入力可能'
      } else {
        add_tax_price.innerHTML = Math.floor(input_price * 0.1)
        profit.innerHTML = Math.floor(input_price * 0.9)
      }
      e.preventDefault()
    });
  }

  setInterval(calc, 1000)
}