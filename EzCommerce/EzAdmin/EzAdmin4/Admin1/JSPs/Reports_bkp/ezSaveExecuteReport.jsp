<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Reports/iSaveExecuteReport.jsp"%> 
<%//@ include file="../../../Includes/JSPs/Lables/iAddSales_Lables.jsp" %>

<html>
<head>
<title>Create Sales Order -- Powered by EzCommerce Inc</title>
<table align=center border="0" cellpadding="0" style=' background-color:#e6e6e6' cellspacing="0" width="100%">
<tr>
    <td height="35" style=' background-color:#e6e6e6' width="40%">
<a style="text-decoration:none"  class=subclass href="../Misc/ezSalesHome.jsp" target="_top"><img src="../../Images/Buttons/English/Green/home_button.gif" width="54" height="17"  title="Home" alt="Home" border=0 style="cursor:hand"> </a>&nbsp; <a style="text-decoration:none"  class=subclass href="../Misc/ezLogout.jsp" target="_top"><img src="../../Images/Buttons/English/Green/logout_butt.gif" width="65" height="17"   title="Logout" alt="Logout" style="cursor:hand"  border=0></a></td>
    <td height="35" style='color: #006666;font-family: verdana, arial;font-size: 12px;font-weight: 600;text-decoration: none;'  width="60%">Reports</td>
</tr>  
</table>

<%
	response.setHeader("Pragma", "No-cache");
	response.setDateHeader("Expires", 0);
	response.setHeader("Cache-Control", "no-cache");
%>
<%
if("B".equals(exeType))
{
	ReturnObjFromRetrieve objNo=(ReturnObjFromRetrieve)bexec.getObject("EXECINFO");
	String autoNo = objNo.getFieldValueString(0,"EXECNO");
	response.sendRedirect("ezDisplay.jsp?autoNo="+autoNo);
}else
{

javax.servlet.ServletOutputStream sos=null;
//response.setContentType("application/x-download");
//response.setHeader ("Content-Disposition", "attachment;filename=Report.htm");
try
{

	int count = outTable.getRowCount();

	if ( outTable != null )
	{
		for ( int i = 0 ; i < count; i++ )
		{
		
		        String line = outTable.getLine(i);
                        if (line.length() == 257)
                                line = line.substring(1,line.length()-1);
                        else
                                line = line.substring(1,line.length());
                        out.print(line);
	        	
		}
	}
	
       

}catch(Exception e)
{
%>
	<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
			<Tr align="center">
				<Td class="displayheader">
					 There is no output for passed parameters 
				</Td>
			</Tr>
	</Table>
<%
}
}
%>
</html>

