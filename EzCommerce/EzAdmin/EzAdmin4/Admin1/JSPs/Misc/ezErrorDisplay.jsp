<%@ page language="java" isErrorPage="true"%>
<%@ page import = "ezc.ezcommon.EzJSPExceptionHandler" %>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<html>
<head>
<title>EzCommerce Administration Module</title>
<%
	response.setHeader("Pragma", "No-cache");
	response.setDateHeader("Expires", 0);
	response.setHeader("Cache-Control", "no-cache");
	if(session.isNew())
	{
		session.invalidate();
%>	
		</head>
		<body align="center">
		<br><br><br><center><font face="arial" color="#000000" size="+1">It is very long time since you submit your last request.<br>Please <a href="../../../../../../ezLogin.jsp" target="_parent">click here</a> to login again.
		
		</font></center>
		</body>
		</html>	
<%	
	}
	else
	{
%>
		</head>
		<body bgcolor="#FFFFFF">
	<%

		String errorMessage = null;
		Exception e = (Exception)request.getAttribute("javax.servlet.jsp.jspException");
		EzJSPExceptionHandler exHandler1 = new EzJSPExceptionHandler();
		Object ss1=exHandler1.handleException(e);
		if ( e.getClass() == ezc.ezutil.EzJspException.class )
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
					if(eMsg.indexOf("No Connection Manager Available") != -1)
					{
						errorMessage = "This service is temporarily unavailable.Please try after sometime.<br>Inconvenience is regretted.";
					}
					else
					{
						errorMessage = "Server is busy.<br>Please try after sometime.";
					}
					break;
				}
			}
		}
		else
		{
			errorMessage = "Server is busy.<br>Please try  again.";
		}
			errorMessage = "System Error.<BR>Please try again but if the error message reappears then contact us.";
		
%>
		<br><br><br><br><br><center><font face="verdana" color="#000000" size="+1"><%=errorMessage%><br>Please <a href="../../../../../../ezLogin.jsp" target="_parent">click here</a> to login again.
</center>
		</body>
		</html>
<%
	}
%>
