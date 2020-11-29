
<%@page import="com.mycompany.cart.Helper"%>
<%@page import="java.util.Map"%>
<%@page import="com.mycompany.cart.FactoryProvider"%>
<%@page import="jdk.nashorn.internal.runtime.regexp.JoniRegExp.Factory"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.cart.dao.CategoryDao"%>
<%@page import="com.mycompany.cart.entities.Category"%>

<%@page import="com.mycompany.cart.entities.User" %>

<% 

    User user=(User)session.getAttribute("current-user");
    if (user==null){
        
        session.setAttribute("message", "You are not logged in !! Login first ");
        response.sendRedirect("login.jsp");
        return ;
    }
    else{
        
        if (user.getUserType().equals("normal")){
             session.setAttribute("message", "You are not authorize user to access this page !!! ");
        response.sendRedirect("login.jsp");
        return ;
        }
        
        
        
    }



    %>


     <%
                CategoryDao cdao=new CategoryDao(FactoryProvider.getFactory());
                List<Category> list=cdao.getCategories();
                
                //getting  user count
                Map<String,Long> m=Helper.getCounts(FactoryProvider.getFactory());
                %>
    
    
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       
        <title>Admin Panel</title>
        <%@include file="components/common_css_js.jsp" %>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
       <div class="container admin">
           
           <div class="container-fluid mt-3">
               
               <%@include file="components/message.jsp" %>
               
           </div>
           
           
           <div class="row mt-3" >
               
               <div class="col-md-4">
                   <div class="card">
                       <div class="card-body text-center">
                           <div class="container">
                               <img style="max-width: 140px;" class="img-fluid" src="img/group.png" alt="user_icon">
                           </div>
                           <h1><%= m.get("userCount") %></h1>
                           <h3 class="text-uppercase text-muted">Users</h3>
                       </div>
                   </div>
                   
     
                   
                   </div>
               
               <div class="col-md-4">
                   <div class="card">
                       <div class="card-body text-center">
                           <div class="container">
                               <img style="max-width: 140px;" class="img-fluid" src="img/checklist.png" alt="user_icon">
                           </div>
                            <h1><%= list.size ()%></h1>
                           <h3 class="text-uppercase text-muted">Categories</h3>
                       </div>
                   </div>
                   
                   </div>
               
               <div class="col-md-4">
                   <div class="card">
                       <div class="card-body text-center">
                           <div class="container">
                               <img style="max-width: 140px;" class="img-fluid" src="img/shopping-cart.png" alt="user_icon">
                           </div>
                            <h1><%= m.get("productCount") %></h1>
                           <h3 class="text-uppercase text-muted">Products</h3>
                       </div>
                   </div>
                   
                   </div>
           </div>
           
           
           
           <div class="row mt-5">
               
               <div class="col-md-6">
                   <div class="card"  data-toggle="modal" data-target="#add-category-modal">
                       <div class="card-body text-center">
                           <div class="container">
                               <img style="max-width: 140px;" class="img-fluid" src="img/calculator.png" alt="user_icon">
                           </div>
                            
                           <h3 class="text-uppercase text-muted mt-2">Add Categories</h3>
                       </div>
                   </div>
                   
                   </div>
               
               <div class="col-md-6">
                   <div class="card" data-toggle="modal" data-target="#add-product-modal">
                       <div class="card-body text-center">
                           <div class="container">
                               <img style="max-width: 140px;" class="img-fluid" src="img/plus.png" alt="user_icon">
                           </div>
                            
                           <h3 class="text-uppercase text-muted mt-2">Add Product</h3>
                       </div>
                   </div>
                   
               </div>
               
           </div>
           
           
           
           </div>
       <!-- Button trigger modal -->


<!-- Modal -->
<div class="modal fade" id="add-category-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header custom-bg text-white">
        <h5 class="modal-title" id="exampleModalLabel">Fill category detail</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        
          <form action="ProductOperationServlet" method="post">
              <input type="hidden" name="operation" value="addcategory" >
              <div class="form-group">
              <input type="text" class="form-control" name="catTitle" placeholder="Enter category title" required />
              </div>
              
              <div class="form-group">
                  <textarea style="height:300px" class="form-control" placeholder="Enter category description" name="catDescription" required></textarea>
              </div>
              
              <div class="container text-center">
                  <button class="btn btn-outline-success">Add Category</button>
                  <button type="button" class="btn btn-outline-warning" data-dismiss="modal">Close</button>
              </div>
              
              
          </form>
          
          
          
          
          
          
      </div>
    
    </div>
  </div>
</div>
<!--end of add category modal -->

<!--this is add product block-->
<!-- Button trigger modal -->
<!-- start Modal -->

<!-- Button trigger modal -->


<div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Product Details</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        
        <!-- start form -->
        
        <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
            
            <input type="hidden" name="operation" value="addproduct" />
            
            <div class="form-group">
                
                <input type="text" class="form-control" placeholder="Enter product Title" name="pName" required />
             </div>
            
            <div class="form-group">
                
                <textarea style="height: 100px;" class="form-control" placeholder="Enter Product Description" name="pDesc"> </textarea>
               </div>
            
            <div class="form-group">
                
                <input type="number" class="form-control" placeholder="Enter price of Product" name="pPrice" required />
             </div>
            
            <div class="form-group">
                
                <input type="number" class="form-control" placeholder="Enter Product Discount" name="pDiscount" required />
             </div>
            
            <div class="form-group">
                
                <input type="number" class="form-control" placeholder="Enter product Quantity" name="pQuantity" required />
             </div>
            
            <!-- product category -->
            
           
            
            <div class="form-group">
                <select name="catId" class="form-control" id=" ">
                    
                    <%
                        for(Category c:list){
                        %>
                    
                  
                <option value="<%= c.getCategoryId() %>"> <%= c.getCategoryTitle() %> </option>
                
                <%} %>
                </select>
                
             </div>
            
            
             <!-- product picture -->
            <div class="form-group">
                <label for="pPic">Select Picture of Product</label>
                <br>
            <input type="file" id="pPic" name="pPic" required />
            </div>
            
            
              <!-- submit buttonm -->
              
              <div class="container text-center">
                  <button class="btn btn-outline-success">Add Product</button>
                  
              </div>
             
             
            
        </form>
        
        
        
        
        
        
        
        
        <!-- end form -->
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
       
      </div>
    </div>
  </div>
</div>




          
     

<!--add product code ends here-->

<%@include file="components/comman_modals.jsp" %>

    </body>
</html>
