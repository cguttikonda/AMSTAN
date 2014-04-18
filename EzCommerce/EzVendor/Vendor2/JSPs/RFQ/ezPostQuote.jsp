<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@include file="../../../Includes/JSPs/Rfq/iViewRFQDetails.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<%@page import="ezc.ezutil.*,java.util.*"%>
<jsp:useBean id="ConfigManager" class="ezc.client.EzSystemConfigManager" scope="session"></jsp:useBean>
<html>
<head>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<Script>
var tabHeadWidth=94
var tabHeight="35%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
	<script>
	function funLineValid()
	{
		len=document.myForm.Price.length;
		if(isNaN(len))
		{
			if(document.myForm.Price.value=="")
			{
				alert("Please Enter Price of the Material");
				return false;
			}
			else
				return true;
		}
		else
		{
			var bool="false"
			for(var i=0;i<len;i++)
			{
				if(document.myForm.Price[i].value!="")
				{
					var bool="true"
					return true;
				}
			}
			if(bool=="false")
			{
				alert("Please Enter the price for atleast one material");
				return false;
			}
		}
	}
	function funOpen()
	{
		values=document.myForm.allconditions.value;
		dialogvalue=window.showModalDialog("../Rfq/ezAllConditions.jsp",values,"center=yes;dialogHeight=30;dialogWidth=25;help=no;titlebar=no;status=no;resizable=no")
		if ((dialogvalue=='Canceld~~')||(dialogvalue==null)){
		}
		else{
			document.myForm.allconditions.value=dialogvalue;
		}
	}
	function SubmitQuote(){
		if (document.myForm.QtnRef.value==""){
			alert("Please enter Qtn. Ref. No");
			document.myForm.QtnRef.focus();
			return false;
		}
		else if (document.myForm.QtnDate.value==""){
			alert("Please enter Qtn. Date");
			return false;
		}else if (document.myForm.PaymentTerms.value==""){
			alert("Please Select Payment terms from the List.");
			document.myForm.PaymentTerms.focus()
			return false;
		}else if (document.myForm.IncoTerms.value==""){
			alert("Please Select Inco Terms from the List.");
			document.myForm.IncoTerms.focus()
			return false;
		}else if (!funLineValid()){
			return false
		}
		else
		{
			buttonhide();
			document.forms[0].action="ezQuotationSave.jsp";
			document.forms[0].submit();
		}
	}
	function goBack(){
		document.forms[0].action = "ezViewRFQDetails.jsp"
		document.forms[0].submit();
	}
	function funReset(){
			document.myForm.reset();
			
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
</Head>
<body onLoad="scrollInit()" onResize="scrollInit()">
<form name="myForm" method="post">
	<input type="hidden" name="EndDate" value="<%=CDate%>">
	<input type="hidden" name="OrderDate" value="<%=OrderDt%>">
	<input type="hidden" value="<%=poNum%>" name="PurchaseOrder">
	<input type="hidden" name="type" value=<%=request.getParameter("type")%>>
<%
	String display_header	= "Quotation";
%>
	<%@ include file="../Misc/ezDisplayHeader.jsp" %>
	<br>
	
	<table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0  width="94%">
	<tr>
		<th align="left" width="20%">RFQ Ref. No</th>
      		<td valign="middle" align="left" width="20%"><input type="hidden" name="RfqNo" value="<%=poNum%>"><%=poNum%></td>
		<th align="left" width="20%">RFQ Date</th>
        	<td valign="middle" align="left" width="20%"><%=OrderDt%></td>
	</tr>
	<tr>
		<th align="left" width="20%">Qtn. Ref. No</th>
      		<td valign="middle" align="left" width="20%">
<%
		String quotation="";
		String qtndate=FormatDate.getStringFromDate(new Date(),".",FormatDate.DDMMYYYY);
		if (retHead.getRowCount() > 0){
			quotation = retHead.getFieldValueString(0,"QUOTATION");
  			/*if (retHead.getFieldValue(0,"QUOTDATE")!=null)
				 qtndate=FormatDate.getStringFromDate((Date)retHead.getFieldValue(0,"QUOTDATE"),".",FormatDate.DDMMYYYY);
			*/
		}
%>
       		<input type="text" class=InputBox  name="QtnRef" maxlength="10" size="15" value="<%=quotation%>">
		</td>
		<th align="left" width="20%">Qtn. Date</th>
      		<td valign="middle" align="left" width="20%"><%=FormatDate.getStringFromDate(new Date(),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%><input type="hidden" name="QtnDate" value="<%=qtndate%>">
        	<!--<img src="../../Images/Common/calender.gif" height="20" style="cursor:hand" onClick='showCal("document.forms[0].QtnDate",0,300,"<%=cDate%>","<%=cMonth%>","<%=cYear%>")'>-->
		</td>
	</tr>
	</table>
	
	<div id="bottompart" style="overflow:auto;position:absolute;width:100%;visibility:visible" align="center">
		<table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0  width="94%">
		<tr>
		<th align="left" width="20%">Payment terms</th>
		<td width="30%">
			<select id="CalendarDiv" name=PaymentTerms style="width:100%">
			<option value="">Select Payment Terms</option>
<%
			String payterm="0001";//This is hardcoded as requested by US Sales Team.
			String incoterm="FOB";//This is hardcoded as requested by US Sales Team.
	
			if (retHead.getRowCount() > 0)
			{
				payterm=retHead.getFieldValueString(0,"PMNTTERM");
				incoterm=retHead.getFieldValueString(0,"INCOTERM1");
			}
			payterm="0001";
			incoterm="FOB";
			
			while(payIterator.hasNext())
			{
				payObj = payIterator.next();
				String payStr = payObj.toString();
				if(payStr.equals(payterm))
				{
%>
					<Option value=<%=payStr%> selected><%=payStr%>--><%=payTM.get(payStr)%></Option>
<%
				}
				else
				{
%>
					<Option value=<%=payStr%> ><%=payStr%>--><%=payTM.get(payStr)%></Option>
<%
				}
			}
%>
			</select>
	
		</td>
		<th align="left" width="20%">Inco Terms</th>
		<td width="30%">
		<select name=IncoTerms  style="width:100%">
		<option value="">Select Inco Terms</option>
<%
	      	while(incoIterator.hasNext())
		{
			incoObj = incoIterator.next();
			String incoStr = incoObj.toString();
			if(incoStr.equals(incoterm))
			{
			%>
				<Option value=<%=incoStr%> selected><%=incoStr%>--><%=incoTM.get(incoStr) %></Option>
			<%
			}
			else
			{
			%>
				<Option value=<%=incoStr%> ><%=incoStr%>--><%=incoTM.get(incoStr) %></Option>
			<%
			}
		}
%>
		</select>
		</td>
		</tr>
		
		<Tr >
		<Th align="left" width="20%">Remarks</Th>
<%
		String remks = "";
		try{
			if (htexts.get(poNum)!=null)
				remks =(String)htexts.get(poNum);
		}catch(Exception ex){
		}
%>
		<td colspan=3 width="80%"><textarea name="Remarks" rows=1 style="width:100%;overflow:auto"><%=remks%></textarea></td>
		</TR>
		</table>
	</div>
	
	<br><br><br><br>
	<DIV id="theads">
  	<table id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0  width="94%">
    	<tr align="center" valign="middle">
      	<th width="12%">Material</th>
      	<th width="35%">Description</th>
      	<th width="8%">UOM</th>
      	<th width="12%">Qty</th>
      	<th width="12%">Price</th>
      	<th width="21%">Currency</th>
    	</tr>
 	</table>
 	</DIV>

	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:96%;height:60%;left:2%">
	<TABLE id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
 	<%
	String curr="USD";//This is hardcoded as requested by US Sales Team.

	ReturnObjFromRetrieve retcur = null;
	EzcSysConfigParams sparams1 = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams1 = new EzcSysConfigNKParams();
	snkparams1.setLanguage("EN");
	sparams1.setObject(snkparams1);
	Session.prepareParams(sparams1);
	retcur = (ReturnObjFromRetrieve)ConfigManager.getCurrencyDesc(sparams1);

	String fields[]= new String []{ "ECD_LONG_DESC"};
	retcur.sort(fields,true);
	int currLength = retcur.getRowCount();
      	for(int i=0;i<Count;i++)
      	{
      		String net  = dtlXML.getFieldValueString(i,"NET_VALUE");
      		String amt = dtlXML.getFieldValueString(i,"AMOUNT");
      		
      		
      		try
		{
			amt = (Double.parseDouble(amt)*100)+"";
			amt  = new java.math.BigDecimal(amt).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
			
		}catch(Exception e){}
      		
      		
      		
      		//double myQty=100.0;
      		
      		String myQty = dtlXML.getFieldValueString(i,"ORDEREDQUANTITY");
      		
		if( amt!=null)
	      		curr=  dtlXML.getFieldValueString(i,"CURRENCY");
	      	else
	      		curr="USD";//This is hardcoded as requested by US Sales Team.
	      	
	      	curr="USD";
	      	
	      	try
	      	{
	      		/*Double dddd=new Double(Double.parseDouble(net));
			int tt1=dddd.intValue();
			Double ddde=new Double(Double.parseDouble(amt));
			int tt2=ddde.intValue();
			myQty = tt1/tt2;
			
			
			java.math.BigDecimal netBDValue = new java.math.BigDecimal(net);
			java.math.BigDecimal currBDValue = new java.math.BigDecimal(amt);
			myQty = netBDValue.divide(currBDValue, 2, java.math.BigDecimal.ROUND_FLOOR).toString();
			*/
			
			myQty  = new java.math.BigDecimal(myQty).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
			
			
		}
		catch(Exception e){}
	%>
      		<tr>
      		<td width="12%"><input type=hidden name="ItemNo" value="<%=dtlXML.getFieldValueString(i,"POSITION")%>">
			<%
			try{
				out.println(Long.parseLong(dtlXML.getFieldValueString(i,"ITEM")));
			}catch(Exception e){
				out.println(dtlXML.getFieldValueString(i,"ITEM"));
			}
			%>
			</td>
      		<td width="35%"><%=dtlXML.getFieldValueString(i,"ITEMDESCRIPTION")%></td>
      		<td width="8%"><%=dtlXML.getFieldValueString(i,"UOMPURCHASE")%></td>
      		<!--<td width="12%" align="right"><%=dtlXML.getFieldValueString(i,"ORDEREDQUANTITY")%></td>-->
      		<td width="12%" align="right"><%=myQty%><input type="hidden" name="rfqQty" value="<%=myQty%>"></td>
      		<td width="12%"><input type=text name="Price" size=9 style="width:100%;text-align:right" class=InputBox value="<%=amt%>"></td>
      		<td width="21%">
      		<select name="Curr" class=InputBox style="width:100%">

		<%
		for(int j=0;j<currLength;j++)
		{
			if(retcur.getFieldValueString(j,"EC_CURR_KEY").trim().equals(curr))
				out.println("<option value="+retcur.getFieldValueString(j,"EC_CURR_KEY").trim()+" selected>"+retcur.getFieldValueString(j,"ECD_LONG_DESC")+"</option>");
			else
				out.println("<option value="+retcur.getFieldValueString(j,"EC_CURR_KEY").trim()+">"+retcur.getFieldValueString(j,"ECD_LONG_DESC")+"</option>");
		}
		%>
		</select>
     		</td>
     		</tr>
	<%}%>
	</table>
	</div>

	

	<br>
	
	<!---
	<div id="buttons" style="position:absolute;top:92%;width:100%;visibility:visible" align="center">
	<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif"  style="cursor:hand" border=0 onClick="javascript:goBack()">
	<img src="../../Images/Buttons/<%=ButtonDir%>/submit.gif" style="cursor:hand" border=none onClick="JavaScript:SubmitQuote()">
	<img src="../../Images/Buttons/<%=ButtonDir%>/clear.gif" style="cursor:hand" border=none onClick="document.myForm.reset()">
	</div>
	--->
	
	<div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
	<center>
	<%
				buttonName = new java.util.ArrayList();
				buttonMethod = new java.util.ArrayList();
			
				buttonName.add("Back");
				buttonMethod.add("goBack()");
				
				buttonName.add("Submit");
				buttonMethod.add("SubmitQuote()");
				
				buttonName.add("Clear");
				buttonMethod.add("funReset()");
				
				out.println(getButtonStr(buttonName,buttonMethod));
	%>
	</center>
	</div>
	<%@ include file="../Misc/AddMessage.jsp" %>
	
	
	


<input type="hidden" name="allconditions" value="">
</form>
<Div id="MenuSol"></Div>
</body>
</html>
