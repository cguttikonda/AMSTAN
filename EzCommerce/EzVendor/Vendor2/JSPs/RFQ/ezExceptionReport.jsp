<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iblockcontrol.jsp" %>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Rfq/iExceptionReport.jsp" %>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<%
	ezc.ezutil.FormatDate fD=new ezc.ezutil.FormatDate();
	
%>

<html>
<head>
	<Script>
		var tabHeadWidth=90
		var tabHeight="65%"
		function CloseQCF(reason)
		{
			url = "ezShowReasons.jsp?Reason="+reason;
			dialogvalue=window.showModalDialog(url,"","center=yes;dialogHeight=20;dialogWidth=25;help=no;titlebar=no;status=no;resizable=no")
		}
		function SAPView(num)
		{
			var url="ezQCFSAPPrint.jsp?qcfNumber="+num;
			var sapWindow=window.open(url,"newwin","width=850,height=650,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
		}
		function funOpenWin(colNo)
		{
			document.myForm.commentType.value="QUERY";
			var retValue = window.showModalDialog("ezAddQcfQueriesWindow.jsp?TYPE=REPORT&COLNO="+colNo+"&DOCTYPE=QCF",window.self,"center=yes;dialogHeight=30;dialogWidth=50;help=no;titlebar=no;status=no;minimize:yes")	
		}
	</Script>

	<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
</head>
<body onLoad="scrollInit()" onResize="scrollInit()">
<form name="myForm">
<input type ="hidden" name="reasons" value ="">
<input type ="hidden" name="commentType" value ="">
<%
	String headerMsg ="";
	if(status.equals("S"))
		headerMsg ="List of QCF(s) closed with some specials reasons.";
	else if(status.equals("W"))
	        headerMsg ="List of QCF(s) closed because of 2 week elapsed." ;
	else if(status.equals("R"))      		
 		headerMsg ="List of QCF(s) closed because of RFQ expired." ;

	String display_header = "";
	
	if(retNewCount == 0)
	{
		display_header = "";
%>
		<%@ include file="../Misc/ezDisplayHeader.jsp"%>

		<br><br><br><br>
		<table width="50%" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 align="center">
			<tr align="center">
				<th>No&nbsp;<%=headerMsg%></th>
			</tr>
		</table>
		<br>
		

<%
	}else{
		ezc.ezparam.ReturnObjFromRetrieve globalRet = null;
						
		Vector grtypes = new Vector();
		grtypes.addElement("date");
		EzGlobal.setColTypes(grtypes);
		EzGlobal.setDateFormat("dd.MM.yyyy hh:mm");

		Vector grColNames = new Vector();
		grColNames.addElement("RFQ_DATE");
		EzGlobal.setColNames(grColNames);
		
		globalRet = EzGlobal.getGlobal(myRet);
		
	
		display_header = headerMsg;
%>
		<%@ include file="../Misc/ezDisplayHeader.jsp"%>
		<br>
		<DIV id="theads">
			<Table id="tabHead" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1  width="90%">
				<tr align="center" valign="middle">
					
					<th width="20%">QCF</th>
					<th width="25%">Material</th>
					<th width="15%">RFQ Date</th>
					<th width="15%">RFQ Valid Upto</th>
					<th width="15%">Sent To</th>
<%						
					if(status.equals("S"))
					{
%>
						<th width="5%">Reasons</th>
<%
					}
					
%>
						<th width="5%">Query</th>

				</tr>
			</Table>
 		</DIV>
		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:70%;height:80%;left:2%">
			<TABLE id="InnerBox1Tab" width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >

<%
				java.util.Date rfqDate 	= null;
				java.util.Date validUpto= null;
				int totQuoted		= 0;
				int totRFQs		= 0;
				for(int i=0;i<retNewCount;i++)
				{
					rfqDate	  =  (java.util.Date)myRet.getFieldValue(i,"RFQ_DATE");
					validUpto =  (java.util.Date)myRet.getFieldValue(i,"VALID_UPTO");
					totQuoted =  Integer.parseInt(myRet.getFieldValueString(i,"TOT_QUOTED"));
					totRFQs	  =  Integer.parseInt(myRet.getFieldValueString(i,"TOT_RFQ"));
				
%>
					<tr><td width="20%" align="center">
<%				
						if(status.equals("W") || status.equals("S"))
						{
%>
							<a href="javascript:SAPView('<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>')"><%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%></a>
<%
						}
						else
						{
%>
							<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>
<%
						}
%>
						</td><td width="25%"><%=myRet.getFieldValueString(i,"MATERIAL_DESC")%></td>
						
						<td width="15%" align="center"><%=globalRet.getFieldValue(i,"RFQ_DATE")%></td>
						<td width="15%" align="center"><%=fD.getStringFromDate(validUpto,".",fD.DDMMYYYY)%></td>						
						<td width="15%" align="center"><%=myRet.getFieldValueString(i,"TOT_RFQ")%></td>
<%						
												
						if(status.equals("S"))
						{
%>						
							
							<td width="5%" align="center"><a href="javascript:CloseQCF('<%=myRet.getFieldValueString(i,"REASON")%>')">Reasons</a></td>
<%
						}
						
%>
							<td align="center" width="5%"><a  style='text-decoration:none'  href="javascript:funOpenWin('<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>')"><img style="cursor:hand;border:none" src='../../Images/FAQs/question.gif'></a></td>

					</tr>
<%
				}
%>
			</TABLE>
		</DIV>	

		<Div id="EzButtonDiv" align=center style="position:absolute;top:90%;visibility:visible;width:100%">
<%
		  	 butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
			 butActions.add("history.go(-1)");
		    	 out.println(getButtons(butNames,butActions));
		  
  %>
			
		</Div>

<%   
	}  
%>
</form>
<Div id="MenuSol"></Div>
</body>
</html>