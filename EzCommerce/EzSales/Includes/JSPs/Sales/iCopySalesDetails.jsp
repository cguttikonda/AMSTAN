
<%@ page import ="ezc.ezparam.*,ezc.sales.local.params.*,ezc.client.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezSalesBean.jsp"%>
<%
	
	String All = request.getParameter("webOrNo");
	String webOrNo =All.substring(0,All.indexOf(","));

	String SoldToCheck1 =All.substring(All.indexOf(",")+1,All.lastIndexOf(","));

	String salesAreaCheck1 =All.substring(All.lastIndexOf(",")+1,All.length());


	String UserRoleCheck = (String)session.getValue("UserRole");
	String type = "";//request.getParameter("type");
	ReturnObjFromRetrieve mainRet = null;

	ReturnObjFromRetrieve retHeader = null;
	ReturnObjFromRetrieve retLines = null;
	ReturnObjFromRetrieve retDeliverySchedules = null;
	ReturnObjFromRetrieve retLineMatId = null;
	
	java.util.Hashtable myLineID = new java.util.Hashtable();
	
	

	ReturnObjFromRetrieve sdHeader = null;
	ReturnObjFromRetrieve sdSoldTo = null;
	ReturnObjFromRetrieve sdShipTo = null;

//****************************** c h e c k **************************************

	String soldToCheck =(String)session.getValue("AgentCode");
	

	String UserIdCheck = Session.getUserId();

	EzcSalesOrderParams ezcSOParams = new EzcSalesOrderParams();
	ezcSOParams.setLocalStore("Y");
	Session.prepareParams(ezcSOParams);

	EziSalesOrderStatusParams iSOStatusParams = new EziSalesOrderStatusParams();
	EziSalesHeaderParams iSOHeader = new EziSalesHeaderParams();
	EzSalesOrderStructure SOStrut = new EzSalesOrderStructure();

	ezcSOParams.setObject(iSOStatusParams);
	ezcSOParams.setObject(iSOHeader);
	ezcSOParams.setObject(SOStrut);

	iSOHeader.setDocNumber(webOrNo);
	iSOHeader.setType(type);
	iSOHeader.setSoldTo(SoldToCheck1);
	iSOHeader.setSalesArea(salesAreaCheck1);
	

	SOStrut.setDeliverySchedules("X");
	SOStrut.setLines("H");  

	
	try{
		iSOHeader.setType("");
		EzoSalesOrderStatus soStatus  = (EzoSalesOrderStatus) EzSalesOrderManager.ezSalesOrderStatus(ezcSOParams);
		mainRet = soStatus.getReturn();

		retHeader = (ReturnObjFromRetrieve) mainRet.getObject("SALES_HEADER");
		retLines = (ReturnObjFromRetrieve) mainRet.getObject("SALES_LINES");
		retDeliverySchedules = (ReturnObjFromRetrieve) mainRet.getObject("DELIVERY_LINES");
		retLineMatId         = (ReturnObjFromRetrieve) mainRet.getObject("ITEM_MATID"); 
		
		if(retLineMatId!=null){
			for(int r=0;r<retLineMatId.getRowCount();r++){
				myLineID.put(retLineMatId.getFieldValueString(r,"ESDI_SALES_DOC_ITEM"),retLineMatId.getFieldValueString(r,"EMM_ID"));
			}
		}
		
		sdHeader = (ReturnObjFromRetrieve) retHeader.getObject("SdHeader");
		sdSoldTo = (ReturnObjFromRetrieve) retHeader.getObject("SdSoldTo");
		sdShipTo = (ReturnObjFromRetrieve) retHeader.getObject("SdShipTo"); 

		if(retLines.getRowCount() == 0) 
		{
		%>
			<script>
			document.location.replace("../../../Sales2/JSPs/Sales/ezSalesDetailsError.jsp?webOrNo="+<%=webOrNo%>);
			</script>
		<%
		}

		if(!"confirm".equals( request.getParameter("confirm") ) )
		{
			session.putValue("EzDeliveryLines",retDeliverySchedules);
		}


	}catch(Exception e)
	{
		////out.println("EXCEPTION AT HEADER & LINES ::: "+e.getMessage());
	} 

%>