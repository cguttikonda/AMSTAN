<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%
	boolean synchFlag = false;

	String mySyskeys[] = request.getParameterValues("syskey");
	int rowCount=mySyskeys.length;
 	String syskeyDesc[] = new String[rowCount];


	java.util.ArrayList sysKeys=new java.util.ArrayList();


	for(int i=0;i<rowCount;i++)
	{
		java.util.StringTokenizer tokens= new java.util.StringTokenizer(mySyskeys[i],"#####");
		sysKeys.add(tokens.nextToken());
		syskeyDesc[i]=tokens.nextToken();
	}
	long startTime=System.currentTimeMillis();
	try
	{
  		ezc.ezbasicutil.EzMaterialSynch synch=new ezc.ezbasicutil.EzMaterialSynch();
		synch.doSynch(sysKeys,Session);
		synchFlag = true;
	}
	catch(Exception e)
	{
		out.println(e);
	}
	long endTime=System.currentTimeMillis();
	float timeTaken = ((new Long(endTime-startTime)).floatValue())/1000;
%>
<html>
<head>
<Title>Material Synch</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/ezTabScroll.js"></script>
</head>
<body onLoad='scrollInit()' onresize='scrollInit()' scroll = "no">
<br>
<%
	if(synchFlag)
	{
%>
		<div id="theads">
		<Table id="tabHead" width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Td class = "displayheader" align="center" width = "30%" colspan = 3>Mass Material Synchronization</Td>
		</Tr>
		<Tr>
			<Th align="center" width = "30%" colspan = 3>The Following Sales Area(s) are Synchronized Successfully (TimeTaken:<%=timeTaken%> Sec)</Th>
		</Tr>
		</Table>
		</Div>
		<div id="InnerBox1Div">
		<Table  id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr>
<%
		for(int i=0;i<rowCount;i++)
		{
			if(i%3==0)
			{
%>
				</tr>
				<tr>
<%
			}
%>
			<Td width = "33%" title = "(<%=mySyskeys[i]%>) <%=syskeyDesc[i]%>">
				<input type = "text" value = "(<%=mySyskeys[i]%>) <%=syskeyDesc[i]%>" size = "30" class = "DisplayBox" readonly>
			</Td>
<%
		}
		if(rowCount>3)
		{
			rowCount = 3 - (rowCount%3);
			for(int i=0;i<rowCount;i++)
			{
%>
				<Td width = "33%">&nbsp;</Td>
<%
			}
		}
%>
		</Tr>
		</Table>
		</Div>
		<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none></a>
		</div>		
<%
	}
	else
	{
%>
		<br><br><br><br>
		<Table width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Th align=center>Problem while synchronizing Sales Areas.</Th>
		</Tr>
		</Table>		
		<br>
		<Center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</Center>
<%
	}
	
%>
</body>
</html>
