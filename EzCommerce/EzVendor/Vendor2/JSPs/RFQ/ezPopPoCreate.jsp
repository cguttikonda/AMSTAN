<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%
	String valuationType = request.getParameter("valtype");
	if(valuationType == null || "null".equals(valuationType))
		valuationType = "";
%>
<html>
<head>
<title>Enter PO Creation Details -- Powered By Answerthink India Pvt Ltd.</title>
<head>
<%@include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<%@ include file="../../../Includes/JSPs/Rfq/iSelectIds.jsp"%>
<%@ page import = "java.util.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<SCRIPT src="../../Library/JavaScript/ezCheckFormFields.js"></SCRIPT>
<script>

function showLabel()
{
	var condVal = document.myForm.docType.value;
	if(condVal=='ZCPI' || condVal=='ZFGI' || condVal=='ZRFI' || condVal=='ZRMI')
	{
		document.myForm.ccKey.disabled=false;
		document.myForm.hbId.disabled=false;
		
		document.myForm.ccKey.selectedIndex=2;
	}
	else
	{
		document.myForm.ccKey.selectedIndex=0;
		document.myForm.ccKey.disabled=true;
		document.myForm.hbId.disabled=true;
	}		
}


function closeWin()
{
	
	
	var myDate	= new Date();
	var day		= myDate.getDate();	
	var month	= myDate.getMonth()+1;

	if(day<10)
	   day = "0"+day;	
	if(month<10)
	   month = "0"+month;
	var toDate  = day+"."+month+"."+myDate.getYear();
	
	if(document.myForm.docType.selectedIndex==0)
	{
		alert("Please Select Document Type");
		document.myForm.docType.focus()
		return;
	}
	if(document.myForm.valuationType.selectedIndex==0)
	{
		alert("Please Select valuation Type");
		document.myForm.valuationType.focus()
		return;
	}

	if(document.myForm.ccKey != null)
	{
		if(!(document.myForm.ccKey.disabled) && document.myForm.ccKey.selectedIndex==0)
		{
			alert("Please Select Confirmation Control  Key");
			document.myForm.ccKey.focus()
			return;
		}
	}	
	if(!(document.myForm.hbId.disabled) && document.myForm.hbId.selectedIndex==0)
	{
		alert("Please Select House Bank Id");
		document.myForm.hbId.focus()
		return;
	}

/*	
	if(document.myForm.valuationType.selectedIndex==0)
	{
		alert("Please Select Valuation Type");
		document.myForm.valuationType.focus()
		return;
	}

	if(document.myForm.taxCode.value=="")
	{
		alert("Please Enter Tax Code");
		document.myForm.taxCode.focus()
		return;
	}

	if(document.myForm.deliveryDate.value=="")
	{
		alert("Please Select Delivery Date  From Calendar");
		document.myForm.deliveryDate.focus();
		return;
	}
	else
	{
		sDate = document.myForm.deliveryDate.value;
		selDate = sDate.split(".");
		var sd = new Date();
		var td = new Date();
		var a1 = parseInt(selDate[1],10)-1;

		sd = new Date(selDate[2],a1,selDate[0]);
		var dd=td.getDate();
		var mm=td.getMonth();
		var yy=td.getYear();

		td  = new Date(yy,mm,dd);

		if(sd<td)
		{
			alert("Delivery Date should be greater than or equals to today's date");
			document.myForm.deliveryDate.focus();
			return;
		}
	}

	if(document.myForm.headerText.value=="")
	{
		alert("Please Enter Header Text")
		document.myForm.headerText.focus()
		return;
	}
	if(document.myForm.itemText.value=="")
	{
		alert("Please Enter Item Text ")
		document.myForm.itemText.focus()
		return;
	}
*/
	window.opener = window.dialogArguments;
	opener.document.myForm.vendor.value		= '<%=request.getParameter("vendor")%>';
	opener.document.myForm.quantity.value		= '<%=request.getParameter("Quantity")%>';
	opener.document.myForm.docType.value		= document.myForm.docType.value;
	opener.document.myForm.valuationType.value	= document.myForm.valuationType.value;
	opener.document.myForm.ccKey.value		= document.myForm.ccKey.value;
	opener.document.myForm.hbId.value 		= document.myForm.hbId.value;
	opener.document.myForm.taxCode.value		= document.myForm.taxCode.value;			     	
	opener.document.myForm.headerText.value  	= document.myForm.headerText.value;
	opener.document.myForm.shipInstr.value  	= document.myForm.shipInstr.value;
	opener.document.myForm.itemText.value		= document.myForm.itemText.value;
	window.returnValue =  "SUBMIT";
	window.close();
}
function winclose()
{
	window.returnValue =  "Cancel";
	window.close();
}

</script>
</head>
<body>
<form name="myForm" >

<%	
		/*ResourceBundle TaxC = ResourceBundle.getBundle("EzTaxCodes");
		java.util.TreeMap taxTM = new java.util.TreeMap();
		Enumeration taxEnu =TaxC.getKeys();
		while(taxEnu.hasMoreElements())
		{
			String s2=(String)taxEnu.nextElement();
			taxTM.put(s2,TaxC.getString(s2));
		}*/
		java.util.Hashtable taxTM = new java.util.Hashtable();
		
		taxTM.put("02","CST(VAT)-4%");
		taxTM.put("09","4%CST + ED to Inventory");
		taxTM.put("10","CST - VAT - 2 %");
		taxTM.put("11","VAT 4% Feed Suplements HR");
		taxTM.put("12","VAT 4% API-HR");
		taxTM.put("61","CST- 4%,LST-10%,LST Surcharge-5%");
		taxTM.put("62","CST-4%, LST-8%");
		taxTM.put("63","CST- 4%, LST-8%, LST Surcharge-15%");
		taxTM.put("64","RFCL-Mumbai-CST 4%, LST 4%, LST Sur-10% & TOT-1%");
		taxTM.put("65","RFCL Chennai LST 20+SC5,CST 4%");
		Iterator taxIterator = null;//taxTM.keySet().iterator();
		Object taxObj = new Object();
%>
<br><br>
   
    
    <br>
    <table width="90%" align="center" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
    	
    	<tr>
		<Th width="40%" align="left">Document Type*</Th>
		<Td width="60%">
			<select name="docType" style="width:100%" id="CalendarDiv" onChange="javascript:showLabel()">
				<option value="">Select Document Type</option>
<%
				 for(int i=0;i<PoTypes.length;i++)
				 {
%>
					<option value="<%=PoTypes[i][0]%>"><%=PoTypes[i][1]%></option>
<%
				 }
%>	
			</select>
		</Td>
    	</tr>

    	<tr>
		<Th width="40%" align="left">Valuation Type* :</Th>
		<Td width="60%">
			<select name="valuationType" style="width:100%" id="CalendarDiv">
				<option value="">-Select Valuation Type-</option>
<%				
				 for(int i=0;i<valuationTypes.length;i++)			
				 {
					if(valuationType.equals(valuationTypes[i].trim()))
					{
%>			
						<option value="<%=valuationTypes[i]%>" selected><%=valuationTypes[i]%></option>
<%			
					}
					else
					{
%>
						<option value="<%=valuationTypes[i]%>"><%=valuationTypes[i]%></option>									
<%
					}		
				  }			
%>				
			</select>
		</Td>
	</tr>
	
	
	
	<Tr>
			<Th width="40%" align="left" style="visibility:visible">Tax Code*</Th>
				<Td width="60%">
				<div id="listBoxDiv3">
					<select name="taxCode"  style="width:100%">
						<option value="">Select Tax Code</option>
<%	
						taxIterator = taxTM.keySet().iterator();
						while(taxIterator.hasNext())
						{
							taxObj = taxIterator.next();
							String taxStr = taxObj.toString();
							if("AA".equals(taxStr.trim()))
							{
%>	
								<Option value="<%=taxStr%>" selected><%=taxStr%>--><%=taxTM.get(taxStr)%></Option>
<%
							}
							else
							{
%>
								<Option value="<%=taxStr%>" ><%=taxStr%>--><%=taxTM.get(taxStr)%></Option>									
<%						
							}
						}
%>		
					</select>
				</div>				
			</Td>
	</Tr>	
	<tr>
	    	<Th width="40%" align="left" style="visibility:visible">Confirmation control key*:</Th>
	    	<Td width="60%">
				<select name="ccKey" style="width:100%" id="CalendarDiv">
				<option value="" >-Select Confirmation Control- </option>
				
<%
				 for(int i=0;i<confctrlKeys.length;i++)
				 {
%>
					<option value="<%=confctrlKeys[i][0]%>"><%=confctrlKeys[i][1]%></option>
<%
				 }
%>	
				</select>
		</Td>
    	</tr>
    	<tr>
		<Th width="40%" align="left" style="visibility:visible">House Bank ID*:</Th>
		<Td width="60%">
			<select name="hbId" style="width:100%" id="CalendarDiv"> 
			<option value="" selected>-Select House Bank ID-</option>
<%
				for(int i=0;i<houseBankIds.length;i++)
				{
%>
					<option value="<%=houseBankIds[i][0]%>"><%=houseBankIds[i][1]%></option>
<%
				}
%>	
			</select>
		</Td>
		
    	</tr>

<%--
	<tr>
		<Th width="40%" align="left">Delivery Date:</Th>
		<Td width="60%"><input type="text" name="deliveryDate" class="InputBox" size=15 value=""  readonly> <img src="../../Images/calender.gif" style="cursor:hand" height="20" onClick=showCal("document.myForm.deliveryDate",50,150,"<%=cDate%>","<%=cMonth%>","<%=cYear%>") ></Td>
    	</tr>
	<tr>
		<Th width="40%" align="left">Tax Code</Th>
		<Td width="60%">
			<select name="taxCode" style="width:100%" id="CalendarDiv">
			<option value="AA" selected>No LST/CST. No ED</option>
<%
				 for(int i=0;i<taxCodes.length;i++)
				 {
%>
					<option value="<%=taxCodes[i][0]%>"><%=taxCodes[i][1]%></option>
<%
				 }
%>	
					
			</select>				
			</Td>
	</tr>
--%>	
	<tr>
			<Th width="40%" align="left">Header text</Th>
			<Td width="60%"><textarea style='width:100%' rows=3 name=headerText ></textarea></Td>
	</tr>
	<Tr>
			<Th align="left" width="40%">Shipping Instructions</Th>
			<Td width="60%"><textarea style='width:100%' rows=3 name=shipInstr ></textarea></Td>
	</Tr>				
	<tr>
			<Th width="40%" align="left">Item Text</Th>
			<Td width="60%">
			<textarea style='width:100%' rows=3 name=itemText ></textarea>
			</Td>
	</tr>
    </table>
<br>    
<center>
	<%
	
	buttonName = new java.util.ArrayList();
     buttonMethod = new java.util.ArrayList();
     
     
    buttonName.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
    buttonName.add("&nbsp;&nbsp;Cancel&nbsp;&nbsp;");

    buttonMethod.add("closeWin()");
    buttonMethod.add("winclose()");

    out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>

</form>
<Div id="MenuSol"></Div>
</body>
</html>
