<%@ page import = "ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO,ezc.ezparam.*" %>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<%
	FormatDate fD=new FormatDate();

	com.sap.mw.jco.JCO.Client client = null;

	String systemKey = (String)session.getValue("SYSKEY");
	String site = (String)session.getValue("Site");
	String connStr 		= "642~999";
	if(systemKey!=null)
		connStr = site+"~"+systemKey.substring(0,3);
			
	java.util.Hashtable purgrphash	=  (java.util.Hashtable)session.getValue("PURGROUPS");
	
	
	String purGrp = "";
				
	if(purgrphash!=null)
		purGrp = (String)purgrphash.get(systemKey);
	
	com.sap.mw.jco.JCO.Function function = EzSAPHandler.getFunction("Z_EZ_GET_PRS",connStr);
        com.sap.mw.jco.JCO.ParameterList sapPreProc = function.getImportParameterList();
        
        client = EzSAPHandler.getSAPConnection(connStr);

        sapPreProc.setValue(purGrp, "PUR_GROUP");
        //sapPreProc.setValue(ext1, "RELEASE_FLAG");
       // sapPreProc.setValue("BP01", "PLANT");
       // sapPreProc.setValue(material, "MATERIAL");
       // sapPreProc.setValue(fromDeliv, "FROM_DATE");
       // sapPreProc.setValue(toDeliv, "TO_DATE");
            
        try{
		client.execute(function);
	}catch(Exception e){}
        
        
        ReturnObjFromRetrieve myRet=new ReturnObjFromRetrieve(new String[]{"REQNO","ITEM","REQDATE","REL_DATE","DESCRIPTION","MATERIAL","PLANT","QUANTITY","UNIT","DELIV_DATE","CREATED_BY","TRACKING_NO","INT_ORDER","VAL_TYPE"});
	try {
		JCO.Table sapPurchReqList = function.getTableParameterList().getTable("REQUISITION_ITEMS");
		
		//out.println(sapPurchReqList);

		int poCount = sapPurchReqList.getNumRows();
		if(poCount>0)
		{
			do{

				myRet.setFieldValue("REQNO", sapPurchReqList.getValue("PREQ_NO"));			//"BANFN"
				myRet.setFieldValue("ITEM",sapPurchReqList.getValue("PREQ_ITEM"));			//"BNFPO"
				myRet.setFieldValue("REQDATE",sapPurchReqList.getValue("PREQ_DATE"));		//"BADAT"
				myRet.setFieldValue("DELIV_DATE",sapPurchReqList.getValue("DELIV_DATE"));	//"LFDAT"
				myRet.setFieldValue("REL_DATE",sapPurchReqList.getValue("REL_DATE"));		//"FRGDT"
				myRet.setFieldValue("DESCRIPTION",sapPurchReqList.getValue("SHORT_TEXT"));	//"TXZ01"
				myRet.setFieldValue("MATERIAL",sapPurchReqList.getValue("MATERIAL"));		//"MATNR"
				myRet.setFieldValue("PLANT",sapPurchReqList.getValue("PLANT"));			//"WERKS"
				myRet.setFieldValue("QUANTITY",sapPurchReqList.getValue("QUANTITY"));		//"MENGE"
				myRet.setFieldValue("UNIT",sapPurchReqList.getValue("UNIT"));				//"MEINS"
				myRet.setFieldValue("CREATED_BY",sapPurchReqList.getValue("CREATED_BY"));	//"ERNAM"
				myRet.setFieldValue("TRACKING_NO",sapPurchReqList.getValue("TRACKINGNO"));
				myRet.setFieldValue("INT_ORDER",sapPurchReqList.getValue("PROMOTION"));
				myRet.setFieldValue("VAL_TYPE",sapPurchReqList.getValue("VAL_TYPE"));
				myRet.addRow();

			}
			while(sapPurchReqList.nextRow());
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
	
	int myRetCount = myRet.getRowCount();
	
	//out.println(myRet.toEzcString());
%>



<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@page import="java.util.*"%>
<%
String divHgt = "70";
%>
<html>
<head>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
	<Script src="../../Library/JavaScript/ezTrim.js"></Script>
	<Script>
		var tabHeadWidth = 98;
		var tabHeight="65%";
		if(screen.width==800)
		{
			tabHeight="57%";
		}
		
		function goToPlantAddr(plant)
		{
			window.open("../Purorder/ezPlantAddress.jsp?plant="+plant,"plantdet", "status=no,toolbar=no,menubar=no,location=no,left=280,top=200,width=350,height=320");
		}
		function vendorList()
		{
			if(!checkRoleAuthorizations("VIEW_SOURCE"))
			{
				alert("You are not authorized to view Source List");
				return;
			}
			var chkObj 	= document.myForm.purchReq;
			var chkLen	= chkObj.length;
			var chkValue	= "";
			var count	= 0;
			if(!isNaN(chkLen))
			{
				for(i=0;i<chkLen;i++)
				{
					if(chkObj[i].checked)
					{
						count++;
						chkValue = chkValue+chkObj[i].value+"##";		
					}
				}
			}
			else
			{
				if(chkObj.checked)
				{
					count = 1;
					chkValue = chkValue+chkObj.value+"##";
				}
			}
			if(count == 0)
			{
				alert("Please select atleast one Purchase Requisition");
				return;
			}
		
			var mainToken	= chkValue.split("##");
			
			var tokensLen	= mainToken.length-1;
		
			var material;
			var plant;
			var delDate;
			var qty	= 0;
			var uom;
			var matDesc;
			var prno;
			var itmno;
			var valtype;
			if(!isNaN(tokensLen))
			{
			alert(tokensLen)
				var childToken	= mainToken[0].split("$$");
				material	= childToken[0];
				plant		= childToken[1];
				qty		= childToken[3];
				delDate		= childToken[2];
				uom		= childToken[4];
				matDesc		= childToken[5];
				prno		= childToken[6];
				itmno		= childToken[7];
				valtype		= childToken[8];
				a=delDate.split(".");
				var mm = parseInt(a[1],10)-1;
				var dlvrDate  = new Date(a[2],mm,a[0]);
				
			
				for(j=1;j<tokensLen;j++)
				{
					var childToken	= mainToken[j].split("$$");
		
					var material1	= childToken[0];
					var plant1	= childToken[1];
					var qty1	= childToken[3];
					var delDate1	= childToken[2];
					
					b=delDate1.split(".");
					var mm1 = parseInt(b[1],10)-1;
					var cmprDate  = new Date(b[2],mm1,b[0]);
		
					/*if(delDate<delDate1)
					{
						delDate = delDate1; 
					}*/
					
					if(dlvrDate<cmprDate)
					{
						delDate = delDate1; 
					}
					//alert(delDate);
		
					if(funTrim(material) == funTrim(material1))
					{
						if(funTrim(plant) == funTrim(plant1))
						{
							qty = parseInt(qty)+parseInt(qty1);	
						}
						else
						{
							alert("Please select material with same Plant to get Vendors");
							return;
						}
					}
					else
					{
						alert("Please select same Material to get Vendors");
						return;
					}
				}	
			}
			
			buttonsSpan	  = document.getElementById("EzButtonsSpan")
			buttonsMsgSpan	  = document.getElementById("EzButtonsMsgSpan")
			if(buttonsSpan!=null)
			{
			     buttonsSpan.style.display		= "none"
			     buttonsMsgSpan.style.display	= "block"
		     	}
			document.myForm.purchReq.value		= material+"$$"+plant+"$$"+delDate+"$$"+qty+"$$"+uom+"$$"+matDesc+"$$"+prno;
			document.myForm.purchaseHidden.value	= material+"$$"+plant+"$$"+delDate+"$$"+qty+"$$"+uom+"$$"+matDesc+"$$"+prno+"$$"+itmno+"$$"+valtype;
			document.myForm.action			= "../RFQ/ezVendorViewList.jsp";
			document.myForm.submit();
		}
		
	</Script>
	<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
</head>
<body onLoad="scrollInit()" onResize="scrollInit()" scroll=no>
<form name="myForm" method="post">
<input type=hidden name="purchaseHidden">
<input type ="hidden" name="reasons" value ="PR">
<%
	
	String display_header = "List Of Purchase Requisitions";
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<%
	if(myRetCount==0)
	{
%>
	<br><br><br><br><br>
	<Table width=50% align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
		<Tr>
			<Th>No Purchase Requisitions exist to List</th>
		</Tr>
	</Table>
	
	<Div id="back" align=center style="position:absolute;top:91%;visibility:visible;width:100%">
<%
   
%>

</Div>
<%
	}
	else
	{	
%>
<br>
<Div id="theads">
<Table id="tabHead" width="98%" align=center  border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
      <tr>
        <th align="center" width="4%">&nbsp;</th>
        <th align="center" width="8%">PR No</th>
        <th align="center" width="7%">Line No</th>
        <th align="center" width="8%">Material</th>
        <th align="center" width="15%">Description</th>
        <th align="center" width="4%">UOM</th>
        <th align="center" width="9%">Quantity</th>
        <th align="center" width="5%">Plant</th>
        <th align="center" width="10%">Created Date</th>
        <th align="center" width="10%">Delivery Date</th>
     </tr>
</Table>
</Div>

<Div id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;left:2%">
<Table  id="InnerBox1Tab" width="100%" align=center  border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
<%
	java.util.Date currDate   = new java.util.Date();
	java.util.Date chkDelDate = null;
	long days = 0;
	boolean showStr = false,showLabel=false;
	ezc.ezutil.FormatDate fd = new ezc.ezutil.FormatDate();
	String  reqno="",item="",material="",myMatDesc="",criticalDelv="",delvStat="",reNotify="N";
	for(int i=0;i<myRetCount;i++)
	{
		try
		{
			reqno=""+Long.parseLong(myRet.getFieldValueString(i,"REQNO"));
		}
		catch(Exception e)
		{
			reqno=myRet.getFieldValueString(i,"REQNO");
		}
		try
		{
			item=""+Long.parseLong(myRet.getFieldValueString(i,"ITEM"));
		}
		catch(Exception e)
		{	
			item=myRet.getFieldValueString(i,"ITEM");
		}
		try
		{
			material=""+Long.parseLong(myRet.getFieldValueString(i,"MATERIAL"));
		}
		catch(Exception e)
		{
			material=myRet.getFieldValueString(i,"MATERIAL");
		}
	
		myMatDesc = myRet.getFieldValueString(i,"DESCRIPTION");

%>
		<Tr>
		
			<td align="center" width="4%"><input type=checkbox name=purchReq value='<%=myRet.getFieldValueString(i,"MATERIAL")+"$$"+myRet.getFieldValueString(i,"PLANT")+"$$"+fd.getStringFromDate((Date)myRet.getFieldValue(i,"DELIV_DATE"),".",ezc.ezutil.FormatDate.DDMMYYYY)+"$$"+myRet.getFieldValueString(i,"QUANTITY")+"$$"+myRet.getFieldValueString(i,"UNIT")+"$$"+myMatDesc+"$$"+myRet.getFieldValueString(i,"REQNO")+"$$"+myRet.getFieldValueString(i,"ITEM")+"$$"+myRet.getFieldValueString(i,"VAL_TYPE")%>'></td>
			<td align="center" width="8%"><%=reqno%></td>
			<td align="center" width="7%"><%=item%></td>
			<td align="left"   width="8%"><%=material%></td>
			<td align="left"   width="15%"><input type=text size=25 value="<%=myRet.getFieldValueString(i,"DESCRIPTION")%>" title="<%=myRet.getFieldValueString(i,"DESCRIPTION")%>" class="tx"  readonly></td>
        		<td align="center" width="4%"><%=myRet.getFieldValueString(i,"UNIT")%></td>
			<td align="right"  width="9%"><%=myRet.getFieldValueString(i,"QUANTITY")%></td>
			<td align="center" width="5%">
			<a href="Javascript:void(0)" onClick="goToPlantAddr('<%=myRet.getFieldValueString(i,"PLANT")%>')"  onMouseover="window.status='Click to view the Plant Address. '; return true" onMouseout="window.status=' '; return true">
			<%=myRet.getFieldValueString(i,"PLANT")%>
			</a>
			</td>
			<td align="center" width="10%"><%=fD.getStringFromDate((java.util.Date)myRet.getFieldValue(i, "REQDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%></td>
			<td align="center" <%=criticalDelv%>width="10%"><%=fD.getStringFromDate((java.util.Date)myRet.getFieldValue(i, "DELIV_DATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%></td>
		</Tr>
<%
	}
%>
</Table>
</Div>
<br>
<Div id="buttonDiv" align=center style="position:absolute;top:91%;visibility:visible;width:100%">
	<span id="EzButtonsSpan" > 

<%
/*
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("&nbsp;&nbsp;&nbsp;Withdraw&nbsp;&nbsp;Requisition&nbsp;&nbsp;&nbsp;");
	buttonMethod.add("");

	buttonName.add("&nbsp;&nbsp;&nbsp;Forward&nbsp;&nbsp;To&nbsp;&nbsp;&nbsp;");
	buttonMethod.add("");

	buttonName.add("&nbsp;&nbsp;&nbsp;Display&nbsp;&nbsp;SAP&nbsp;&nbsp;Workflow&nbsp;&nbsp;Tree&nbsp;&nbsp;&nbsp;");
	buttonMethod.add("");

	out.println(getButtonStr(buttonName,buttonMethod));*/
	
	buttonName.add("&nbsp;&nbsp;&nbsp;Get&nbsp;&nbsp;Sources&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
	buttonMethod.add("vendorList()");
	
	out.println(getButtonStr(buttonName,buttonMethod));
%>			
	
</span>
	<span id="EzButtonsMsgSpan" style="display:none">
	<Table align=center>
		<Tr>
			<Td class="labelcell">Your request is being processed... Please wait</Td>
		</Tr>
	</Table>
	</span>
</Div>

<%
	}
%>
</Form>
<Div id="MenuSol"></Div>
</body>
</html>
