<%@ page import="java.util.*"%>
<%@ include file="../../../Includes/Lib/ezShoppingCartBean.jsp"%>

<%
//EzShoppingCartManager SCManager = new EzShoppingCartManager();
  	EzShoppingCart Cart = null;

// Get The Whole Shopping Cart
/*Added By Venu*/
      EzcShoppingCartParams params = new EzcShoppingCartParams();
      EziShoppingCartParams subparams = new EziShoppingCartParams();
      subparams.setLanguage("EN");
      params.setObject(subparams);
      Session.prepareParams(params);
      Cart = (EzShoppingCart)SCManager.getSavedCart(params);
/*End Of Addition*/

String from = request.getParameter("from");
String CatalogDescription = request.getParameter("CatalogDescription");
String groupDesc = request.getParameter("GroupDesc");
String ProductGroup =request.getParameter("ProductGroup");
if("ezFavGroupFinalLevel.jsp".equalsIgnoreCase(from))
	ProductGroup =request.getParameter("FavGroup");



Hashtable selMet= new Hashtable();
/*

int tMetCount=retpro.getRowCount();
for(int m=0;m<tMetCount;m++)
{
	selMet.put(retpro.getFieldValueString(m,"MATNO"),(retpro.getFieldValueString(m,"UPC_NO")).trim());
}
*/
if(session.getAttribute("getprices") != null)
{
	session.removeAttribute("getprices");
}

%>