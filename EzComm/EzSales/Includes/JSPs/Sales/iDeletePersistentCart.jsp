<%@ page import="ezc.ezparam.*,ezc.ezmisc.params.*" %>

<%
	EzcParams mainParamsCart= null;
	EziMiscParams miscParamsCart = null;
	ezc.ezmisc.client.EzMiscManager ezMiscManagers = null;
				
	mainParamsCart = new EzcParams(false);
	miscParamsCart = new EziMiscParams();
	ezMiscManagers = new  ezc.ezmisc.client.EzMiscManager();

	miscParamsCart.setIdenKey("MISC_DELETE");
	String query="DELETE FROM EZC_SHOPPING_CART WHERE ESC_USER_ID='"+Session.getUserId()+"'";
	miscParamsCart.setQuery(query);

	mainParamsCart.setLocalStore("Y");
	mainParamsCart.setObject(miscParamsCart);
	Session.prepareParams(mainParamsCart);	
	try
	{		
		ezMiscManagers.ezDelete(mainParamsCart);
	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}		
%>