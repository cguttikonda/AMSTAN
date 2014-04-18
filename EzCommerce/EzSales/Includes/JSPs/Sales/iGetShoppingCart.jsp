<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%@ include file="../../../Includes/Lib/ezShoppingCartBean.jsp"%>
<%
     EzShoppingCart Cart = null;
     EzcShoppingCartParams params = new EzcShoppingCartParams();
     EziShoppingCartParams subparams = new EziShoppingCartParams();
     subparams.setLanguage("EN");
     params.setObject(subparams);
     Session.prepareParams(params);
     Cart = (EzShoppingCart)SCManager.getSavedCart(params);
%>