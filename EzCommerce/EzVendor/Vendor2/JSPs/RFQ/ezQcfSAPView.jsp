<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iGetUserName.jsp" %>
<%@ page import="ezc.ezparam.ReturnObjFromRetrieve" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@page import="ezc.ezcommon.*,java.util.*"%>
<jsp:useBean id="ShManager" class="ezc.ezshipment.client.EzShipmentManager" scope="session" />
<% 
 
    	String qcfNum = request.getParameter("qcfNumber");
    	ezc.ezutil.FormatDate fd = new ezc.ezutil.FormatDate();
    
    	ezc.ezpreprocurement.client.EzPreProcurementManager ezpreprocurementmanager  = new ezc.ezpreprocurement.client.EzPreProcurementManager();
    	String commentNo = "";
    	ezc.ezparam.EzcParams mainParamsx = new ezc.ezparam.EzcParams(false);
    	ezc.ezpreprocurement.params.EziQcfCommentParams qcfParams= new ezc.ezpreprocurement.params.EziQcfCommentParams();
    	qcfParams.setQcfCode(qcfNum);
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
			comments = "<table width='100%' align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=0 cellSpacing=1>";
			comments += "<tr><td colspan=3>&nbsp;&nbsp;_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ </td></tr>";
			comments += "<tr><td>|</td><td>&nbsp;&nbsp;<b><font size=2>Comments : </font></td><td>|</td></tr>";
			comments += "<tr><td colspan=3>&nbsp;&nbsp;_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ </td></tr>";
			for(int i=0;i<qcsCount;i++)
			{
				try{
					commentsString = commentsRet.getFieldValueString(i,"QCF_COMMENTS");
					//commentsString = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz";
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

					comments += "<tr><td>|</td><td><font size=2>&nbsp;&nbsp;By "+getUserName(Session,commentsRet.getFieldValueString(i,"QCF_USER"),"U",,(String)session.getValue("SYSKEY"))+" On "+fd.getStringFromDate((Date)commentsRet.getFieldValue(i,"QCF_DATE"),".",ezc.ezutil.FormatDate.DDMMYYYY)+" "+time +":</font></td><td>|</td></tr>";
					comments += "<tr><td>|</td><td><font size=1>&nbsp;&nbsp;"+commentsString+"<font></td><td>|</td></tr>";
					
			}
			comments += "<tr><td colspan=3>&nbsp;&nbsp;_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ </td></tr>";
			comments += "</Table>";		
    		}
    	}

    
    System.out.println(comments);
    String extraData = "";
    
    ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(true);
    EziPrintParams params= new EziPrintParams();
    params.setObjectType("QCF");
    params.setObjectNo(qcfNum);
    params.setDocType("TEXT");
    mainParams.setObject(params);
    Session.prepareParams(mainParams);

    ezc.ezsap.V46B.generated.SoliTable myTable		= null;
    ezc.ezsap.V46B.generated.SoliTableRow myTableRow	= null;
	
    try
    {
    	myTable=(ezc.ezsap.V46B.generated.SoliTable)ShManager.ezGetPrintVersion(mainParams);
    }
    catch(Exception e)
    {
    	System.out.println("Exception Occured in ezQcfSAPView.jsp:"+e);
    }
    int rowCount = 0;
    
    if(myTable!=null)
    	rowCount = myTable.getRowCount();

    String data="";
    for(int i=0;i<rowCount;i++)
    {
	myTableRow=myTable.getRow(i);
	data = data+myTableRow.getLine()+"<br>";
    }
    System.out.println(data);
%>
	
<html>
<head>
	<title>Quotation Comparision Form for Collective RFQ No : <%=qcfNum%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</title>
</head>
<body bgcolor='white'>
<form name="myForm" method="post">
	<table width="90%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=0 cellSpacing=1 >
	<%
	    if(rowCount>1)
	    {
	%>	    
		<tr>
		<td width="100%" align=center>
		<pre><font size="2"><%=data%></font></pre>
		</td>
		</tr>
		<tr>
		<td width="100%" align=left>
		<p style="page-break-before:always">
		<pre><font size="2"><%=comments%></font></pre>
		</td>
		</tr>
	<%  }else{ %>
		<font size="2">Collective RFQ Number <%=qcfNum%> does not exist.</font>
	<%  } %>
	</td>
	<tr>
	</Table>
	<center>
	<!--<img src="../../Images/Buttons/<%//=ButtonDir%>/ok.gif" style="cursor:hand" border=none onClick="window.close()">-->
	</center>

</form>
<Div id="MenuSol"></Div>
</body>
</html>