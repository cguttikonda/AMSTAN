<%@ page import="ezc.ezparam.*" %>
<%@ page import="ezc.shopping.cart.params.*" %>
<%@ page import="ezc.shopping.cart.client.*" %>
<%@ page import="ezc.shopping.cart.common.*" %>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>
<%

//<jsp:useBean id="SCManager" class="ezc.shopping.cart.client.EzShoppingCartManager" scope="session">
	//</jsp:useBean>

// TBD : We may have to think about creating Shopping Cart Manager for every request
// We have to look for option of passing parameters to JSP USEBEAN tag

EzShoppingCartManager SCManager = new EzShoppingCartManager( Session );
//out.println("SCManager"+SCManager);
%>
