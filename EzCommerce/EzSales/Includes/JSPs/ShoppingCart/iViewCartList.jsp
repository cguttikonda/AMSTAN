<%@ page import="java.util.*"%>
<%@ include file="../../../Includes/Lib/ezShoppingCartBean.jsp"%>
<%
      
      EzShoppingCart Cart = null;
      int cartRows=0;

      EzcShoppingCartParams params = new EzcShoppingCartParams();
      EziShoppingCartParams subparams = new EziShoppingCartParams();
      subparams.setLanguage("EN");
      params.setObject(subparams);
      Session.prepareParams(params);
      Cart = (EzShoppingCart)SCManager.getSavedCart(params);
      
      if(Cart!=null && Cart.getRowCount()>0)
      	 cartRows = Cart.getRowCount();
      
%>