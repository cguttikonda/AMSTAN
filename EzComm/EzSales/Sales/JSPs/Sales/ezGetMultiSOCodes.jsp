<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ page import ="ezc.ezparam.*,ezc.ezmisc.params.*"%>
<%
	String soNumbers = "";
	ezc.ezparam.EzcParams mainParamsMisc		= new ezc.ezparam.EzcParams(false);
	ezc.ezparam.ReturnObjFromRetrieve retObjMisc 	= null;
	
	ezc.ezmisc.params.EziMiscParams miscParams 	= new ezc.ezmisc.params.EziMiscParams();
	ezc.ezmisc.client.EzMiscManager ezMiscManager 	= new ezc.ezmisc.client.EzMiscManager();
	miscParams.setIdenKey("MISC_SELECT");
	String query="SELECT DISTINCT(ESDI_BACK_END_ORDER) BACKEND_ORNO,ESDI_SALES_DOC FROM EZC_SALES_DOC_ITEMS WHERE ESDI_SALES_DOC IN ('"+request.getParameter("webOrNo")+"')";

	miscParams.setQuery(query);
	mainParamsMisc.setLocalStore("Y");
	mainParamsMisc.setObject(miscParams);
	Session.prepareParams(mainParamsMisc);	

	try
	{
		retObjMisc = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc);
	}
	catch(Exception e){}

	if(retObjMisc!=null && retObjMisc.getRowCount()>0)
	{
		for(int i=0;i<retObjMisc.getRowCount();i++)
		{
			String sapSONum = retObjMisc.getFieldValueString(i,"BACKEND_ORNO");
			String webSONum = retObjMisc.getFieldValueString(i,"ESDI_SALES_DOC");
			
			if(i==0)
				soNumbers = sapSONum;
			else
				soNumbers = soNumbers+"ÿ"+sapSONum;
		}
	}
%>
<Html>
<Head>
<Title>Loading PO/SO Details...</Title>
</Head>
<Body>
<Form name=myForm method='POST'>
 <input type="hidden" name="webOrNo" value='<%=soNumbers%>'>
 <input type="hidden" name="salesOrder" value='<%=soNumbers%>'>
 <input type="hidden" name="soldTo" value='<%=request.getParameter("soldTo")%>'>
 <input type="hidden" name="OrdShipTo" value='<%=request.getParameter("OrdShipTo")%>'>
 <input type="hidden" name="poDate" value='<%=request.getParameter("poDate")%>'>
 <input type="hidden" name="sysKey" value='<%=request.getParameter("sysKey")%>'>
 <input type="hidden" name="searchStat" value="<%=request.getParameter("searchStat")%>">
 <input type="hidden" name="negotiateType_A" value="<%=request.getParameter("negotiateType_A")%>">
 <input type="hidden" name="shipTo" value="<%=request.getParameter("shipTo")%>"> 

 </Form>
 <Script>
 	document.myForm.action = "ezSalesOrderDetails.jsp";
 	document.myForm.submit();
 </Script>
 </Body>