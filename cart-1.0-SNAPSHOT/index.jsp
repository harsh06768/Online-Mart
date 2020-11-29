<%-- 
    Document   : index
    Created on : 5 Nov, 2020, 11:59:01 PM
    Author     : Harsh Patel
--%>

<%@page import="com.mycompany.cart.Helper"%>
<%@page import="com.mycompany.cart.entities.Category"%>
<%@page import="com.mycompany.cart.dao.CategoryDao"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.cart.entities.Product"%>
<%@page import="com.mycompany.cart.dao.ProductDao"%>
<%@page import="com.mycompany.cart.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MyCart - Home</title>
        
        <%@include file="components/common_css_js.jsp" %>
        
        
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        
        <div class="container-fluid">
       <div class="row mt-3 mx-2">
           
           <%
               
               
               
             String cat=request.getParameter("category"); 
             ProductDao dao=new  ProductDao(FactoryProvider.getFactory());
              List<Product> list=null;
              if(cat==null || cat.trim().equals("all")){
                   list =dao.getAllProducts();
              }
              else{
                 int cid=Integer.parseInt(cat.trim());
                list=dao.getAllProductsById(cid);
                 
             }
             
             
            
             CategoryDao cdao=new CategoryDao(FactoryProvider.getFactory());
             
            List<Category> clist=cdao.getCategories();

               %>
           
           
           
           
           <!--show categories -->
           <div class="col-md-2">
               <div class="list-group mt-4">
                   <a href="index.jsp?category=all" class="list-group-item list-group-item-action active">
                            All Products
                    </a>
                  
               
                   
               
               <%
               for(Category c:clist){
                 
                   
                   %>
                   <a href="index.jsp?category=<%= c.getCategoryId() %>" class="list-group-item list-group-item-action"><%= c.getCategoryTitle() %></a>
               <%
                   }
               
               %>
               
               
               </div>
           </div>
            <!--show products -->
           <div class="col-md-10">
               
               <div class="row mt-4">
                   
                   <div class="col-md-12">
                   
                   <div class="card-columns">
                   
                       <% 
                       
                       for(Product p:list){
                       
                       %>
                       
                       <div class="card product-card">
                           <div class="container text-center">
                           <img src="img/products/<%= p.getpPhoto()  %>" style="max-height: 200px;max-width: 100%;width: auto;" class="card-img-top m-2" alt="..." >
                           </div>
                           <div class="card-body">
                               <h5 class="card-title"><%=  p.getpName()%></h5>
                               
                               <p class="card-text">
                                   
                                   <%= Helper.get10Words(p.getpDesc()) %>
                               </p>
                           </div>
                       
                               <div class="card-footer text-center">
                                   <button class="btn custom-bg text-white" onclick="add_to_cart(<%= p.getpId() %> , '<%=p.getpName() %>', <%= p.getPriceAfterApplyingDiscount()%>)">Add to cart</button>
                                   <button class="btn btn-outline-success "> &#8377; <%= p.getPriceAfterApplyingDiscount() %>/-  <span class="text-secondary discount-label" >&#8377; <%= p.getpPrice() %> , <%=p.getpDiscount() %>% off </span></button>
                               </div>
                               
                               <script>
                               function add_to_cart(pid, pname, price){
  
                                let cart=localStorage.getItem("cart");
    
                                if(cart==null){
                                    //no cart
                                let products=[];
                                let product={ productId:pid,productName:pname,productQuantity:1,productPrice:price}
                                products.push(product);
                                localStorage.setItem("cart",JSON.stringify(products));
                                //console.log("Product is added for the first time")
                                showToast("Item is added to cart")
                               }else{
                                //cart is already present
                                let pcart=JSON.parse(cart);
                                let oldProduct=pcart.find((item)=>item.productId == pid)
                                if(oldProduct){
                                    
                                    oldProduct.productQuantity=oldProduct.productQuantity+1
                                    pcart.map((item)=>{
                                        if(item.productId==oldProduct.productId){
                                            item.productQuantity=oldProduct.productQuantity;
                                        }
                                    })
                                    
                                    localStorage.setItem("cart", JSON.stringify(pcart));
                                    console.log("product quantity is incresed")
                                      showToast( oldProduct.productName + " quantity is incresed, Quantity= "+oldProduct.productQuantity)
                                    
                                }else{
                                    let product={ productId:pid,productName:pname,productQuantity:1,productPrice:price}
                                    pcart.push(product)
                                    localStorage.setItem("cart", JSON.stringify(pcart));
                                    console.log("product is added")
                                    showToast("Product is added to cart")
                                }    
                                
                               }
                                 updateCart();       
                              }
                           
                         </script>
                               
                               
                       </div>
                           
                       
                       
                       
                       <% }
                       
                       if(list.size()==0){
                                            out.println("<h3>No item in this category</h3>");
                                      }
                       
                       
                       
                       %>
                       
                   
                   </div>
                   </div>
                   
                   
               </div>
                   
               
               
               
           </div>
           
       </div>
        </div>
        
           <%@include file="components/comman_modals.jsp" %>
    </body>
    
    
</html>
