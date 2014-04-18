<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ page import="ezc.ezparam.*,java.util.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="MiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"></jsp:useBean>
<%
	/******************** Get Email Note Auth - Start **********************/
	
	String userId = Session.getUserId();
	ReturnObjFromRetrieve retObj = null;
	
	if(userId!=null && !"null".equals(userId) && !"".equals(userId))
	{
		userId = userId.toUpperCase();

		ezc.ezmisc.params.EziMiscParams miscParams = new ezc.ezmisc.params.EziMiscParams();
		EzcParams miscMainParams = new EzcParams(true);

		miscParams.setQuery("SELECT * FROM EZC_USER_DEFAULTS WHERE EUD_USER_ID ='"+userId+"' AND EUD_KEY='MAILNOTE'");
		miscMainParams.setObject(miscParams);
		miscMainParams.setLocalStore("Y");

		Session.prepareParams(miscMainParams);
		retObj = (ReturnObjFromRetrieve)MiscManager.ezSelect(miscMainParams);
	}

	/******************** Get Email Note Auth - End **********************/
%>
<html>
<Title>Email Notification Status</Title>
<head>
<Script src="../../Library/JavaScript/Misc/ezTrim.js"></Script>
<Script>
	function changeStatus(val)
	{
		var dispAct = "";

		if(val=='Y')
			dispAct = "Active";
		else if(val=='N')
			dispAct = "Block";

		var y = confirm("Are sure to "+dispAct+" email notifications?");

		if(eval(y))
		{
			document.myForm.action="ezEmailNotificationChange.jsp?changeStatus="+val;
			document.myForm.submit();
		}
	}
</Script>
</head>
<body scroll=no>
<form name=myForm method=post>
<input type="hidden" name="userId" value="<%=userId%>">
<%
	String display_header = "Email Notification Status";
%>
	<%@ include file="../Misc/ezDisplayHeader.jsp"%>

	<Table width="60%" align=center  border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
	<Tr>
		<Th width="50%">User Id</Th>
		<Th width="50%">Status</Th>
	</Tr>
	<Tr>
		<Td width="50%" align="center">&nbsp;<%=userId%></Td>
		<Td width="50%" align="center">&nbsp;
<%
		String status = retObj.getFieldValueString(0,"EUD_VALUE");
		String stDisp = "";
		
		if(status!=null && "N".equals(status))
		{
			stDisp = "Active";
%>					
			<img src="../../Images/Others/redball.gif" style="cursor:hand"  alt="Click Here To Change The Status" border=no onClick="changeStatus('Y')">
<%
		}
		else
		{
			stDisp = "Block";
%>						
			<img src="../../Images/Others/greenball.gif" style="cursor:hand"  alt="Click Here To Change The Status" border=no onClick="changeStatus('N')">
<%
		} 
%>
		</Td>
	</Tr>
	</Table>
	
<%
	String noDataStatement = "Please click on status to "+stDisp+" email notifications";
%>
	<%@ include file="../Misc/ezDisplayNoData.jsp"%>

	<Div  style="position:absolute;top:85%;width:100%" align="center">
	<Table>
	<Tr>
		<Td class='blankcell'><img src='../../Images/Others/greenball.gif' border=0>&nbsp;&nbsp;Active</Td>
		<Td class='blankcell'><img src='../../Images/Others/redball.gif' border=0>&nbsp;&nbsp;Blocked</Td>
	</Tr>
	</Table>
	</Div>
	
<Div id="MenuSol"></Div>
</body>
</html>