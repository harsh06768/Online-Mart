function updateCart(){
    
    let cartString= localStorage.getItem("cart");
    let cart=JSON.parse(cartString);
    if (cart==null || cart.length==0){
        console.log("Cart is empty");
        $(".cart-items").html("( 0 )");
        $(".cart-body").html("<h3>Cart does not have any items </h3>");
        $(".checkout-btn").attr('disabled',true);
        
    }else{
         console.log(cart)
         $(".cart-items").html(`( ${cart.length} ) `);
         let table=`
                 <table class='table'>
                 <thead class='thread-light'>
                 <tr>
                 <th>Item Name </th>
                  <th>Price </th>
                  <th>Quantity </th>
                  <th>Total Price </th>
                  <th>Action </th>
                 
                 </tr>
                 
                 </thead>
                 
                 
                 
                 
                 `;
           let totalPrice=0;     
        cart.map((item)=>{
          table+=`
            <tr>
                <td> ${item.productName} </td>
                <td> ${item.productPrice} </td>
                <td> ${item.productQuantity} </td>
                <td> ${item.productQuantity * item.productPrice} </td>
                <td> <button onclick='deleteItemFromCart(${item.productId})' class="btn btn-danger btn-sm">Remove</button>  </td>
            
            </tr>

            `
            totalPrice+=item.productPrice*item.productQuantity;
            
        })
                 
                 
                 
                  table=table+ `
                    <tr><td colspan='5' class='text-right font-weight-bold m-5'> Total Price :${totalPrice} </td></tr>
                </table>`
                  $(".cart-body").html(table); 
                  $(".checkout-btn").attr('disabled',false);
        
    }
    
    
}
// remove item from cart
function deleteItemFromCart(pid){
     let cart=JSON.parse(localStorage.getItem('cart'));
   let newcart= cart.filter((item)=> item.productId != pid)
    localStorage.setItem('cart',JSON.stringify(newcart))
    
    updateCart();
    showToast("Item is removed from cart")
}

$(document).ready(function(){
    updateCart();
})


function showToast(content){
    $("#toast").addClass("display");
    $("#toast").html(content);
    setTimeout(()=> {
        $("#toast").removeClass("display");
    }, 2000);
    
}


function  goToCheckout(){
    window.location="checkout.jsp"
}