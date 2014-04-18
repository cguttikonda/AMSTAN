<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import="ezc.ezwebstats.params.*,ezc.ezparam.*" %>

<jsp:useBean id="WebStatsManager" class="ezc.ezwebstats.client.EzWebStatsManager" />
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>

<html>
<head>
	<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
</head>
<body onLoad="scrollInit()">
<%

	EziEyeBallParams params = new EziEyeBallParams();
	java.util.StringTokenizer stk=null;
	String tmp="";
	String[] domains=request.getParameterValues("domain");

	if(domains != null)
	{
		params.setDomain(domains);
	}
	String[] syskeys=request.getParameterValues("syskey");
	if(syskeys != null)
	{
		params.setSyskey(syskeys);
	}
	if(!("".equals(request.getParameter("fromdate"))))
	{
		params.setDate(request.getParameter("fromdate"));
		params.setDate1(request.getParameter("todate"));
	}
	if(!("".equals(request.getParameter("soldto"))))
		params.setSoldto(request.getParameter("soldto"));
	if(!("".equals(request.getParameter("userid"))))
		params.setUserid(request.getParameter("userid"));
	//if(!("".equals(request.getParameter("group"))))
	//	params.setGroup(request.getParameter("group"));
	String[] options=request.getParameterValues("option");
	if(options != null)
		params.setOption(options);

	//if(!("".equals(request.getParameter("option"))))
		//params.setOption(request.getParameter("option"));
	if(!("".equals(request.getParameter("value1"))))
		params.setValue1(request.getParameter("value1"));
	if(!("".equals(request.getParameter("value2"))))
		params.setValue2(request.getParameter("value2"));
	if(!("".equals(request.getParameter("value3"))))
		params.setValue3(request.getParameter("value3"));

	String[] chk1=request.getParameterValues("chk1");
	if(chk1!=null)
	{
		params.setGroupBy(chk1);
	}

	EzcParams mainParams = new EzcParams(false);
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	ReturnObjFromRetrieve ret=(ReturnObjFromRetrieve)WebStatsManager.ezViewEyeBallTrackInfo(mainParams);


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
		<Table align=center width=80%>
		<Tr>
			<Td class=displayheader align=center>EzEyeBall Track Information</Td>
		</Tr>
		</Table>
		<div id="theads" >
		<Table  id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>

		<Tr>
		<%
			for(int i=0;i<ret.getColumnCount();i++)
			{
		%>
				<Th width=11%><%=ret.getFieldName(i)%></Th>
		<%
			}
		%>
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
			for(int j=0;j<ret.getColumnCount();j++)
			{
%>
				<Td width=11% align=center title="<%=ret.getFieldValueString(i,ret.getFieldName(j))%>"><input type=text class="DisplayBox" value="<%=ret.getFieldValueString(i,ret.getFieldName(j))%>" size=7></Td>
<%
			}
%>
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
