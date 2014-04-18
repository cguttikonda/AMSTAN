<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@include file="../../../Includes/JSPs/Rfq/iViewRFQDetails.jsp"%>
<%@page import="ezc.ezutil.*"%>
<jsp:useBean id="Manager" class="ezc.ezpreprocurement.client.EzPreProcurementManager" />	
<%
	//String rfqStatus = "";
	ezc.ezcommon.EzLog4j.log("****=RFQ" ,"I");
	ezc.ezparam.EzcParams rfqParams  = new ezc.ezparam.EzcParams(false);
	ezc.ezpreprocurement.params.EziRFQHeaderParams ezirfqheaderparams = new ezc.ezpreprocurement.params.EziRFQHeaderParams();
	ezirfqheaderparams.setRFQNo(poNum);
	ezirfqheaderparams.setSysKey((String)session.getValue("SYSKEY"));
	rfqParams.setObject(ezirfqheaderparams);
	rfqParams.setLocalStore("Y");
	Session.prepareParams(rfqParams);

	ezc.ezpreprocurement.params.EzoRFQHeaderParams ezoRFQheaderparams = (ezc.ezpreprocurement.params.EzoRFQHeaderParams)Manager.ezGetRFQDetails(rfqParams);

	ezc.ezcommon.EzLog4j.log("****==before==Closing PRS==rfqHeader===**","I");
	ezc.ezparam.ReturnObjFromRetrieve rfqHeaderStatus  = (ezc.ezparam.ReturnObjFromRetrieve)ezoRFQheaderparams.getRFQHeader();
	//rfqHeaderStatus.getFieldValueString(0,"STATUS");
	ezc.ezcommon.EzLog4j.log("****=RFQ Header==**"+rfqHeaderStatus.toEzcString(),"I");
	String rfqStatus = "";
	
	if(rfqHeaderStatus!=null && rfqHeaderStatus.getRowCount()>0)
	{
		rfqStatus = rfqHeaderStatus.getFieldValueString(0,"STATUS");
	}
%>
<html>
<head>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
	<script>

	function goToPlantAddr(plant)
	{
		window.open("../Purorder/ezPlantAddress.jsp?plant="+plant,"plantdet", "status=no,toolbar=no,menubar=no,location=no,left=280,top=200,width=350,height=320");
	}
	function viewSchedules()
	{
		buttonhide();
		document.forms[0].action = "ezViewDeliverySchedules.jsp"
		document.forms[0].submit();
	}
	function goBack(){
		document.forms[0].action ="ezListRFQs.jsp?type=<%=request.getParameter("type")%>";
		document.forms[0].submit();
	}
	function funQuote()
	{
		buttonhide();
		document.forms[0].action = "ezPostQuote.jsp"
		document.forms[0].submit();
	}
	function funView()
	{
		buttonhide();                
		document.forms[0].action = "ezViewQuoteDetails.jsp"
		document.forms[0].submit();
	}
	function funCreatePO()
	{
		buttonhide();
		document.myForm.action = "ezJCOPOCreate.jsp"
		document.myForm.submit(); 
	}
	function buttonhide()
	{
		buttonsSpan	  = document.getElementById("EzButtonsSpan");
		buttonsMsgSpan	  = document.getElementById("EzButtonsMsgSpan");
		if(buttonsSpan!=null)
		{
			buttonsSpan.style.display	= "none"
			buttonsMsgSpan.style.display	= "block"
		}
	}
	
	</script>
<Script>
var tabHeadWidth=96
var tabHeight="65%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
</head>

<body bgcolor="#FFFFF7" onLoad="scrollInit('SHOWTOT')" onResize="scrollInit('SHOWTOT')">
<form  name="myForm">
<%			
		Date toDate = new Date();
		String[] rfqDatearr = new String[3];
		StringTokenizer stDate = new StringTokenizer(CDate,"/");
		int x=0;
		while (stDate.hasMoreTokens()) 
		{
			rfqDatearr[x] = stDate.nextToken();
			x++;
		}
		Date rfqEndDate =null;
		
		try{
		 	rfqEndDate = new Date((Integer.parseInt(rfqDatearr[2])-1900),Integer.parseInt(rfqDatearr[0])-1,Integer.parseInt(rfqDatearr[1])); 			
		}catch(Exception e){}
		int compDate = rfqEndDate.compareTo(toDate);			
		
		//out.println(rfqEndDate+":::::"+toDate);
		
		ezc.ezutil.FormatDate fd = new ezc.ezutil.FormatDate();
		String OrderDate = fd.getStringFromDate(ordDate,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
		String display_header	= "RFQ Details";
		
%>
	<input type="hidden" name="type" value=<%=request.getParameter("type")%>>
	<input type="hidden" name="EndDate" value="<%=CDate%>">
	<input type="hidden" name="OrderDate" value="<%=OrderDate%>">
	<input type="hidden" name="PurchaseOrder" value="<%=poNum%>">
	
 	<%@ include file="../Misc/ezDisplayHeader.jsp" %>
 	<Div id='inputDiv' style='position:relative;align:center;top:2%;width:100%;'>
			<Table width="40%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
			<Tr>
				<Td height="5" style="background-color:'#F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
				<Td height="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
				<Td height="5" style="background-color:'#F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
			</Tr>
			<Tr>
				<Td width="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
				<Td style="background-color:'#F3F3F3'" valign=middle>
					<Table border="0" align="center" valign=middle width="100%" class=welcomecell>
						<Tr>
							<Td style="background-color:'#F3F3F3';" align='center'>
								<font size=2><B>RFQ&nbsp;:&nbsp;</B><%=Long.parseLong(poNum)%></font>
							</Td>
							<Td style="background-color:'#F3F3F3';" align='center'>
								<font size=2><B>RFQ Date&nbsp;:&nbsp;</B><%=OrderDate%></font>
							</Td>
						</Tr>
					</Table>
				</Td>
				<Td width="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif"></Td>
			</Tr>
			<Tr>
				<Td width="5" style="background-color:'#F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
				<Td height="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
				<Td width="5" style="background-color:'#F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
			</Tr>
			</Table>
		</Div>			
 	<br><br>

	<DIV id="theads">
 	<table id="tabHead" width="96%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
 	<tr align="center" valign="middle">
    	<th width="8%">Line</th>
    	<th width="22%">Material</th>
      	<th width="38%">Description</th>
      	<th width="8%">UOM</th>
     	<th width="12%">Qty</th>
     	<th width="10%">Plant</th>
 	</tr>
 	</table>
 	</div>

	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:96%;height:60%;left:2%">
	<table id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0  width="100%">
<%
	//out.println("::::dtlXML:::"+dtlXML.toEzcString());

   	for(int i=0;i<Count;i++)
   	{
		String curr = dtlXML.getFieldValueString(i,"AMOUNT");
		String net  = dtlXML.getFieldValueString(i,"NET_VALUE");
		String myQty = dtlXML.getFieldValueString(i,"ORDEREDQUANTITY");
		try
		{
			/*Double dddd=new Double(Double.parseDouble(net));
			int tt1=dddd.intValue();
			Double ddde=new Double(Double.parseDouble(curr));
			int tt2=ddde.intValue();
			myQty = tt1/tt2;
			
			java.math.BigDecimal netBDValue = new java.math.BigDecimal(net);
    			java.math.BigDecimal currBDValue = new java.math.BigDecimal(curr);
			myQty = netBDValue.divide(currBDValue, 2, java.math.BigDecimal.ROUND_FLOOR).toString();
			*/
			
			myQty  = new java.math.BigDecimal(myQty).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
		}
		catch(Exception e){}

%>
     		<tr>
      		<td width="8%"><%=dtlXML.getFieldValueString(i, "POSITION")%></td>
      		<td width="22%">
<%		try{
				out.println(Long.parseLong(dtlXML.getFieldValueString(i,"ITEM")));
		}catch(Exception e){
				out.println(dtlXML.getFieldValueString(i,"ITEM"));
		}
%>
		</td>
      		<td width="38%"><%=dtlXML.getFieldValueString(i,"ITEMDESCRIPTION")%></td>
      		<td align="center" width="8%"><%=dtlXML.getFieldValueString(i,"UOMPURCHASE")%></td>
      		<!--<td align="right" width="12%"><%=dtlXML.getFieldValueString(i,"ORDEREDQUANTITY")%></td>-->
      		<td align="right" width="12%"><%=myQty%></td>
      		<td align="center" width="10%"><a href="JavaScript:void(0)" onClick=goToPlantAddr('<%=dtlXML.getFieldValueString(i,"PLANT")%>')><%=dtlXML.getFieldValueString(i,"PLANT")%></a>&nbsp;</td>
    		</tr>
<%
	}
%>
  	</table>
	</div>
	<!--
 	<div align='center' style='position:absolute;top:88%'>
 	<table align="center" width="100%" >
 	<tr align="center">
 	<td class=blankcell> -->
	<!--<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand" border=none onClick="javascript:goBack()">-->
 	<!--<a href="#" onClick="openPrintWindow()"><img  src="../../Images/Buttons/<%=ButtonDir%>/printversion.gif" border="none" style="cursor:hand"></a>-->
	<! -- if (("3".equals(UserType)) && (closingDate.after(today) || closingDate.equals(today)) ){ -->
	
	<!--
	<% if (("3".equals(UserType))  ){
	   if(compDate>=0)
	   {
	%>
	 	<a href="../Rfq/ezPostQuote.jsp?PurchaseOrder=<%=poNum%>&EndDate=<%=CDate%>&OrderDate=<%=OrderDate%>"><img  src="../../Images/Buttons/<%=ButtonDir%>/quote.gif" border="none" style="cursor:hand" onMouseover="window.status='Click to Post Quote. '; return true" onMouseout="window.status=' '; return true"></a>
	<%}}else if ((QuotNo!=null)&&(QuotNo.trim().length() > 0)){%>
	 	<a href="../Rfq/ezViewQuoteDetails.jsp?PurchaseOrder=<%=poNum%>&EndDate=<%=CDate%>&OrderDate=<%=OrderDate%>"><img  src="../../Images/Buttons/<%=ButtonDir%>/viewquote.gif" border="none" style="cursor:hand" onMouseover="window.status='Click to view Quote. '; return true" onMouseout="window.status=' '; return true"></a>
	<%}%>

 	<a href="JavaScript:viewSchedules()" onMouseover="window.status='Click to view Delivery Schedules. '; return true" onMouseout="window.status=' '; return true"><img  src="../../Images/Buttons/<%=ButtonDir%>/viewdelschedules.gif" border="none" style="cursor:hand"></a>
	</td>
   	</tr>
  	</table>
	</div>
	-->
	
	<div id="ButtonDiv" style="position:absolute;top:80%;width:100%;visibility:visible">
	<center>
<%	
	if("C".equals(rfqStatus))
	{
%>	
		<font color=red >RFQ closed as PO is created against this RFQ</font>
<%
	}
%>

<Div id="buttonDiv" align="center" style="position:absolute;left:0%;width:100%;top:90%">
<span id="EzButtonsSpan" >
	<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
	
		buttonName.add("Back");
		buttonMethod.add("goBack()");
		
		
		
		/*if(("3".equals(UserType)) && compDate>=0 && !("Y".equals(rfqStatus) || "C".equals(rfqStatus)))
		{
			buttonName.add("Quote");
			buttonMethod.add("funQuote()");
		}
		else if ((QuotNo!=null)&&(QuotNo.trim().length() > 0))
		{
			buttonName.add("ViewQuotation");
			buttonMethod.add("funView()");
			
			if("Y".equals(rfqStatus) && !("3".equals(UserType)))
			{
				buttonName.add("Create&nbsp;PO");
				buttonMethod.add("funCreatePO()");
			}
			
		}*/
		
		if(("3".equals(UserType)) && compDate>=0 && (QuotNo==null || QuotNo=="" || "".equals(QuotNo)))
		{
			buttonName.add("Quote");
			buttonMethod.add("funQuote()");
		}
		else if ((QuotNo!=null)&&(QuotNo.trim().length() > 0))
		{
			buttonName.add("ViewQuotation");
			buttonMethod.add("funView()");

			if(!("3".equals(UserType)))
			{
				buttonName.add("Create&nbsp;PO");
				buttonMethod.add("funCreatePO()");
			}
					
		}
		
		buttonName.add("View Delivery Schedules");
		buttonMethod.add("viewSchedules()");
		
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
	
	</center>
	</div>
	<%@ include file="../Misc/AddMessage.jsp" %>
	
</form>
<Div id="MenuSol"></Div>
</body>
</html>
