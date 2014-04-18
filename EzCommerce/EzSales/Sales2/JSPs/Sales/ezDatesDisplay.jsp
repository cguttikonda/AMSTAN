<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>

<%@ include file="../../../Includes/JSPs/Lables/iAddDatesEntry_Lables.jsp"%>

<%@ page import ="ezc.ezparam.*"%>

<%
	
	ReturnObjFromRetrieve ret=(ReturnObjFromRetrieve) session.getValue("EzDeliveryLines");

	String itemNumber=request.getParameter("itemNo");
	String matdesc = request.getParameter("matdesc");

%>

<html>
<head>
<title>Quantites and Required Dates --Powered By EzCommerce Inc</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
</head>
 		  
<body>
<form name="f1">
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
<Tr>
	<Th colspan=2><%=qtyReqDate_L%> <%= matdesc %></Th>
</Tr>
<tr>
	<th><%=qty_L%></th>
	<th><%=reqDate_L%></th>
</tr>

<%
if(ret!=null)
{
	for(int i=0;i<ret.getRowCount();i++)
	{
		if(ret.getFieldValueString(i,"EZDS_ITM_NUMBER").equals(itemNumber))
		{
			String schqty = ret.getFieldValueString(i,"EZDS_REQ_QTY");
			String schdate = ret.getFieldValueString(i,"EZDS_REQ_DATE");
			if( (schdate != null) || (schdate != "0" ) || (!"null".equals(schdate) ) || ( ! "0".equals(schdate) ) )
			{
%>
			<tr>	
				<td align="right"><%= schqty %></td>
				<td><%= schdate %></td>
			</tr>
<%
			}
	
		}
	}
}
%>
</table>
<br><br>
<Table align="center">
<tr>
<td align="center" colspan="2" class="blankcell">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Ok");
	buttonMethod.add("window.close()");
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</td></tr>
</Table>
<Div id="MenuSol"></Div>
</form>
</body>
</html>