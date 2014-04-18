
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%
	String FUNCTION = request.getParameter("FUNCTION");
	//String Area=request.getParameter("Area");
	if ( FUNCTION == null )
		FUNCTION = "AG";
%>
<%@ include file="../../../Includes/JSPs/Partner/iNewCustSync.jsp"%>
<html>
<head>
<Title>Synchronize Base ERP SoldTos</Title>
<Script>
function funSoldTo()
{
	document.myForm.NonBaseERPSoldTo.value = document.myForm.NonBaseERPSoldTo.value.toUpperCase()
}
function setDescVal()
{
	document.myForm.sysKeyDesc.value = document.myForm.SysKey.options[document.myForm.SysKey.selectedIndex].text
	return true
}

function checkAll1(partyType)
{
	document.returnValue = true;
}

</Script>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body onLoad="document.myForm.NonBaseERPSoldTo.focus();">
<form name=myForm method=post onSubmit="return setDescVal()" action="ezConfirmNewCustReSync.jsp">
<br>
<%
	String arDesc = ( FUNCTION.equals("AG") )?"Sales":"Purchase";
	String arTitle = ( FUNCTION.equals("AG") )?"Customer":"Vendor";
	String skipFlag = ( FUNCTION.equals("AG") )?"V":"C";
	String partyType = ( FUNCTION.equals("AG") )?"Sold":"Pay";
	String websyskey = request.getParameter("WebSysKey");
%>
<script src="../../Library/JavaScript/Partner/ezNewCustSync.js"></script>
<%
String catArea = null;
if((numBPs > 0) && (numSys > 0))
{

	/** Added by Venkat on 5/7/2001 **/
		//Get the Customers for the BP
		ReturnObjFromRetrieve retcust = null;
		EzcBussPartnerParams bparamsC = new EzcBussPartnerParams();
		EzcBussPartnerNKParams bnkparamsC = new EzcBussPartnerNKParams();
		bnkparamsC.setLanguage("EN");
		bparamsC.setBussPartner(Bus_Partner);
		bparamsC.setObject(bnkparamsC);
		Session.prepareParams(bparamsC);
		retcust = (ReturnObjFromRetrieve)BPManager.getBussPartnerErpCustomers(bparamsC);
		retcust.check();
	/** Changes end here **/
%>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
	<Tr align="center">
	<Td class = "displayheader" align = "center"><%=arTitle%> Synchronization</Td>
	</Tr>
</Table>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
    	<Tr>
      	<Th width="30%" class="labelcell">
        <div align="right">Business Partner:</div>
      	</Th>
      	<Td width="25%" >

	<a href = "../Partner/ezBPSummaryBySysKey.jsp?WebSysKey=<%=websyskey%>&Area=<%=catArea%>&BusinessPartner=<%=Bus_Partner%>"><%=BPDesc%></a>
        <input type="hidden" name="BusPartnerDesc" readonly value="<%=BPDesc%>">
        <input type="hidden" name="BusPartner" value="<%=Bus_Partner%>">
      	</Td>
      	<Th width="20%" class="labelcell"><div align="right"><%= arDesc%>
        Area:</div>
      	</Th>
      	<Td width="25%" >
<%
	//Added By Anil (06/02/01) changed  because when page visited first time the right catalog area isnot set
	int syskeyRows = retsyskey.getRowCount();
	for(int a=0;a<syskeyRows;a++)
	{
		String suppCustFlag = retsyskey.getFieldValueString(a,"ESKD_SUPP_CUST_FLAG");
		suppCustFlag = suppCustFlag.trim();
		if ( suppCustFlag.equals(skipFlag) || suppCustFlag.equals("S"))
		{
			retsyskey.deleteRow(a);
			a--;
			syskeyRows--;
			continue;
		}
	}
	catArea = request.getParameter("CatalogArea");
	if (catArea == null)
	{
		catArea = retsyskey.getFieldValueString(0,SYSTEM_KEY);
	}
	if(websyskey != null && !"null".equals(websyskey))
		catArea = websyskey;
	catArea = catArea.trim();

	if ( syskeyRows > 0 )
		{
		String sel = "";
		for ( int i = 0 ; i < syskeyRows; i++ )
		{
			  String suppCustFlag = retsyskey.getFieldValueString(i,"ESKD_SUPP_CUST_FLAG");
			  suppCustFlag = suppCustFlag.trim();

			  sel = retsyskey.getFieldValueString(i,SYSTEM_KEY);
			  sel = sel.trim();
			//catArea = websyskey;

			  //if ( catArea.equals(sel) )
			  if ( websyskey.equals(sel) )
			  {
%>
				<input type = 'hidden' name="SysKey" value='<%=(retsyskey.getFieldValue(i,SYSTEM_KEY))%>'>
		        	<%=retsyskey.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%>
<%
			  }
		}
		}
	else
		{
%>

		<center>No <%=arDesc%> Areas exist for this System</center>
<%
		} //end if syskeyRows > 0
%>
      	</Td>
    	</Tr>
</Table>
<% 
	if ( FUNCTION.equals("AG") ) { %>
<%@ include file="ezDisplayEzcCustomer.jsp"%>
<%
	}
else
	{
%>
<%@ include file="ezDisplayEzcVendor.jsp"%>
<%
	}
%>

<%
	if ( syskeyRows > 0 )
		{
%>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
    	<Tr align="center" valign="middle">
<%
	if(FUNCTION.equals("AG")) {
%>
        	<Th align = "right" width="60%" class="labelcell" >Sold To :</Th>
<%
	} else {
%>
		<Th align = "right" width="60%" class="labelcell" >Please Enter New "Pay To" to be Synchronized:*</Th>
<%
	}
	//EzC Customer text boxes
	int ezCount = 1;

	for ( int j = 0 ; j < ezCount; j++ )
		{
%>
      	<Td wdith = "40%" align="center">
     	<input type=text class = "InputBox" name="NonBaseERPSoldTo" style="width:100%" maxlength="10"  value="<%=soldToToBeReSync%>" onBlur = funSoldTo() readonly>
      	</Td>
    	</Tr>
<%
	}//End for
%>
</Table>
<div align="center"><br>
<%
	if(retsyskey.getRowCount() > 0)
		{
%>
  		<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/process.gif" onClick="checkAll1('<%=partyType%>');return document.returnValue">
  		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

<%
		}
%>
</div>
<script language = "javascript">
	//document.myForm.NonBaseERPSoldTo.focus();
</script>
<%
	   } //if syskeyRows > 0
%>
<%
	}
	else
		{
%>
<div align="center">
<p><font size="4">There are no Business Partners or there are no Non-Base ERPs
for this Partner</font></p>
</div>
<p><%
}//end if BPs >0
%> </p>
<input type="hidden" name="FUNCTION" value="<%=FUNCTION%>">
<input type="hidden" name="Area" value="<%=Area%>" >
<input type=hidden name=ReSynchFlag value="">
<input type=hidden name=sysKeyDesc value="AAA">
</form>
</body>
</html>
