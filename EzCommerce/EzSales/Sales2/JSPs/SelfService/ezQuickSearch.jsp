<%@ page import="java.util.*" %>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iQuickSearch_Lables.jsp"%>
<html>
<head>
<%
	String saType = (String)session.getValue("satype");
	String sType = request.getParameter("SearchType");
	String searchPatern = request.getParameter("searchPatern");
	searchPatern=(searchPatern==null || "null".equals(searchPatern))?"":searchPatern;
%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<script src="../../Library/JavaScript/Misc/ezTrim.js"></script>
<script>
function ezHref()
{
	document.location.href="../Misc/ezWelcome.jsp"
}
function doSubmit()
{
   obj = document.myForm;
   if(obj.setSub.value != "Y")
   {
	if(funTrim(obj.searchPatern.value)=="")
	{
		//alert("<%=plzEnterSearch_A%>");
		//obj.searchPatern.focus();
		//return false;
		obj.SearchType[2].checked = true
		obj.searchPatern.value = "*"
		obj.setSub.value="Y"
		obj.submit();
		
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
	
 function typeCheck() 
 { 
 sObj = document.myForm.SearchType 
 <%
 
 if(sType!=null && !"null".equals(sType) && !"".equals(sType)) { 
 	sType = sType.trim(); 
 }	
 %>
 var stype = "<%=sType%>" 
 if(stype=="SAPSO") 
 	sObj[0].checked=true; 
 else
 if(stype=="PONO") 
 	sObj[0].checked=true;
 else if(stype=="PRODUCTNO") 
 	sObj[1].checked=true; 
 else if(stype=="PRODUCT") 
 	sObj[2].checked=true; 
}
</script>	

</head>
<body onLoad="document.myForm.searchPatern.focus();typeCheck()" scroll=no>
<form name=myForm action="../Sales/ezListSalesOrders.jsp" onSubmit="return false">
<input type="hidden" name="setSub">
<input type="hidden" name="srType" value="Y">

<%
	String display_header = plzEnterSearch_A;
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<br><br><br>


<Table align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width=90%>
<!--
<Tr>
	<Td   align=center valign=middle style="background:#ffffff">
		<img src="../../../../EzCommon/Images/Common/search.jpg" width=100 height=100>
	</Td>
</Tr>
-->
<Tr>
	<Td style="background:white"    align=center>
		<font color='red'>Search is limited to Orders created on Web</font><BR>
		<font color='red'>Use * as search pattern for all orders</font>
		<BR><BR>
		<Table style="width:60%;align:center" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 align=CENTER width=90%>
		<Tr>
			<Td style="background:white" >
				<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#89B5EB cellPadding=2 cellSpacing=0 width=100%>
					<Tr>
						<Td><input type=radio name=SearchType value="SAPSO" id="id1" checked><label for="id1" ><b><%=webOrder_L%></b></label></nobr></Td>
						<Td><nobr><input type=radio name=SearchType value="PONO" id="id2" ><label for="id2" ><b><%=purOrder_L%></b></label></nobr></Td>
						<Td><nobr><input type=radio name=SearchType value="PRODUCTNO" id="id3"><label for="id3"><b><%=prodNo_L%></b></label></nobr></Td>
						<Td><nobr><input type=radio name=SearchType value="PRODUCT"   id="id4"><label for="id4"><b><%//=prodDes_L%>Product Description</b></label></nobr></Td>
					</Tr>
				</Table>
			</Td>	
		</TR>	
		<tr><td class=blankcell>&nbsp;</td></tr>
		<TR>
			<Td style="background:white" ALIGN=CENTER> 	  		
				<input type=text class=inputbox maxlength="50" size="30" name=searchPatern value="<%=searchPatern%>" onKeyPress=keySubmit()>
				<img src="../../../../EzCommon/Images/Common/search-icon.gif" onClick='doSubmit()' border=0  style="vertical-align:bottom;cursor:hand" />
			</Td>

		</tr>
		</Table>
	</Td>
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
	statKeys.addElement("'Rejected'");	
	statKeys.addElement("'Transfered'");	
	statKeys.addElement("'ReturnedByCM'");	
	statKeys.addElement("'ReturnedByLF'");	
	statKeys.addElement("'RetNew'");
	statKeys.addElement("'Rettransfered','Retcmtransfer'");
%>
	</Tr>
	</Table>
	</Td>
</Tr>
</Table>


<input type=hidden name=orderStatus value="<%=statKeys.elementAt(0)%>">
<input type=hidden name=orderStatus value="<%=statKeys.elementAt(5)%>">
<input type=hidden name=orderStatus value="<%=statKeys.elementAt(1)%>">
<input type=hidden name=sortOn value="WEBORNO">
<input type=hidden name=sortOn value="PONO">
<input type=hidden name=sortOn value="CREATEDBY">
<input type=hidden name=sortOrdervalue="Asc">
<input type=hidden name=sortOrdervalue="Desc">
</form>
<Div id="MenuSol"></Div>
</body>
</html>	

		
