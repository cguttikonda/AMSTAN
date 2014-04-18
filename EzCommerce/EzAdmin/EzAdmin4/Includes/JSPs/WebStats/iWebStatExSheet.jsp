<%@ page import="ezc.ezparam.ReturnObjFromRetrieve,ezc.ezbasicutil.EzExcelDriver" %>
<%@ page import="java.util.StringTokenizer,java.util.Vector" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%
	EzExcelDriver ed=null;  
	ReturnObjFromRetrieve retObj=null;
	String result=null;
	retObj=(ReturnObjFromRetrieve)session.getValue("WebStatReturnObject");
	String xfilename="EyeBallTrackInfo.xls";

	if(retObj!=null)
	{
		Vector columns=new Vector();
		columns.add("EZDATE");
		columns.add("EZUSER");
		columns.add("EZCOUNT");
		retObj.replaceColumn("EZDATE","EZDATE");
		retObj.replaceColumn("EZUSER","EZUSER");
		retObj.replaceColumn("EZCOUNT","EZCOUNT");
		
		ed=new EzExcelDriver();
		
		try
		{
			result=ed.ezCreateExcel(xfilename.trim(),"Sheet1",response,retObj,columns);
		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e.getMessage());
		}
	}			
%>