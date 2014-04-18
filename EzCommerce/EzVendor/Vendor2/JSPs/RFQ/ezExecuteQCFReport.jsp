<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%@ include file="../../../Includes/JSPs/Rfq/iExecuteQCFReport.jsp"%>
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
	StringBuffer sb=new StringBuffer();

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
                        //out.print(line);
                        sb.append(line);
	        	
		}
	}

	String str=sb.toString();

	str = str.substring(str.indexOf("</tr>")+5);
	str = str.substring(str.indexOf("</tr>")+5);



	int a=str.indexOf("</table>");
	
	out.println("<table  class='list' border=0 cellSpacing=1 cellpadding=1 rules=groups borderColor=black >");
	out.println(str.substring(0,a+8));
	
	
	
	
       

}catch(Exception e)
{
out.println(e);
out.println("<br><br><br><br><Center><h3> There is no output for passed    parameters </h3></Center>");
//response.sendRedirect("../Htmls/Error.htm");
}
}
%>


