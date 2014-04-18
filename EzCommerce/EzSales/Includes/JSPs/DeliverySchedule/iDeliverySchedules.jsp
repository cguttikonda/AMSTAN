<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>
<%@ page import ="ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/ezSalesBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>

<%
	
	ezc.client.EzcUtilManager UtilManager =  new ezc.client.EzcUtilManager(Session);
	
	
	String CustCode		= (String)session.getValue("docSoldTo");
	String backEndOrNo 	= request.getParameter("SalesOrder");
	
        //out.println("backEndOrNo"+backEndOrNo);
	EzcSalesOrderParams  ezcSalesOrderParams = new EzcSalesOrderParams();
	FormatDate formatDate = new FormatDate();
	ezc.sales.params.EziSalesOrderStatusParams testParams=new ezc.sales.params.EziSalesOrderStatusParams();

	String soNum = backEndOrNo.trim() ;     //"3225000057";
	String selection = "S";  
	
	testParams.setDocNumber(soNum);
	testParams.setSelection(selection);
	testParams.setCustomerNumber(CustCode);	
     	ezcSalesOrderParams.createContainer();
	ezcSalesOrderParams.setObject(testParams);

	String oqty="";
	Session.prepareParams(ezcSalesOrderParams);
	System.out.println("BeforeCall");

	String defSoldTo = UtilManager.getUserDefErpSoldTo();
	String aSoldTo	 = request.getParameter("soldTo");


	if(!aSoldTo.equalsIgnoreCase(defSoldTo))
		UtilManager.changeSoldTo(aSoldTo);
	
	if(!aSoldTo.equalsIgnoreCase(defSoldTo) )
		UtilManager.setSysKeyAndSoldTo(UtilManager.getCurrSysKey(),defSoldTo);
		
	System.out.println("aSoldTo >>  "+aSoldTo);


	ReturnObjFromRetrieve params =(ReturnObjFromRetrieve)EzSalesOrderManager.getSalesOrderDelivery(ezcSalesOrderParams);
	ReturnObjFromRetrieve delivShedules 	= (ReturnObjFromRetrieve)params.getFieldValue("ORDER_SCHEDULES_OUT");
	ReturnObjFromRetrieve orderItems 	= (ReturnObjFromRetrieve)params.getFieldValue("ORDER_ITEMS_OUT");

        

	Hashtable matdesc = new Hashtable();
	String prodCodeStr = "";
	String custMatStr  = "";
	for(int j=0;j<orderItems.getRowCount();j++){
		try
		{
			prodCodeStr = (Long.parseLong(orderItems.getFieldValueString(j,"Material")))+"";
			custMatStr = (Long.parseLong(orderItems.getFieldValueString(j,"CustMat22")))+"";
		}
		catch(Exception e)
		{
			prodCodeStr = orderItems.getFieldValueString(j,"Material");
			custMatStr = orderItems.getFieldValueString(j,"CustMat22");
		}
		
		if(custMatStr == null || "null".equals(custMatStr) || "".equals(custMatStr))
		   custMatStr = "N/A";

		matdesc.put(orderItems.getFieldValueString(j,"ItmNumber"),prodCodeStr+"###"+custMatStr+"###"+orderItems.getFieldValueString(j,"ShortText")); 
	}
	
	

	
%>
