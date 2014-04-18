
<%@ page import = "ezc.ezutil.FormatDate" %>
<%@ include file="../../../Includes/Lib/ShoppingCartBean.jsp"%>

<%!
// Date Function
	java.util.GregorianCalendar fromDate = null ;

// Convert java.util.Date to java.util.GregorianCalendar
	public java.util.GregorianCalendar getConvertedDate(java.util.GregorianCalendar inDate){
	if ( inDate != null )
		return ( new java.util.GregorianCalendar( inDate.get(inDate.YEAR) , inDate.get(inDate.MONTH), inDate.get(inDate.DATE) ) )	;
return null;
}
%>
<%
	String [] product = request.getParameterValues("product");

	int selCount = 0;
	String checkbox = null; 
	String pCheckBox = null;
	int totCount =0;
	if(product!=null)
	{
		totCount =product.length;
		for ( int i = 0 ; i < totCount; i++ )
		{
			pCheckBox = request.getParameter("CheckBox_"+i);
			if ( pCheckBox != null )
			{
				selCount = selCount + 1;
			}
		}
	}	
	
	String [] products = new String[selCount];
	String [] reqQtys  = new String[selCount];
	String [] reqDates = new String[selCount];
	selCount=0;	
	for ( int i = 0 ; i < totCount; i++ )
	{
		pCheckBox = request.getParameter("CheckBox_"+i);
		if ( pCheckBox != null )
		{
			products[selCount] = product[i];
			reqQtys[selCount] = new String("0");
			reqDates[selCount] ="1.11.1000" ;
			selCount++;
		}
	}// End For
		
		
		
	// Store selected Products to Shopping cart
		EzcShoppingCartParams params = new EzcShoppingCartParams();
		EziReqParams reqparams = new EziReqParams();
		EziShoppingCartParams subparams = new EziShoppingCartParams();

			reqparams.setProducts(products);
			reqparams.setReqDate(reqDates);
			reqparams.setReqQty(reqQtys);
			subparams.setLanguage("EN");
			subparams.setEziReqParams(reqparams);
			params.setObject(subparams);
			Session.prepareParams(params);
		try{
			SCManager.updateCart(params);
		}catch(Exception e){}
%>