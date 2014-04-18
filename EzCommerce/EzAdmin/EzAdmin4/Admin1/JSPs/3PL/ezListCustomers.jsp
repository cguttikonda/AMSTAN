<%@ page import="ezc.ezparam.*,ezc.ezsfa.params.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />

<%
	ezc.ezsfa.client.EzSFAManager manager = new ezc.ezsfa.client.EzSFAManager();
	EzcParams myParams1 = new EzcParams(false);
	EziCustomerParams params=new EziCustomerParams();
	myParams1.setObject(params);
	Session.prepareParams(myParams1);
	ReturnObjFromRetrieve ret = (ReturnObjFromRetrieve)manager.getCustomerList(myParams1);

%>


<Html>
<Head>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
</Head>
<Body onLoad='scrollInit()'>
<br>
<%
	if(ret.getRowCount() == 0)
	{
%>
		<Table  width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Th>No Customers From 3PL</Th>
		</Tr>
		</Table>
		<br><br><br><center>
			<Img   src="../../Images/Buttons/<%= ButtonDir%>/back.gif"   onClick="history.go(-1)" style="cursor:hand">
		</center>
<%
	}
%>

	<Table  width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Th>Synchronized Customers List</Th>
	</Tr>
	</Table>
	<div id="theads">
	<Table id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Th width="20%">Cust No</Th>
		<Th width="40%">Company</Th>
		<Th width="20%">Rep Code</Th>
		<Th width="20%">3PL Code</Th>
	</Tr>
	</Table>
	</div>
	
	<Div id="InnerBox1Div">
	<Table id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%
	for(int i=0;i<ret.getRowCount();i++)
	{
%>
	<Tr>
		<Td width=20%><%=ret.getFieldValueString(i,"NO")%></Td>	
		<Td width=40%><%=ret.getFieldValueString(i,"COMPANY_NAME")%></Td>	
		<Td width=20%><%=ret.getFieldValueString(i,"REP_CODE")%></Td>	
		<Td width=20%><%=ret.getFieldValueString(i,"CUST_CODE_3PL")%></Td>	
	</Tr>
<%
	}
%>
	</Table>
	</Div>

	<div align=center id=Buttons style="width:100%;top:90%">
		<Img   src="../../Images/Buttons/<%= ButtonDir%>/back.gif"   onClick="history.go(-1)" style="cursor:hand">
	</div>

</Body>
</Html>