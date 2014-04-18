<%@ page import="ezc.ezmisc.params.*" %>
<%@ include file="../../../Includes/JSPs/ShoppingCart/iViewToCartItems.jsp"%>
<%
	String rulesApply = "";

	String soldToRules = request.getParameter("selSoldTo");
	String soldToSes = (String)session.getValue("AgentCode");	
	
	if(soldToSes!=null && !"".equals(soldToSes) && !"null".equals(soldToSes))
		soldToSes=soldToSes.trim();
		
	if(soldToRules!=null && !"".equals(soldToRules) && !"null".equals(soldToRules))
	{
		soldToRules = soldToRules.trim();
	
	if(!(soldToSes.equals(soldToRules)))
	{
	
		//Commision Group Start

		EzcParams mainParamsMisc_CD= new EzcParams(false);
		EziMiscParams miscParams_CD = new EziMiscParams();

		ReturnObjFromRetrieve retObjMisc_CD = null;
		int countMisc_CD=0;

		miscParams_CD.setIdenKey("MISC_SELECT");
		miscParams_CD.setQuery("SELECT EUD_USER_ID,EUD_KEY,EUD_VALUE FROM EZC_USER_DEFAULTS WHERE EUD_KEY IN ('SAP_COMM_GROUP') AND EUD_USER_ID='"+Long.parseLong(request.getParameter("selSoldTo"))+"'");

		mainParamsMisc_CD.setLocalStore("Y");
		mainParamsMisc_CD.setObject(miscParams_CD);
		Session.prepareParams(mainParamsMisc_CD);

		String commGorupId = "";

		try
		{		
			retObjMisc_CD = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc_CD);
		}
		catch(Exception e){}

		if(retObjMisc_CD!=null && retObjMisc_CD.getRowCount()>0)
		{
			if("SAP_COMM_GROUP".equals(retObjMisc_CD.getFieldValueString(0,"EUD_KEY")))
			{
				commGorupId=retObjMisc_CD.getFieldValueString(0,"EUD_VALUE");
			}			
		}			
		ezc.ezcommon.EzLog4j.log("::::commGorupId:::::::"+commGorupId ,"I");
		
		if(commGorupId==null || "null".equals(commGorupId) || "".equals(commGorupId))
			commGorupId = "N/A";
		
		//Commision Group End
		
		if(Cart!=null && Cart.getRowCount()>0)
		{
			int cartRows = Cart.getRowCount();
			
			for(int i=0;i<cartRows;i++)
			{			
				String prodCode_S = (String)Cart.getMatId(i);				
				String retExcl_S = (String)Cart.getCat3(i);
				
				if(!"N/A".equals(retExcl_S) && !commGorupId.equals(retExcl_S))
				{
					rulesApply = "Y";
					break;
				}				
			}
		}
	}
	}
%>