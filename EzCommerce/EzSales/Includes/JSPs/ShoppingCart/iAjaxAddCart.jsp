<%@ page import = "ezc.ezutil.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezShoppingCartBean.jsp"%>

<%!
// Date Function
	java.util.GregorianCalendar fromDate = null ;
// Convert java.util.Date to java.util.GregorianCalendar
	public java.util.GregorianCalendar getConvertedDate(java.util.GregorianCalendar inDate)
	{
		if ( inDate != null )
			return ( new java.util.GregorianCalendar( inDate.get(inDate.YEAR) , inDate.get(inDate.MONTH), inDate.get(inDate.DATE) ) )	;
		return null;
	}
%>

<%
	String strTcount = request.getParameter("Count");
	
	String pValue =  request.getParameter("pValue");
	String qValue =  request.getParameter("qValue");
	
	StringTokenizer st = new StringTokenizer(pValue,"$");
	StringTokenizer st1 = new StringTokenizer(qValue,"$");

	// Return Values for the SaveCart function
	
	int selCount = Integer.parseInt(strTcount);

	String checkbox = null; 
	String product = null; 

	String pCheckBox = null;
	String pProductNumber = null;

	FormatDate formatDate = new FormatDate();
	
	String [] products = new String[selCount];
	String [] reqQtys  = new String[selCount];
	String [] reqDates = new String[selCount];
	
	selCount = 0;
	if(strTcount!=null)
	{
		String chkString = "";
		while(st.hasMoreTokens())
		{
			products[selCount] = new String(""+st.nextToken());
			reqQtys[selCount] = new String(""+st1.nextToken());
			reqDates[selCount] ="1.11.1000" ;
			selCount++;

		}


			if ( products != null || reqQtys != null || reqDates != null )
			{
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
					SCManager.saveCart(params);
					SCManager.updateCart(params);
				  }catch(Exception e){ out.println("Exception  "+e);}

				pProductNumber = null;
				products = null;
				reqQtys  = null;
				reqDates  = null;
			}

	}

%>
