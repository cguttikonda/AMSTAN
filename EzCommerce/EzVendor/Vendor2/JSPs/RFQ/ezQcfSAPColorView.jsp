<%@ page import="ezc.ezparam.ReturnObjFromRetrieve,ezc.ezcommon.*,java.util.*" %>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%!
	public static String replaceString(String theString,String from,String to)
	{
		int go=0;
		String ret=theString;
		while (ret.indexOf(from,go)>=0)
		{
		go=ret.indexOf(from,go);
		ret=ret.substring(0,go)+to+ret.substring(go+from.length());
		go=go+to.length();
		}
		return ret;
	}
%>
<%@ include file="../../../Includes/JSPs/Misc/iGetUserName.jsp" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>


<%
	String collNo=(String)session.getValue("repCollRFQ");
	java.util.Vector rfqVector=(java.util.Vector)session.getValue("repRFQVect");
%>

<% 
 
	String syskeyz = (String)session.getValue("SYSKEY");    	
    	ezc.ezutil.FormatDate fd = new ezc.ezutil.FormatDate();
    
    	ezc.ezpreprocurement.client.EzPreProcurementManager ezpreprocurementmanager  = new ezc.ezpreprocurement.client.EzPreProcurementManager();
    	String commentNo = "";
    	ezc.ezparam.EzcParams mainParamsx = new ezc.ezparam.EzcParams(false);
    	ezc.ezpreprocurement.params.EziQcfCommentParams qcfParams= new ezc.ezpreprocurement.params.EziQcfCommentParams();
    	qcfParams.setQcfCode(collNo);
    	qcfParams.setQcfType("COMMENTS");
    	qcfParams.setQcfExt1("$$");
    	mainParamsx.setLocalStore("Y");
    	mainParamsx.setObject(qcfParams);
    	Session.prepareParams(mainParamsx);
    	ezc.ezparam.ReturnObjFromRetrieve commentsRet = (ezc.ezparam.ReturnObjFromRetrieve)ezpreprocurementmanager.getMaxCommentNo(mainParamsx);
    	
    	if(commentsRet!= null)
    	{
    		commentNo = commentsRet.getFieldValueString(0,"COMMENT_NO");
    		if(commentNo == "null" || "null".equals(commentNo))
    			commentNo = "1";
    	}		
    	else
    		commentNo = "1";
    	commentsRet = (ezc.ezparam.ReturnObjFromRetrieve)ezpreprocurementmanager.getQcfCommentList(mainParamsx);
    	int qcsCount = 0;
    	String comments = "";
    	if(commentsRet != null)
    	{
    		qcsCount = commentsRet.getRowCount();
    		if(qcsCount > 0)
		{
			StringBuffer commentsBuffer = null;
			String commentsString= "";
			String time = "";
			//comments = "<table width='96%' style= background:#FEFEB8  class='list' border=0 cellSpacing=1 cellpadding=1 rules=groups borderColor=black >";
			comments = "<Table width='95%' style= background:#EEF9FF class='list'  border=0 cellSpacing=1 cellpadding=1 rules=groups borderColor=black ><colgroup><colgroup><colgroup><colgroup>";
			
			
			comments += "<tr><td colspan=3 width='100%'>&nbsp;&nbsp;<b><font size=2>Comments : </font></td></tr>";
			for(int i=0;i<qcsCount;i++)
			{
				try{
					commentsString = commentsRet.getFieldValueString(i,"QCF_COMMENTS");
					commentsBuffer = new StringBuffer(commentsString);
					int comDiv = Math.round(commentsString.length()/75);
					time = commentsRet.getFieldValueString(i,"QCF_DATE");
					time = time.substring(11,16);
					
					for(int j=1;j<=comDiv;j++)
					{
						commentsBuffer.insert(j*75,"¥");
					}
					commentsString = commentsBuffer.toString();			
					commentsString = replaceString(commentsString,"¥","</font><//td><td>|<//td><//tr><tr><td>|<//td><td><font size=1>&nbsp;&nbsp;");
					}catch(Exception ex)
					{
						commentsString = commentsRet.getFieldValueString(i,"QCF_COMMENTS");
					}	

					comments += "<tr rowspan=2><td colspan=3><font size=2>&nbsp;&nbsp;By "+getUserName(Session,commentsRet.getFieldValueString(i,"QCF_USER"),"U",syskeyz)+" On "+fd.getStringFromDate((Date)commentsRet.getFieldValue(i,"QCF_DATE"),".",ezc.ezutil.FormatDate.DDMMYYYY)+" "+time +":</font></td></tr>";
					comments += "<tr wrap><td td colspan=3 wrap><font size=1>&nbsp;&nbsp;"+commentsString+"<font></td></tr>";
					
			}
			comments += "</Table>";		
    		}
    	}

    
  
%>

<%@ include file="../../../Includes/JSPs/Rfq/iExecuteQCFReport.jsp"%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setDateHeader("Expires", 0);
	response.setHeader("Cache-Control", "no-cache");
%>
<%
int a=0;
StringBuffer sb=new StringBuffer();
int count = outTable.getRowCount();
String str="";
try
{
	
	
	

	if ( outTable != null )
	{
		for ( int i = 0 ; i < count; i++ )
		{

			String line = outTable.getLine(i);
			if (line.length() == 257)
				line = line.substring(1,line.length()-1);
			else
				line = line.substring(1,line.length());
			
			sb.append(line);

		}
	}

	str=sb.toString();

	str = str.substring(str.indexOf("</tr>")+5);
	//str = str.substring(str.indexOf("</tr>")+5);

	a=str.indexOf("</table>");

	
     

}catch(Exception e)
{
	out.println(e);
	out.println("<br><br><br><br><Center><h3> There is no output for passed    parameters </h3></Center>");

}

%>




<html>
<head>
	<title>
		Quotation Comparision Form for Collective RFQ No : <%=collNo%>
	</title>
	<%//@include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
</head>
<body>

<form name="myForm" method="post">
	<table width="80%"  border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=0 cellSpacing=1 >
	<%
	    if(count>1)
	    {
	%>	    
		<tr>
		<td>
		<pre><font size="2">
		<%
			//out.println("<table  class='list' border=0 frame='vsides' rules='cols' borderColorDark=#ffffff borderColorLight=#cccccc cellPadding=0 cellSpacing=1 >");
			out.println(" <table  class='list'  border=1 cellSpacing=0 cellpadding=0 rules=groups borderColor=black ><colgroup><colgroup><colgroup><colgroup>");
			 
			out.println(str.substring(0,a+8));
		
		
		%></font></pre>
		</td>
		</tr>
		
		<tr>
		<td  align=left>
		<p style="page-break-before:always">
		<pre><font size="2"><%=comments%></font></pre>
		</td>
		</tr>
	<%  }else{ %>
		<tr>
		<td>
		<font size="2">Collective RFQ Number <%=collNo%> does not exist.</font>
		</td>
		</tr>
	<%  } %>
	
	
	</Table>
	


</form>
<Div id="MenuSol"></Div>
</body>
</html>
















