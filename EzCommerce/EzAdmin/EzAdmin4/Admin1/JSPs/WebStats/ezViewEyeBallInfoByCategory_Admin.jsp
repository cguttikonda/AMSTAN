<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import="ezc.ezwebstats.params.*,ezc.ezparam.*,java.util.*" %>
<jsp:useBean id="WebStatsManager" class="ezc.ezwebstats.client.EzWebStatsManager" />
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%

	
	HashMap myMap= new HashMap();
	myMap.put("SALES","'21','22','23','24'");
	myMap.put("STOCK","25");
	myMap.put("PROJECTIONS","26");
	myMap.put("SELF","27");
	myMap.put("CATALOG","31");
	myMap.put("DISPATCH","29");
	myMap.put("CUSTOMER","28");
	myMap.put("ALL","21,22,23,24,25,26,27,28,29,31");
		

	HashMap myDesc= new HashMap();
	myDesc.put("SALES","Sales Order");
	myDesc.put("STOCK","Secondary Sales");
	myDesc.put("PROJECTIONS","Projections");
	myDesc.put("SELF","Self Service");
	myDesc.put("CATALOG","Catalog");
	myDesc.put("DISPATCH","Dispatch");
	myDesc.put("CUSTOMER","Customer Details");
	myDesc.put("ALL","All");

	String cat=request.getParameter("cat");
	cat=cat.toUpperCase();

	//out.println(myMap.get(cat) + "  " +   myDesc.get(cat));
	
	
		

	EzcParams mainParams = new EzcParams(false);
	EziEyeBallParams params = new EziEyeBallParams();
	params.setGroup((String)myMap.get(cat));
	params.setGroupBy(new String[]{"USERID","DATE"});
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	ReturnObjFromRetrieve ret=(ReturnObjFromRetrieve)WebStatsManager.ezViewEyeBallTrackInfo(mainParams);

	String sort [] =new String[]{"EZCOUNT" };
	if(ret!=null)
	{
		if(ret.getRowCount() > 0)
		ret.sort(sort,false);
	}

%>
<html>
<head>
	<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
</head>
<body onLoad="scrollInit()" onresize='scrollInit()' >
<%
	int len=ret.getRowCount();
	if(len == 0)
	{
%>
		<br><br>
		<Table align=center width=80%>
		<Tr>
			<Th>No Info found as per your selection.</Th>
		</Tr>
		</Table><br><br><center>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
<%
	}
	else
	{
%>
		<br><br>
		<Table align=center width=89%>
		<Tr>
			<Td class=displayheader align=center>EzEyeBall Track Information for <%=myDesc.get(cat)%></Td>
		</Tr>
		</Table>
		<div id="theads" >
		<Table  id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>

		<Tr>
		
				<Th width="70%">UserId</Th>
				<Th width="30%">Count</Th>
		
		</Tr>
		</Table>
		</div>
		<div id="InnerBox1Div">
		<Table align="center" id="InnerBox1Tab" border=1 borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
<%

		for(int i=0;i<len;i++)
		{
%>
			<Tr>
<%
			
%>
				<Td width="70%" align=left><%=ret.getFieldValueString(i,"EZUSER")%></Td>
				<Td width="30%" align=right><%=ret.getFieldValueString(i,"EZCOUNT")%></Td>
			</Tr>

<%
		}
%>

		</Table></div>
		<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</div>
<%
	}


%>

</body>
</html>

</body>
</html>
