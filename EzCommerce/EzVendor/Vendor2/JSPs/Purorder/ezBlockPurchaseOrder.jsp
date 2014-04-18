<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ page import ="ezc.ezparam.*,java.util.*,ezc.ezutil.*" %>
<jsp:useBean id="Session" class ="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="AppManager" class ="ezc.ezvendorapp.client.EzVendorAppManager" scope="page"></jsp:useBean>
<%
       String sysKey = (String)session.getValue("SYSKEY");
       String soldTo = (String)session.getValue("SOLDTO");
       String user = Session.getUserId();

       java.util.Date d = new java.util.Date();
       FormatDate formatDate = new FormatDate();
       String date=formatDate.getStringFromDate(d,".",FormatDate.DDMMYYYY);
      
       ezc.ezvendorapp.params.EzPOAcknowledgementTableRow tableRow=null;
       ezc.ezvendorapp.params.EzPOAcknowledgementTable table=new ezc.ezvendorapp.params.EzPOAcknowledgementTable();

       ezc.ezparam.EzcParams ezParams = new ezc.ezparam.EzcParams(true);
       ezParams.setLocalStore("Y");

       ezc.ezvendorapp.params.EzPOAcknowledgementTableRow addTableRow=null;
       ezc.ezvendorapp.params.EzPOAcknowledgementTable addTable=new ezc.ezvendorapp.params.EzPOAcknowledgementTable();

       ezc.ezparam.EzcParams eParams = new ezc.ezparam.EzcParams(true);
       eParams.setLocalStore("Y");

       ezc.ezvendorapp.params.EziPurchaseOrderParams iParams = new ezc.ezvendorapp.params.EziPurchaseOrderParams();
       ezc.ezvendorapp.params.EzVendorTimeStampStructure sParams = new ezc.ezvendorapp.params.EzVendorTimeStampStructure();

       ezc.ezparam.EzcParams delParams = new ezc.ezparam.EzcParams(true);
       delParams.setLocalStore("Y");
   
       String poNumber="";
       String purchaseOrder = "";

	String poNums[] = request.getParameterValues("chk1");
	int poLength = 0;
	if(poNums != null)
	{
		poLength = poNums.length;
	}
	for(int i=0;i<poLength;i++)
	{
		purchaseOrder = poNums[i];
		java.util.StringTokenizer st = new java.util.StringTokenizer(purchaseOrder,"#");

		String po = st.nextToken();
		String status = st.nextToken();
	
		if(!status.equals("-"))
		{
			tableRow = new ezc.ezvendorapp.params.EzPOAcknowledgementTableRow();
			tableRow.setDocNo(po);
			tableRow.setDocStatus("B");
			tableRow.setModifiedOn(date);
			table.appendRow(tableRow);
			poNumber = poNumber+po+"','";
			
		}
		else
		{
			
			addTableRow =  new ezc.ezvendorapp.params.EzPOAcknowledgementTableRow();
			addTableRow.setSysKey(sysKey);
			addTableRow.setSoldTo(soldTo);
			addTableRow.setDocNo(po);
			addTableRow.setDocDate(date);
			addTableRow.setDocStatus("B");
			addTableRow.setCreatedOn(date);
			addTableRow.setCreatedBy(user);
			addTableRow.setModifiedOn(date);
			addTableRow.setHeaderText("");
			addTableRow.setExt1("");
			addTableRow.setExt2("");
			addTableRow.setExt3("");
			addTable.appendRow(addTableRow);
		}
        }
       
       
       
       
       ezParams.setObject(table);
       Session.prepareParams(ezParams);
       AppManager.ezUpdatePOAcknowledgement(ezParams);

       if(poNumber.length()>0)
       {

	       poNumber=poNumber.substring(0,poNumber.length()-3);
	       iParams.setDocNo(poNumber);
	       delParams.setObject(iParams);
	       Session.prepareParams(delParams);
	       AppManager.ezDeletePODeliverySchedule(delParams);

       }

      sParams.setFlag("N");
      eParams.setObject(addTable);
      eParams.setObject(sParams);
      Session.prepareParams(eParams);
      AppManager.ezAddPOAcknowledgement(eParams);
      response.sendRedirect("../Purorder/ezListPOs.jsp?OrderType=Open");
	ezc.ezcommon.EzLog4j.log("CHECKINGGGGGBLOCK ENDS","I");
 

%>
