<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ page language="java" isErrorPage="true"%>
<%@ page import = "ezc.ezcommon.EzJSPExceptionHandler" %>
<html>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<%
	response.setHeader("Pragma", "No-cache");
	response.setDateHeader("Expires", 0);
	response.setHeader("Cache-Control", "no-cache");
	
	String errorMessage = "";
	if(session.isNew())
	{
		session.invalidate();
		errorMessage = "It is very long time since you submit your last request.";
	}
	else
	{
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
					if(eMsg.indexOf("No Connection Manager Available ") != -1)
					{
						errorMessage = "Services are temporarily unavailable....Please try after sometime.<BR>Inconvenience is regretted";
					}
					else if(eMsg.indexOf("getInvoiceDetails") != -1)
					{
						errorMessage = "Sorry! Details for this invoice are not available.";
					}
					else if(eMsg.indexOf("Not Authorized") != -1)
					{
						errorMessage = "Sorry! You are not authorized to view this data.";
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
	}
%>
<body>
<script>
	top.banner.location.href='ezBlank.htm'
	top.menu.location.href='ezBlank.htm'
	top.display.location.href='../../Library/Globals/ezValidVendorUserError.jsp'
</script>
</body>
</html>