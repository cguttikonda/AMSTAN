<%@ page language="java" isErrorPage="true"%>
<%@ page import = "ezc.ezcommon.EzJSPExceptionHandler" %>
<html>
<head>
<%
	Object Message = "";
	ezc.ezutil.EzSystem.out.println("********************* Error Display Page *************************");
	Exception e = (Exception)request.getAttribute("javax.servlet.jsp.jspException");

	if ( e.getClass() == ezc.ezutil.EzJspException.class )
	{
		ezc.ezparam.ReturnObjFromRetrieve ret = (ezc.ezparam.ReturnObjFromRetrieve)((ezc.ezutil.EzJspException)e).getReturnObject();
		if ( ret != null )
		{
			String[] errMessages = ret.getErrorMessages();
			int errCount = errMessages.length;
		 	for ( int i = 0 ; i < errCount ; i++ )
		 	{
				Message = Message + errMessages[i];

			}
		}
		else
		{
			Message = " Return Object is NULL ....";
		}
	}
	else
	{
		EzJSPExceptionHandler exHandler = new EzJSPExceptionHandler();
	 	Message  = exHandler.handleException(e);
	}
%>
<Title>Welcome to EzCommerce Administration Module.</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
</head>
<body>
<br><br><br><br>
<Table  width="90%" height = "60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center" height = "10%">
    		<Td class="displayheader"> WARNING!!! </Td>
	</Tr>
  	<Tr align="center">
  	  	<Td>
  	  		<b><%=Message%>
  	  	<br><br>
      		Contact your administrator for further assistance.</b>
      		</Td>
  	</Tr>
</Table>
</body>
</html>
