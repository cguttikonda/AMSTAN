<%@ page language="java" isErrorPage="true"%>
<%@ page import = "ezc.ezcommon.EzJSPExceptionHandler" %>
<%@ include file="../../../Includes/JSPs/Lables/iErrorDisplay_Lables.jsp"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />

<html>
<head>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%
	session.putValue("beingUsed","N");
	if(session.isNew())
	{
		session.invalidate();
%>
</head>
<body align="center">
	<br><br><br>
	<center>
	<font face="arial" color="#006666" size="+1">
		&nbsp;<%=loginAgain_L%>&nbsp;<a href="/" onMouseOver="window.status='Click here to re-login.';return true;" onMouseOut="window.status='';return true;" target="_top">login</a> again.
	</font>
	</center>
</body>
</html>	
<%
	}
	else
	{
%>
</head>
<body>
<%
		String errorMessage = null;
		Exception e = (Exception)request.getAttribute("javax.servlet.jsp.jspException");
		EzJSPExceptionHandler exHandler1 = new EzJSPExceptionHandler();
		Object ss1=exHandler1.handleException(e);
		
		if(e.getClass() == ezc.ezutil.EzJspException.class)
		{
			ezc.ezparam.ReturnObjFromRetrieve retEx = (ezc.ezparam.ReturnObjFromRetrieve)((ezc.ezutil.EzJspException)e).getReturnObject();
			
			if(retEx != null)
			{
				String[] errMessages = retEx.getErrorMessages();
				int errCount = errMessages.length;
				for (int i=0;i<errCount;i++)
				{
		 			String eMsg = errMessages[i];
					int index=eMsg.indexOf("Ezc");
					if(eMsg.indexOf("No Connection Manager Available ") != -1)
					{
						errorMessage = serviceNotAvailable_L;
					}
					else if(eMsg.indexOf("Not Authorized") != -1)
					{
						errorMessage = notAuthToView_L;
					}
					else if(eMsg.indexOf("java.lang.Object") != -1)
					{
						errorMessage = serviceTempoUnAvailable_L;
					}
					else
					{
						errorMessage = serverBusy_L;
					}
					break;
				}
			}
		}
		else
		{
			errorMessage = serverBusyTAgain_L;
		}
%>
	<table height=100% width=100% valign=middle cellPadding=0 cellSpacing=0 >
	<tr>
		<td align=center class=blankcell>
			<IMG border=0 src="../../Images/sbusy.gif" >
		</td>
		<td align=center class=displayalert >
			<font color="CC0000"><%=errorMessage%></font>
		</td>
	<tr>
	
	</table>
	<Div id="MenuSol"></Div>
	</body>
	</html>
<%
	}
%>
