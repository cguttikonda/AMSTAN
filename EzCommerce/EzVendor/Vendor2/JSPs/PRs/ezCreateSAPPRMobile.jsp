<%@ page import = "ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO,ezc.ezparam.*" %>

<%
	com.sap.mw.jco.JCO.Client client = null;

	String systemKey = (String)session.getValue("SYSKEY");
	String site = (String)session.getValue("Site");
	String connStr 		= "642~999";
	if(systemKey!=null)
		connStr = site+"~"+systemKey.substring(0,3);
		
	java.util.Hashtable purgrphash	=  (java.util.Hashtable)session.getValue("PURGROUPS");

	com.sap.mw.jco.JCO.Function function = EzSAPHandler.getFunction("BAPI_REQUISITION_CREATE",connStr);
	com.sap.mw.jco.JCO.ParameterList sapPreProc = function.getImportParameterList();
	com.sap.mw.jco.JCO.ParameterList sapTabParam = function.getTableParameterList();
	com.sap.mw.jco.JCO.Table itemsTable = sapTabParam.getTable("REQUISITION_ITEMS");
	com.sap.mw.jco.JCO.Table accAssignTable = sapTabParam.getTable("REQUISITION_ACCOUNT_ASSIGNMENT");
	com.sap.mw.jco.JCO.Table itemTxtTable = sapTabParam.getTable("REQUISITION_ITEM_TEXT");


	client = EzSAPHandler.getSAPConnection(connStr);
	
	
	
	String sapReqNumber=null,dispMessage="";
	boolean errorFlag = false;

	

	
		
		String material = request.getParameter("Material");
		if(material!=null && !"".equals(material.trim()))
		{
		
			
			
			int itemNumber= 10;//Integer.parseInt(request.getParameter("itemNo"));
			String quantity = request.getParameter("Quantity");
			String valPrice = request.getParameter("valPrice");
			String uom = request.getParameter("UOM");
			String purGrp = "";
			String plant = "BP01";
			
			if(purgrphash!=null)
				 purGrp = (String)purgrphash.get(systemKey);
				 
			java.util.GregorianCalendar reqDDate = null;

			try{
				String ddate = request.getParameter("deliveryDate");
				int mn = Integer.parseInt(ddate.substring(0,2));
				int dt = Integer.parseInt(ddate.substring(3,5));
				int yr = Integer.parseInt(ddate.substring(6,10));
				reqDDate = new java.util.GregorianCalendar(yr,mn-1,dt);
			}catch(Exception e){}		
			//out.println(reqDDate);
			

			itemsTable.appendRow();
			itemsTable.setValue((itemNumber+1)*10, "PREQ_ITEM");
			itemsTable.setValue("NB", "DOC_TYPE");
			itemsTable.setValue(purGrp, "PUR_GROUP");
			if(material != null && !"".equals(material))
			    itemsTable.setValue(material, "MATERIAL");
			
			itemsTable.setValue(plant, "PLANT");
			itemsTable.setValue(quantity, "QUANTITY");
			if(reqDDate != null && !"".equals(reqDDate))
			    itemsTable.setValue(reqDDate.getTime(), "DELIV_DATE");
			if(valPrice != null && !"".equals(valPrice))
			    itemsTable.setValue(valPrice, "C_AMT_BAPI");
			itemsTable.setValue("", "ACCTASSCAT");
			//itemsTable.setValue("", "MRP_CONTR");
			itemsTable.setValue("USD", "CURRENCY");
			if(uom!=null && !"".equals(uom))
			{
				itemsTable.setValue(uom,"UNIT");
			}
			//itemsTable.setValue(matGroup,"MAT_GRP");
			//itemsTable.setValue(stLoc, "STORE_LOC");
			//itemsTable.setValue("", "TRACKINGNO");
			itemsTable.setValue("X", "GR_IND");
			itemsTable.setValue("X", "IR_IND");

			//accAssignTable.appendRow();
			//accAssignTable.setValue((itemNumber+1)*10, "PREQ_ITEM");
			//accAssignTable.setValue(glAccNo, "G_L_ACCT");
			//accAssignTable.setValue(bussArea, "BUS_AREA");
			//accAssignTable.setValue(costCenter, "COST_CTR");
			//accAssignTable.setValue(wbsElement, "ORDER_NO");
			//accAssignTable.setValue(wbsElement, "WBS_ELEM");
			//accAssignTable.setValue(recipient, "GR_RCPT");

		}
	
	try{
		client.execute(function);
		EzSAPHandler.commit(client);
	}catch(Exception e){
		ezc.ezcommon.EzLog4j.log("Problem occured wile creating PR in SAP>>>"+e,"I");
		errorFlag= true;
		dispMessage +="Problem occured while creating PR in SAP";
	}
	ReturnObjFromRetrieve outRet = new ReturnObjFromRetrieve(new String[]{"PR_NUM","TYPE","CODE","MESSAGE","LOG_NO","LOG_MSG_NO","MESSAGE_V1","MESSAGE_V2","MESSAGE_V3","MESSAGE_V4"});
	
	try {
	JCO.Table retOut = function.getTableParameterList().getTable("RETURN");
	String prNum = null;
	JCO.ParameterList expParam = function.getExportParameterList();
	prNum=(String)expParam.getValue("NUMBER");
	int poCount = retOut.getNumRows();
	if(poCount>0)
	{
	   do
	   {
			outRet.setFieldValue("PR_NUM", prNum);
			outRet.setFieldValue("TYPE", retOut.getValue("TYPE"));
			outRet.setFieldValue("CODE",retOut.getValue("CODE"));
			outRet.setFieldValue("MESSAGE",retOut.getValue("MESSAGE"));
			outRet.setFieldValue("LOG_NO",retOut.getValue("LOG_NO"));
			outRet.setFieldValue("LOG_MSG_NO",retOut.getValue("LOG_MSG_NO"));
			outRet.setFieldValue("MESSAGE_V1",retOut.getValue("MESSAGE_V1"));
			outRet.setFieldValue("MESSAGE_V2",retOut.getValue("MESSAGE_V2"));
			outRet.setFieldValue("MESSAGE_V3",retOut.getValue("MESSAGE_V3"));
			outRet.setFieldValue("MESSAGE_V4",retOut.getValue("MESSAGE_V4"));
			outRet.addRow();
		}
		while(retOut.nextRow());
	}
	
	for(int a=0;a<outRet.getRowCount();a++)
	{
		String type = outRet.getFieldValueString(a,"TYPE");
		sapReqNumber = outRet.getFieldValueString(a,"PR_NUM");
		if("E".equals(type.trim()))
		{
			dispMessage +="<BR>Error:"+outRet.getFieldValueString(a,"MESSAGE");
			errorFlag = true;
			break;
		}

	}
	} catch (Exception e) {}
	finally{
		if (client!=null){
			//log("R E L E A S I N G   C L I E N T .... ");
			JCO.releaseClient(client);
			client = null;
			function=null;
		}
	}
	
	
	if(!errorFlag && sapReqNumber!=null && !"".equals(sapReqNumber.trim()))
	{
		dispMessage = "Purchase Requisition created in SAP with number "+sapReqNumber;
	}
%>

<html>
<head>
<script>
var tabHeadWidth=96
var tabHeight="65%"
</script>
<script src="../../Library/JavaScript/ezTabScroll.js"></script>
<script>
	function sendBack()
	{
		//document.myForm.action="";
		//document.myForm.submit();
	}

	function reLoad(action)
	{
		if(action == 'Y')
		{
			sendBack();
		}	
		else
		{
			setTimeout("reLoad('Y')",1000);
		}

	}
	
</script>
<script language="Javascript1.2">
	am = "This function is disabled!";
	bV  = parseInt(navigator.appVersion)
	bNS = navigator.appName=="Netscape"
	bIE = navigator.appName=="Microsoft Internet Explorer"
	function nrc(e) 
	{
	   if (bNS && e.which > 1)
	   {
	      alert(am)
	      return false
	   } 
	   else if (bIE && (event.button >1)) 
	   {
	     alert(am)
	     return false;
	   }
	}
	document.onmousedown = nrc;
	if (document.layers) window.captureEvents(Event.MOUSEDOWN);
	if (bNS && bV<5) window.onmousedown = nrc;
	
	
	
	function goBack()
	{
		history.go(-1);
	}
	
</script>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>

</head>
<body onLoad="reLoad('N')">
<%
	String display_header = "";
%>	
		
	<%@ include file="../Misc/ezDisplayHeader.jsp"%>

	<form name="myForm" method="post">
	<div id="nocount" style="position:absolute;top:0%;width:100%">

		<br><br><br><br>
		<TABLE width="50%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
		<tr align="center">
		<th>
		<%=dispMessage%>
		</th>
		</tr></table>
	</div>


		<Div id="back" align=center style="position:absolute;top:90%;visibility:visible;width:100%">
<%		
			if(errorFlag)
			{
				buttonName = new java.util.ArrayList();
				buttonMethod = new java.util.ArrayList();

				buttonName.add("&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
				buttonMethod.add("goBack()");

				out.println(getButtonStr(buttonName,buttonMethod));	
			}
			
%>
			
			
		</Div>
	</form>	
	<Div id="MenuSol"></Div>
	</body>
</html>		
