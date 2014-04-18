<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<jsp:useBean id="global" class="ezc.ezbasicutil.EzGlobal" scope="session" />
<%@ page import="ezc.ezparam.*,ezc.ezmisc.params.*"%>
<%

	String newsId	= request.getParameter("id");
	String newsType	= request.getParameter("type");
	ezc.ezparam.ReturnObjFromRetrieve trackRet = null;
	EziMiscParams trackParams = null;
	ezc.ezparam.EzcParams mainParams_A=null;
	global.setDateFormat("dd/MM/yyyy");
	ReturnObjFromRetrieve GlobObj = null;	
	int trackRetCnt=0;
	if(newsId!=null && newsType!=null)
	{
		mainParams_A=new ezc.ezparam.EzcParams(false);
		trackParams = new EziMiscParams();

		trackParams.setIdenKey("MISC_SELECT");
		String query="SELECT ENR_ID,ENR_SYSKEY,ENR_USER,ENR_VIEWED,ENR_VIEWED_DATE,ENR_CONFIRMATION,ENR_CONFIRMED_DATE FROM EZC_NEWS_READ_TIMESTAMP WHERE ENR_ID IN ('"+newsId+"')" ;
		trackParams.setQuery(query);

		mainParams_A.setLocalStore("Y");
		mainParams_A.setObject(trackParams);
		Session.prepareParams(mainParams_A);	

		try
		{
			trackRet = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams_A);
			if(trackRet!=null)
				trackRetCnt = trackRet.getRowCount();
			
		}
		catch(Exception e)
		{
			out.println("Exception in Getting Data"+e);
		}
		if(trackRetCnt>0)
		{
			Vector types= new Vector();
			types.addElement("date");
			types.addElement("date");
			
			Vector cols= new Vector();
			cols.addElement("ENR_VIEWED_DATE");
			cols.addElement("ENR_CONFIRMED_DATE");
			global.setColTypes(types);
			global.setColNames(cols);
			GlobObj = global.getGlobal(trackRet);
		}		
	}
	//out.println("trackRet>>>>>>>>>>>>>>>>>>>>>"+trackRet.toEzcString());
	

%>
<html>
<head>
<Title>List Of Users</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script src="../../Library/JavaScript/ezTrim.js"></script>

<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
<script>
function funClose()
{
	window.close()
}
</script>

</head>
<body onLoad='scrollInit()' onresize='scrollInit()' scroll="no">
    <form name=myForm method=post>
	
<%
	if (trackRet.getRowCount() > 0 )
	{
%>	
	
	<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center">
		<Td class="displayheader">Tracker </Td>
	</Tr>
	</Table>
	<div id="theads">
		<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
		<Tr align="left">
			<Th width="15%" align = "center">Viewed By</Th>
			<Th width="25%" align = "center">Viewed On</Th>
<%
		if("TA".equals(newsType))
		{
%>
			<Th width="25%" align = "center">Acknowledged On</Th>
<%
		}
%>	
	</Tr>
	</Table>
	</div>
	<div id="InnerBox1Div">
	<Table align="center" id="InnerBox1Tab" border=1 borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
<%
	String userId = "",viewedOn = "",ackOn = "",viewFlag="",ackFalg="";  
	for (int i = 0 ; i < trackRet.getRowCount(); i++)
	{

		userId	 =	trackRet.getFieldValueString(i,"ENR_USER");
		viewedOn =	GlobObj.getFieldValueString(i,"ENR_VIEWED_DATE");
		viewFlag =	trackRet.getFieldValueString(i,"ENR_VIEWED");
		ackOn    =	GlobObj.getFieldValueString(i,"ENR_CONFIRMED_DATE");
		ackFalg =	trackRet.getFieldValueString(i,"ENR_CONFIRMATION");
		String tempAckOn = ackOn.split("/")[2]; 
%>
		<Tr align="left">
		
			<Td width="15%">
				&nbsp;<%=userId.trim()%></a>
			</Td>
			<Td width="25%" >
				&nbsp;<%=viewedOn.trim()%>
			</Td>
<%
			if("TA".equals(newsType) && !"1900".equals(tempAckOn))
			{
%>
				<Td width="25%" >
					&nbsp;<%=ackOn.trim()%>
				</Td>	
<%
			}
			else{
%>
				<Td width="25%" >
					&nbsp;
				</Td>	
<%
			}
%>			
		</Tr>
<%
	}
%>
	</Table>
	</div>	
	
	<div id="ButtonDiv" align="center" style="position:absolute;top:60%;width:100%">
		<a href="javascript:funClose()"><img src="../../Images/Buttons/<%= ButtonDir%>/close.gif" border=none></a>
		
	</div>	
<%
	}
	else
	{
%>
		<Table  width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr align="center">
			<Td class="displayheader">No Users to list</Td>
		</Tr>
		</Table>
		<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
			<a href="javascript:funClose()"><img src="../../Images/Buttons/<%= ButtonDir%>/close.gif" border=none></a>
		
		</div>		
<%
	}
%>	
	
</form>
</body>
</html>
