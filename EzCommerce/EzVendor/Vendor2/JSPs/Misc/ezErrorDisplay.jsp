<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ page language="java" isErrorPage="true"%>
<%@ page import = "ezc.ezcommon.EzJSPExceptionHandler" %>
<html>
<head>
<script> 
	function logOut()
	{
		top.location.href="../../../Vendor2/JSPs/Misc/ezLogout.jsp" ;
		
	}	
</script> 
<title>EzCommerce ... The Next Generation eBusiness solutions</title>
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
</head>
<body scroll=no>
<Div id='inputDiv' style='position:relative;align:center;top:10%;width:100%;height:100%'>
		<Table width="60%" height="20%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
		<Tr>
			<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
			<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
			<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
		</Tr>
		<Tr>
			<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
			<Td style="background-color:'F3F3F3'" valign=middle>
				<Table border="0" align="center" valign=middle width="100%" cellpadding=10 cellspacing=10 class=welcomecell>
				<Tr> 
					<Td style="background-color:'F3F3F3'" valign=middle align=center>
						<font size="4">
							System Error.<BR> Please try again but if the error message reappears then contact us.
						</font>
						<br><br>
							<font size="2">
								Please click <a href="Javascript:logOut()">here</a> to login again.
							</font>	
					</Td>
				</Tr>
				</Table>
			</Td>
			<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif"></Td>
		</Tr>
		<Tr>
			<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
			<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
			<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
		</Tr>
		</Table>
	</Div>
<Div id="MenuSol"></Div>
</body>
</html>