<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%
	String template=request.getParameter("template");
	String sysKey=request.getParameter("syskey");
	String participant=request.getParameter("participant");
	String desiredStep=request.getParameter("desiredStep");

	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWFParams params= new ezc.ezworkflow.params.EziWFParams();
	params.setTemplate(template);
	params.setSyskey(sysKey);
	params.setParticipant(participant);
	params.setDesiredStep(desiredStep);
	//params.setPartnerFunction("VN");
	mainParams.setObject(params);
	//out.println(params.getPartnerFunction());
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve usersRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkFlowUsers(mainParams);
%>
<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>

<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
</head>
<body onLoad="scrollInit()" onResize="scrollInit()" scroll="no" >
<br>
<%
if(usersRet!=null)
{

	if(usersRet.getRowCount() == 0)
	{
%>
		<br><br><br><br>
		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
		<Tr>
			<Th width="100%" align=center>
				No WorkFlow users to List.
			</Th>
		</Tr>
		</Table>
		<br>
		<center>
			<img src="../../Images/Buttons/<%= ButtonDir%>/back.gif"  style = "cursor:hand" alt="Click here to go to previous page" border=no onClick="JavaScript:history.go(-1)">
		</center>
<%
		return;
	}	
	else
	{
%>
		<Table  align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
		<Tr>
			<Td align=center class = "displayheader">List of WorkFlow Users</Td>
		</Tr>
		</Table>
		
		<Div id="theads">
		<Table id="tabHead" align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
		<Tr>
			<Th align=center width = "20%">User ID</Th>
			<Th align=center width = "40%">User Name</Th>
			<Th align=center width = "40%">E - Mail</Th>
		</Tr>
		</Table>
		</Div>

		<DIV id="InnerBox1Div">
		<Table id="InnerBox1Tab" align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<%
		for(int i=0;i<usersRet.getRowCount();i++)
		{
%>		
			<Tr>
				<Td align=center width = "20%"><%=usersRet.getFieldValueString(i,"EU_ID")%>&nbsp;</Td>
				<Td align=center width = "40%">
<%
 				String fname = usersRet.getFieldValueString(i,"EU_FIRST_NAME");
					if(fname != null) 
						fname = fname.trim(); 
					else fname="";
				String mname = usersRet.getFieldValueString(i,"EU_MIDDLE_INITIAL");
					if(mname !=null) 
						mname = mname.trim(); 
					else  mname = " ";
				String lname = usersRet.getFieldValueString(i,"EU_LAST_NAME");
					if(lname!=null) 
						lname=lname.trim(); 
					else lname = " ";
				String Name  = fname +" "+ mname +" "+  lname;
%>
					<%=Name%>			
				</Td>
				<Td align=center width = "40%"><%=usersRet.getFieldValueString(i,"EU_EMAIL")%>&nbsp;</Td>
		</Tr>
<%	
		}
%>
		</Table>
		</Div>

		<Div align=center id="ButtonDiv" style="position:absolute;top:90%;width:100%">
			<img src="../../Images/Buttons/<%= ButtonDir%>/back.gif"  style = "cursor:hand" alt="Click here to go to previous page" border=no onClick="JavaScript:history.go(-1)">
		</Div>
<%
	}
}

%>
</body>
</html>
