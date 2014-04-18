<%@ page import="java.util.*" %>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iQuickSearch_Lables.jsp"%>
<html>
<head>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<script src="../../Library/JavaScript/Misc/ezTrim.js"></script>
<script>
function ezHref()
{
	document.location.href="../Misc/ezWelcome.jsp"
}
function doCheck()
{
	for(i=1;i<document.myForm.orderStatus.length;i++)
	{
		if(document.myForm.orderStatus[i].checked)
		{
			document.myForm.orderStatus[0].checked=false	
			break
		}
	}
}
function doDeCheckAll()
{
	for(i=1;i<document.myForm.orderStatus.length;i++)
	{
		
		document.myForm.orderStatus[i].checked=false
		
	}
}
function doSubmit()
{
	obj = document.myForm;

   if(obj.setSub.value != "Y")
   {

	if(funTrim(obj.searchPatern.value)=="")
	{
		alert("<%=plzEnterSearch_A%>");
		obj.searchPatern.focus();
		return false;
	}
	else
	{
		obj.setSub.value="Y"
		obj.submit();
	}
   }
}
function keySubmit()
	{
		if(event.keyCode==13)
		{
			
			doSubmit();
		}
	}
		
</script>	
</head>
<body onLoad="document.myForm.searchPatern.focus()">
<form name=myForm action="../Sales/ezListSalesOrders.jsp" onSubmit="return false">
<input type="hidden" name="setSub">


<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
<tr>
    <td height="35" class="displayheaderback"  align=center><%=plzEnterSearch_A%></td>
</tr>
</table>
<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width=90%>
<Tr>
	<Td class=blankcell  height=100% width=50%  align=center>
		<Table align=center  width=95%>
		<Tr>
			<Td colspan=2 align=center class=displaysubheader><%=searchBy_L%></Td>
		</Tr>
		<Tr>
			<Td class=blankcell>	
				<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width=100%>
				<Tr><Td ><nobr><input type=radio name=SearchType value="WEB" id="id1" checked><label for="id1" ><%=webOrder_L%></label></nobr></Td></Tr>
				<Tr><Td ><nobr><input type=radio name=SearchType value="PONO"  id="id2"><label for="id2" ><%=purOrder_L%></label></nobr></Td></Tr>
				<Tr><Td ><nobr><input type=radio name=SearchType value="PRODUCTNO" id="id3"><label for="id3"><%=prodNo_L%></label></nobr></Td></Tr>
				<Tr><Td ><nobr><input type=radio name=SearchType value="PRODUCT" id="id4"><label for="id4"><%=prodDes_L%></label></nobr></Td></Tr>
				</Table>
			</Td>
			<Td class=blankcell><input type=text class=InputBox name=searchPatern onKeyPress=keySubmit()></Td>
		</Tr>
		</Table>
	</Td>
	<Td class=blankcell  height=100% width=50%  align=center >
		<Table align=center  width=65%>
		<Tr>
			<Td class=displaysubheader align=center ><%=selStatus_L%></Td>
		</Tr>
		<Tr> 
			<Td class=blankcell>
<%
	String userRole=(String)session.getValue("UserRole");	
	Vector statKeys= new Vector();
	statKeys.addElement("All"); 
	statKeys.addElement("'New'"); 		
	
	if("CU".equals(userRole) || "AG".equals(userRole))
		statKeys.addElement("'Submitted','Approved','SUBMITTEDTOBP','RETURNEDBYBP'");		
	else
		statKeys.addElement("'Submitted'");			
		
	statKeys.addElement("'Approved'"); 	
	//statKeys.addElement("'New'"); 	
	statKeys.addElement("'Rejected'");	
	statKeys.addElement("'Transfered'");	
	statKeys.addElement("'ReturnedByCM'");	
	statKeys.addElement("'ReturnedByLF'");	
	statKeys.addElement("'RetNew'");
	statKeys.addElement("'Rettransfered','Retcmtransfer'");



%>
			<Table  valign=top align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width=100%>
			<Tr>
				<Td colspan=2 align=center><nobr><input type=radio name=orderStatus  value="<%=statKeys.elementAt(0)%>"  checked onClick=doDeCheckAll() id="status0"><label for="status0"><%=anyStatus_L%></label></Td>
			</Tr>
			<Tr>
				<Td ><nobr><input type=radio name=orderStatus onClick=doCheck() value="<%=statKeys.elementAt(5)%>" id="status1"><label for="status1"><%=accepted_L%></label></nobr></Td>
			</Tr>
			<Tr>
				<Td><nobr><input type=radio name=orderStatus onClick=doCheck() value="<%=statKeys.elementAt(1)%>" id="status3"><label for="status3">Saved Order</label></nobr></Td>
			</Tr>

			</Table>
		</Td>
		</Tr>
		</Table>
	</Td>
</Tr>
</Table>
<Table align=center width=90%>
<Tr>
	<Td class=displayheader align=center colspan=2 width=100%>
		<%=sortCri_L%>
	</Td>
</Tr>
</Table>
<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width=90%>
<Tr>
		<Td class=blankcell  height=100% width=50%  align=center>
		<Table align=center width=70%>
		<Tr>
			<Td class=displaysubheader align=center colspan=2>
				<%=sortBy_L%>
			</Td>
		<Tr>
			<Td class=blankcell>
				<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width=70%>
					<Tr><Td><input type=radio name=sortOn value="WEBORNO" checked id="sid1"><label for="sid1" ><%=webOrder_L%></label></Td></Tr>
					<Tr><Td><input type=radio name=sortOn value="PONO"  id="sid2"><label for="sid2" ><%=purOrder_L%></label></Td></Tr>
		<%if("CM".equals(userRole) || "LF".equals(userRole))
		{
		%>
					<Tr><Td><input type=radio name=sortOn value="CREATEDBY" id="sid4"><label for="sid4" ><%=cuser_L%></label></Td></Tr>
		<%
		}
		%>
		</Table>
			</Td>
		</Tr>
		</Table>
	</Td>
	<Td class=blankcell  height=100% width=50%  align=center>
		<Table align=center width=70%>
		<Tr>
			<Td class=displaysubheader  align=center colspan=2>
				<%=sortOrder_L%>
			</Td>
		<Tr>
			<Td class=blankcell>
				<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width=70%>
				<Tr>
					<Td><input type=radio name=sortOrder checked id="order1" value="Asc"><label for="order1"><%=ascen_L%></label></Td>
				</Tr>
				<Tr>
					<Td><input type=radio name=sortOrder id="order2" value="Desc"><label for="order2"><%=desend_L%></label></Td>
				</Tr>
				</Table>
			</Td>
		</Tr>
		</Table>
	</Td>
</Tr>
</Table>
<br>
<Table align=center>
<Tr>
	<Td class=blankcell>
	<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Go");
		buttonMethod.add("doSubmit()");
		buttonName.add("Back");
		buttonMethod.add("ezHref()");
		out.println(getButtonStr(buttonName,buttonMethod));	
	%>
</Tr>
</Table>
<Table align=center>
<Tr>	
	<Td align="center" class="blankcell"><%=seaLimOrdOnline_L%></Td>
</Tr></Table>
</form>
<Div id="MenuSol"></Div>
</body>
</html>	

		
