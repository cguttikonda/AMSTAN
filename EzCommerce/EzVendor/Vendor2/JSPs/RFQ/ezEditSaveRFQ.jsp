<%--*************************************************************************************

       /* Copyright Notice ===================================================
	* This file contains proprietary information of Answerthink Ind Ltd.
	* Copying or reproduction without prior written approval is prohibited.
	* Copyright (c) 2005-2006 =====================================*/
		Author: smaddipati
		Team:   EzcSuite
		Date:   28/12/2005
**************************************************************************************--%>

<%@ page import ="java.util.*,ezc.ezutil.*,ezc.ezpreprocurement.params.*,ezc.ezparam.*" %>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Misc/iEzDateConvertion.jsp" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%
	ezc.ezpreprocurement.client.EzPreProcurementManager ezrfqmanager  = new ezc.ezpreprocurement.client.EzPreProcurementManager();
	EzcParams 		ezcparams		= new ezc.ezparam.EzcParams(false);
	EziRFQHeaderParams	headerParams		= new EziRFQHeaderParams();
	EziRFQHeaderTable       ezirfqheadertable 	= new EziRFQHeaderTable();
	EziRFQHeaderTableRow    ezirfqheadertablerow    = null;
	EziRFQItemQtyTable  	qtyTable		= new EziRFQItemQtyTable();
	EziRFQItemQtyTableRow 	qtyTableRow		= null;
	EziRFQDetailsTable ezirfqdetailstable 	        = new EziRFQDetailsTable();
	EziRFQConditionsTable ezirfconditiontable 	= new EziRFQConditionsTable();
  	EziAuditTrailTable eziaudittable = new EziAuditTrailTable();
  	EziAuditTrailTableRow 	eziaudittablerow 	= null;	
	
  	String purchOrg    = (String)Session.getUserPreference("PURORG");
	String purGrp  	   = (String)Session.getUserPreference("PURGROUP");
  
  	String finalRetMsg ="";
	String RfqNo	   = request.getParameter("rfqNo");
	String myCollRFQNo = request.getParameter("myCollRFQNo");
	String qtnEndDate  = request.getParameter("qtnEndDate");
	
	int itemsCount  = 0;
	String[]   quantity = request.getParameterValues("quantity");
	String[]   ItemNos  = request.getParameterValues("lineNo");
	String[]   matDesc  = request.getParameterValues("matDesc");
	if(quantity!=null) itemsCount = quantity.length;
	
	int dd=Integer.parseInt(qtnEndDate.substring(0,2));
	int mm=Integer.parseInt(qtnEndDate.substring(3,5));
	int yy=Integer.parseInt(qtnEndDate.substring(6,10));
	GregorianCalendar g=new GregorianCalendar(yy,mm-1,dd);
	Date eDate= g.getTime();
	ezc.ezparam.ReturnObjFromRetrieve myRFQListRet = null;
	
	
	
	
		
		
	EziRFQHeaderParams ezirfqheaderparams 	= new EziRFQHeaderParams();

	ezirfqheaderparams.setCollectiveRFQNo(myCollRFQNo);	
	ezirfqheaderparams.setExt1("RFQ");	
	ezirfqheaderparams.setStatus("Y','N','C");	
	ezcparams.setObject(ezirfqheaderparams);
	ezcparams.setLocalStore("Y");
	Session.prepareParams(ezcparams);

	try{
		myRFQListRet = (ezc.ezparam.ReturnObjFromRetrieve)ezrfqmanager.ezGetRFQList(ezcparams);
	}catch(Exception e){
		System.out.println("Exception Occured while getting QCFs List:"+e);
	}

	java.util.Vector rfqVector = new java.util.Vector();
	if(myRFQListRet!=null){
		int myRetCnt =  myRFQListRet.getRowCount();
		for(int i=0;i<myRetCnt;i++)	
		{
			if(!rfqVector.contains(myRFQListRet.getFieldValueString(i,"RFQ_NO"))){
				rfqVector.addElement(myRFQListRet.getFieldValueString(i,"RFQ_NO")); 
			}	

		}
	}
	
	
	boolean myAuthDoc=false;
	
	for(int r=0;r<rfqVector.size();r++){
		
		if(RfqNo.equalsIgnoreCase((String)rfqVector.get(r))){
			myAuthDoc=true;
		}else{
			myAuthDoc=false;
		}
		
		
		ezcparams		= new ezc.ezparam.EzcParams(false);
		headerParams		= new EziRFQHeaderParams();
		ezirfqheadertable 	= new EziRFQHeaderTable();
		qtyTable		= new EziRFQItemQtyTable();
		eziaudittable = new EziAuditTrailTable();

		headerParams.setRFQNo((String)rfqVector.get(r));
		headerParams.setQuotationendDate(eDate);


		if(myAuthDoc){

			for(int j=0;j<itemsCount;j++)
			{	
				String delD = "deliveryDate"+j;
				String delDate = request.getParameter(delD);

				qtyTableRow     = new EziRFQItemQtyTableRow();

				qtyTableRow.setQuantity(quantity[j]);
				qtyTableRow.setDelDate(delDate);
				qtyTableRow.setRFQNo((String)rfqVector.get(r));
				qtyTableRow.setItmNo(ItemNos[j]);
				qtyTableRow.setMaterialDesc(matDesc[j]);
				qtyTable.appendRow(qtyTableRow);			
			}
		}

		ezcparams.setObject(headerParams);
		ezcparams.setObject(qtyTable);
		Session.prepareParams(ezcparams);
		ezc.ezparam.ReturnObjFromRetrieve rfqRet = (ezc.ezparam.ReturnObjFromRetrieve)ezrfqmanager.ezEditRFQ(ezcparams);
		
		




		String retMessage="";
		int rfqCount = rfqRet.getRowCount();

		for(int i=0;i<rfqCount;i++)
		{
			if(rfqRet.getFieldValueString(i,"MSGTYP").equals("E"))
			{

				retMessage="Error in RFQ Change.";
				if(myAuthDoc){
					finalRetMsg=retMessage;
				}
			}
		} 
		if("".equals(retMessage))
		{
			retMessage="RFQ Changed Successfully.";
			if(myAuthDoc){
				finalRetMsg=retMessage;
			}
			ezcparams		= new ezc.ezparam.EzcParams(false);
			ezirfqheadertablerow = new ezc.ezpreprocurement.params.EziRFQHeaderTableRow();	
			ezirfqheadertablerow.setRFQNo((String)rfqVector.get(r)); 
			ezirfqheadertablerow.setQuotationendDateString(qtnEndDate); 
			ezirfqheadertablerow.setModifiedBy(Session.getUserId()); 	
			ezirfqheadertable.appendRow(ezirfqheadertablerow);
			if(myAuthDoc)
			{
				eziaudittablerow 	= new EziAuditTrailTableRow();	
				eziaudittablerow.setDocId((String)rfqVector.get(r));
				eziaudittablerow.setDocType("AN");
				eziaudittablerow.setDocCategory("A");
				eziaudittablerow.setUserName(Session.getUserId());
				eziaudittablerow.setFMName("Z_EZ_RFQ_CHANGE");
				eziaudittablerow.setIPAddress(request.getRemoteAddr());
				eziaudittablerow.setPurOrg(purchOrg);
				eziaudittablerow.setPurGrp(purGrp);
				eziaudittablerow.setComments("RFQ has been modified");
				eziaudittablerow.setChangeInd("U");
				eziaudittable.appendRow(eziaudittablerow);

				ezcparams.setObject(eziaudittable);
				Session.prepareParams(ezcparams);
				ezrfqmanager.ezAddAuditTrail(ezcparams);
			}	

			ezcparams.setObject(ezirfqheadertable);
			ezcparams.setObject(ezirfqdetailstable);
			ezcparams.setObject(ezirfconditiontable);
			if(myAuthDoc){
				for(int i=0;i<qtyTable.getRowCount();i++){
					qtyTableRow=(EziRFQItemQtyTableRow)qtyTable.getRow(i);
					qtyTableRow.setMaterialDesc("");
				}
				ezcparams.setObject(qtyTable);	
			}
			ezcparams.setLocalStore("Y");
			Session.prepareParams(ezcparams);
			ezrfqmanager.ezUpdateRFQ(ezcparams);
			
			
				
		}
		
		
	}
	
	
		
	
%>	
<html>
<head>
<script>
	 function goToList()
	 {
		document.myForm.action="../RFQ/ezGetEditRFQList.jsp";
		document.myForm.submit();
	 }
 </script>
<%@ include file="../../../Includes/Jsps/Misc/iblockcontrol.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
</head>
<body bgcolor="#FFFFF7">
<form name="myForm" method="post">
<%
	String display_header = "";
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<br><br><br>
<table width="50%" align="center" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>
  <tr align="center">
    <th><%=finalRetMsg%></th>
  </tr>
</table>
<br><br>
<center>
<%
    butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
    butActions.add("goToList()");
    out.println(getButtons(butNames,butActions));
%>
</center>
<Div id="MenuSol"></Div>
</form>
</body>
</html>
