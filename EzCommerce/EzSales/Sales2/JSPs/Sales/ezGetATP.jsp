<%@ page import="ezc.ezparam.*,java.util.*"%>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezGlobalBean.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />

<%@ include file="../../../Includes/JSPs/Sales/iGetATP.jsp" %>	
<html>
<head>
	<title>Check for ATP -- Answerthink Inc</title>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<script>
function setBack()
{
	window.close();
}
function setOk()
{
	window.close();
}
</Script>
</head>
<body  scroll=no> 
<form method="post"  name="generalForm"  
<%

	//this code is for globalization for open upto field
	Vector types = new Vector();
	types.addElement("date");
	types.addElement("date");
	EzGlobal.setColTypes(types);
	 
	
	Vector names = new Vector();
	names.addElement("ReqDate"); 
	names.addElement("ComDate");
	EzGlobal.setColNames(names);
	ezc.ezparam.ReturnObjFromRetrieve ret = EzGlobal.getGlobal(OutputTable);
%>
<br>
<Table width="85%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
   <tr> 
     <th colspan=8><%= ProdDesc %> (<%= UOM %>) Availability </th>
  </tr>
   <tr> 
    <th colspan="2">Date </th>
    <th colspan="2">Quantity</th>
  </tr>
  <tr> 
    <th>Required</th>
    <th>Tentative Commitment</th>
    <th>Required</th>
    <th>Tentative Commitment</th>
  </tr>
	<%
	int RowCount = OutputTable.getRowCount();
	boolean flag = true;
	for ( int i = 0 ; i < RowCount ; i++ )
	{
		String comQty = OutputTable.getFieldValueString(i,"ComQty");
		
		if(!("0.000").equals(comQty))
		{
			flag=false;
	%>
	 <tr>
		<Td> <%= ret.getFieldValue(i,"ReqDate") %> </Td>
		<Td> <%= ret.getFieldValue(i,"ComDate") %></Td>
		<Td> <%= OutputTable.getFieldValue(i,"ReqQty") %></Td>
		<Td> <%= comQty %></Td>
	</tr>
     <%		}
	}
	if(flag)
	{
	%>
	 <tr>
		<Td colspan="4" align="center"> Tentative Date and Quantites not maintained </Td>
	 </tr>
	<%	
	}
     %>
</Table>	

<br>
	<Table align="center">
	<Tr><Td align=center class=blankcell>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Close");
	buttonMethod.add("setBack()");	
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</Td></Tr></Table>
</form>
<Div id="MenuSol"></Div>
</body>
</html> 
