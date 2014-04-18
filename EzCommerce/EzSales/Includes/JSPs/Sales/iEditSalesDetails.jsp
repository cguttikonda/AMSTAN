<%@ page import ="ezc.ezparam.*,ezc.sales.local.params.*,ezc.client.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezSalesBean.jsp"%>
<%
	ezc.ezcommon.EzLog4j log4j = new ezc.ezcommon.EzLog4j();
	
	String webOrNo = request.getParameter("webOrNo");
	String UserRoleCheck = (String)session.getValue("UserRole");
	String type = "";
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
	String SoldToCheck1=request.getParameter("soldTo");
	String salesAreaCheck1=request.getParameter("sysKey");

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

	log4j.log("webOrNowebOrNo::"+webOrNo+"-->"+type,"W");


	iSOHeader.setDocNumber(webOrNo);
	iSOHeader.setType(type);
	iSOHeader.setSoldTo(SoldToCheck1);
	iSOHeader.setSalesArea(salesAreaCheck1);

	SOStrut.setDeliverySchedules("X");
	SOStrut.setLines("H");   
	try{
		iSOHeader.setType("");
		
		log4j.log("webOrNowebOrNo1111::","W");
		EzoSalesOrderStatus soStatus  = (EzoSalesOrderStatus) EzSalesOrderManager.ezSalesOrderStatus(ezcSOParams);
		log4j.log("webOrNowebOrNo22222::"+soStatus,"W");
		
		
		mainRet = soStatus.getReturn();

		log4j.log("webOrNowebOrNo22222::"+mainRet.toEzcString(),"W");

		retHeader= (ReturnObjFromRetrieve) mainRet.getObject("SALES_HEADER");
		
		log4j.log("webOrNowebOrNo3333333::"+retHeader,"W");
		
		retLines = (ReturnObjFromRetrieve) mainRet.getObject("SALES_LINES");
		
		//log4j.log("webOrNowebOrNo4444444::"+retLines,"W");
		
		retDeliverySchedules = (ReturnObjFromRetrieve) mainRet.getObject("DELIVERY_LINES");
		
		retLineMatId         = (ReturnObjFromRetrieve) mainRet.getObject("ITEM_MATID"); 
		
		
		
		if(retLineMatId!=null){
			for(int r=0;r<retLineMatId.getRowCount();r++){
				myLineID.put(retLineMatId.getFieldValueString(r,"ESDI_SALES_DOC_ITEM"),retLineMatId.getFieldValueString(r,"EMM_ID"));
			} 
		}
		
		log4j.log("webOrNowebOrNo5555555555::"+retDeliverySchedules,"W");
		
		
		sdHeader = (ReturnObjFromRetrieve) retHeader.getObject("SdHeader");
		
		log4j.log("webOrNowebOrNo666666666::"+sdHeader,"W");  
		
		
		sdSoldTo = (ReturnObjFromRetrieve) retHeader.getObject("SdSoldTo");
		sdShipTo = (ReturnObjFromRetrieve) retHeader.getObject("SdShipTo");
		
		
		log4j.log("webOrNowebOrNo7777777777::"+sdSoldTo.toEzcString()+"-->"+sdShipTo.toEzcString(),"W");
		
		if(retLines.getRowCount() == 0)
		{
%>			<script>
				document.location.replace("../../../Sales2/JSPs/Sales/ezSalesDetailsError.jsp?webOrNo="+<%=webOrNo%>);
			</script>
<%		}
		if(!"confirm".equals( request.getParameter("confirm")))
		{
			session.putValue("EzDeliveryLines",retDeliverySchedules);
		}
	}catch(Exception e) 
	{
		System.out.println("EXCEPTION AT HEADER & LINES ::: "+e.getMessage());   
	} 
%>