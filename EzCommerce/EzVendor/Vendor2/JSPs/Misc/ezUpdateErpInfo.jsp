
<%@ include file="../../../Vendor2/Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Labels/iUpdateErpInfo_Labels.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iUpdateErpInfo.jsp"%>
<html>
<head>       
	<%@include file="../../../Includes/Lib/AddButtonDir.jsp" %>
</head>
<body scroll=no>
<%
	String display_header  = addrUpdateInfo_L;
%>	
	<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<%
	if(!isError)
	{
		if(payToCustNum!=null || !payToCustNum.equalsIgnoreCase("null"))
		{
%>
			<div align="center">
			<TABLE width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
			<tr> 
				<th><%=payToAddr_L%></th>
			</tr>
			<tr> 
				<td><%=companyName%>&nbsp;</td>
			</tr>
			<tr> 
				<td><%=payAddr1%>&nbsp;</td>
			</tr>
<%
			if (payAddr2!=null && payAddr2.trim().length()>0) 
			{
%>
				<tr>
					<td><%=payAddr2%>&nbsp;</td>
				</tr>
<%
			}
%>
			<tr> 
				<td><%=payCity%>&nbsp;</td>
			</tr>
			<tr> 
				<td><%=payState+" "+payZip%>&nbsp; </td>
			</tr>
			<tr> 
				<td><%=payCountry%>&nbsp;</td>
			</tr>
			</table>
			</div>
<%
		} 
		else 
		{
			String noDataStatement = noPayToAddr_L;
%>
			<%@ include file="../Misc/ezDisplayNoData.jsp"%>		
<%
		}
	}	
	else
	{
		String noDataStatement = errorMessage;
%>
		<%@ include file="../Misc/ezDisplayNoData.jsp"%>		
<%
	}
%>

 




<Div id="ButtonDiv" align=center style="position:absolute;top:65%;visibility:visible;width:100%">
<center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("Ok");
	buttonMethod.add("navigateBack(\"ezGetInfo.jsp\")");

	 out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</Div>
<Div id="MenuSol"></Div>
</body>
</html>