<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%
	// Don't delete these Variables. these are used in ezAcceptedOrdersXML.jsp
	String urlPage	= "COPYORDER";
	String custStr	= "";
%>
<%@ include file="../../../Includes/JSPs/Sales/iCopySOList.jsp" %>
<%@ include file="../../../Includes/JSPs/Lables/iCopySalesOrder_Lables.jsp"%> 
<%
	String pageUrl 	= "ezCopyAddSalesOrder.jsp";
	String agent	= (String)session.getValue("Agent");
%>
<html>
<head>

<title>Create Sales Order -- Powered by EzCommerce Inc</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<script language="javascript">
	function chkField()
	{
	    if(document.CopySOForm.webOrNo.selectedIndex=="0")
            {
			alert("<%=plzSelOrderNo_A%>");
			return false;
	    }else
		     return true;
	}

	function setBack()
	{
		document.location.replace("../Misc/ezWelcome.jsp"); 
	}

	function fun()
	{
		y=chkField()
		if(eval(y))
		{

  			document.CopySOForm.onceSubmit.value=1
   			document.body.style.cursor="wait";
			document.CopySOForm.action="<%= pageUrl %>";
			document.CopySOForm.submit();

		}

	}
</script>
</head>

<body >
<table style='background:transparent' align=center border="0" cellpadding="0"  cellspacing="0" width="100%">
<tr>
   <td height="20" style='background:transparent' align=center width="100%"><b><%=copsord_L%></b></td>
</tr>
</table>
<br>

<%
	int rowCount = retobj.getRowCount();
	
	if(rowCount==0)
	{
%>
		<br><br><br><br>
		<table  align=center border=0>
		<tr>
			<td class=displayalert align ="center" colspan ="4">There are no sales orders exist for <font color='red'><%=agent%> </font>to copy.</td>
		</tr>
		</table >
		<br><br><center>
<%		
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		//buttonName.add("Back");
		//buttonMethod.add("setBack()");
		out.println(getButtonStr(buttonName,buttonMethod));		
%>
<Div id="MenuSol"></Div>
<%
		return;
	}
%>


<form name="CopySOForm" method="post" action="ezCopyAddSalesOrder.jsp">

<Div id='inputDiv' style='position:relative;align:center;width:100%;'>
<Table width="45%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
	<Tr>
		<Td height="5" style="background-color:'DDEEFF'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
		<Td height="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
		<Td height="5" style="background-color:'DDEEFF'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
	</Tr>

	<Tr>
		<Td width="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
		<Td style="background-color:'DDEEFF'" valign=middle>
		  <table  align=center border=0 valign=middle width="100%" cellPadding=0 cellSpacing=0 >
		    <tr align=center>
		      <th><%=coorfr_L%></th>
		      <td>
			<select  name="webOrNo">
			<Option value=""><%=selOrdNo_L%></option>

			<%

			for(int i=0;i<rowCount;i++)
			{
				String webOrno=retobj.getFieldValueString(i,"WEB_ORNO");
				String soldTo=retobj.getFieldValueString(i,"SOLD_TO_CODE");
				String salesArea =retobj.getFieldValueString(i,"SYSKEY");
				String sapno =retobj.getFieldValueString(i,"BACKEND_ORNO");
				try{ sapno=String.valueOf(Long.parseLong(sapno)); }catch(Exception e){}
				out.println("<option value='"+webOrno+","+soldTo+","+salesArea+"'>"+retobj.getFieldValueString(i,"WEB_ORNO") +"-- "+sapno+"</option>");
			}%>
			</select>
			</td>
		      <td>
<%
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			buttonName.add("Copy");
			buttonMethod.add("fun()");
			out.println(getButtonStr(buttonName,buttonMethod));
%>

		      </td>
		    </tr>
		  </table>
		
		</td>
	
		<Td width="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"></Td>
	</Tr>
	<Tr>
		<Td width="5" style="background-color:'DDEEFF'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
		<Td height="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
		<Td width="5" style="background-color:'DDEEFF'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
	</Tr>
</Table>
</Div>		  
		  
<input type="hidden" value="copy" name="copy">
<br>
<br>
<br><br><br><br><center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	//buttonName.add("Back");
	//buttonMethod.add("setBack()");
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
<input type="hidden" name="onceSubmit" value=0>
<input type="hidden" name="bkpflg" value="CpyOrdr">

</form>
<Div id="MenuSol"></Div>
</body>
</html>





