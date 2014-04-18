
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/ShoppingCart/iUpdateCart.jsp"%>
<%
// Call the ezViewCart.jsp for showing the Shopping Cart
  response.sendRedirect("../ShoppingCart/ezViewCart.jsp");            
%>
