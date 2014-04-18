<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iblockcontrol.jsp" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@include file="../../../Includes/JSPs/Rfq/iListRFQByCollectiveRFQ.jsp"%>
<html>
<head>
<Title>List Of RFQs for Collective RFQ:<%=collNo%></Title>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<Script>
	var tabHeadWidth=90
	var tabHeight="70%"
</Script>
<script>
function Next(flagType)
{
	if(chkforqcs())
	{
		if(flagType == "A")
			document.myForm.action = "ezAllQuotationComparisionForm.jsp"
		else
			document.myForm.action = "ezOfflineQuotationComparisionForm.jsp"
		document.myForm.submit()
	}	
}
function Back()
{
	if('WFListQCF'=='<%=urlFrom%>'){
		document.myForm.action = "ezOfflineWFListQcfs.jsp";
	}else{
		document.myForm.action = "ezListQCS.jsp";
	}
	
	document.myForm.submit()
}

function chkforqcs()
{
	var chkObj 	= document.myForm.chk1;
	var chkLen	= chkObj.length;
	var count	= 0;
	if(!isNaN(chkLen))
	{
		for(i=0;i<chkLen;i++)
		{
			if(chkObj[i].checked)
			{
				count++;
			}
		}
	}
	else
	{
		if(chkObj.checked)
		{
			count = 1;
		}
	}
	if(count==0)
	{
			alert("Please select RFQs for Comparision")
			return false;
	}
	if(count<2)
	{
		alert("Please select atleast 2 RFQs for Comparision")
		return false;
	}
	else if(count>3)
	{
		alert("You can not select more than 3 RFQs for Comparision")
		return false;
	}			
	else	
		return true;
}	
</script>

<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
</head>
<body onLoad="scrollInit(10)" onResize="scrollInit(10)">
<form name="myForm">
<input type="hidden" name="urlFrom" value="<%=urlFrom%>">
<%
	String display_header = "RFQs List";
	
%>	<%//@ include file="../Misc/ezDisplayHeader.jsp"%>
<%
	if(myRetCnt == 0)
	{
%>
		<br><br><br><br>
		<Table width="50%" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 align="center">
		<Tr align="center">
			<th>No Collective RFQs Exist.</th>
		</Tr>
		</Table>
		<br>
		<Div id="buttons" style="position:absolute;top:92%;width:100%;visibility:visible" align="center">
			<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand" border=none onClick="JavaScript:Back()">
		</Div>
<%	}
	else
	{
%>
	<br><br>	
	<Table align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1  width="50%">
	</Tr>
		<Th width="50%">Collective RFQ No </Th>
		<Td width="50%"><%=collNo%></Td>
	</Tr>
	</Table>
	<br>
	<Div id="theads">
  	<Table id="tabHead" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1  width="90%">
	    	<tr align="center" valign="middle">
			<th width="5%">&nbsp;</th>
			<th width="15%">RFQ No</th>
			<th width="20%">Vendor</th>
			<th width="15%">Agent Code</th>
			<th width="15%">Quantity</th>
			<th width="15%">Price</th>
	    	</tr>
 	</table>
 	</DIV>
	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:70%;height:80%;left:2%">
	<TABLE id="InnerBox1Tab" width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
<%
	int chkcnt = 0;
	for(int i=0;i<myRetCnt;i++)
	{
		boolean quotedStat=false;
		String chkstat = "";
		if("R".equals(myRet.getFieldValueString(i,"RELEASE_INDICATOR")) || "Y".equals(myRet.getFieldValueString(i,"STATUS")))
		{
			quotedStat=true;
			
			if("WFListQCF".equals(urlFrom)){
				if("R".equals(myRet.getFieldValueString(i,"RELEASE_INDICATOR")))
					chkstat = "checked";
				else
					chkstat = "";
			}else{
				if(chkcnt < 3)	
					chkstat = "checked";

				if("Y".equals(myRet.getFieldValueString(i,"STATUS")))
					chkcnt++;
			
			}
			
				
		}	
		else
			chkstat = "";
		
		String stat = myRet.getFieldValueString(i,"EXPIRY_STATUS");
		if("Y".equals(stat))
			stat = "";
		else
			stat = "Disabled";
		if(quotedStat){	
%>	
			<tr>
				<td width="5%"  align="center"><input type="checkbox" name="chk1" value='<%=myRet.getFieldValueString(i,"RFQ_NO")%>' <%=stat%> <%=chkstat%> ></td>
				<td width="15%" align="center"><%=ezCheckForNull(myRet.getFieldValueString(i,"RFQ_NO"),"&nbsp;")%></a></td>
				<td width="20%" align="center"><%=ezCheckForNull(myRet.getFieldValueString(i,"VENDOR"),"&nbsp;")%></td>
				<td width="15%" align="center"><%=ezCheckForNull(myRet.getFieldValueString(i,"AGENT_CODE"),"&nbsp;")%></td>
				<td width="15%" align="center"><%=ezCheckForNull(myRet.getFieldValueString(i,"QUANTITY"),"&nbsp;")%></td>
				<td width="15%" align="center"><%=ezCheckForNull(myRet.getFieldValueString(i,"PRICE"),"&nbsp;")%></a></td>
			</tr>
<%
		}
	}
%>
	</table>
	</div>
	<input type="hidden" name="collectiveRFQNo" value="<%=collNo%>">
	<input type="hidden" name="Type" value='<%=request.getParameter("Type")%>'>
	<input type="hidden" name="isdelegate" value='<%=request.getParameter("isdelegate")%>'>
	<input type="hidden" name="collectiveList" value="Y">
	
	<div id="buttons" style="position:absolute;top:92%;width:100%;visibility:visible" align="center">
		<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand" border=none onClick="JavaScript:Back()">
		<img src="../../Images/Buttons/<%=ButtonDir%>/next.gif" style="cursor:hand" border=none onClick="JavaScript:Next('<%=request.getParameter("Type")%>')">
		<a href="../Misc/ezOfflineLogout.jsp" target="_top"><img src="../../Images/Buttons/<%=ButtonDir%>/logout_butt.gif" alt="Logout" border=none></a>	
	</div>
<% 
	}  
%>	
	
<%!
	public String ezCheckForNull(String str,String defStr)
	{
		if((str==null) || ("null".equals(str)) || ((str.trim()).length() == 0))
			str = defStr;
		return str.trim();
	}
%>

</form>
<Div id="MenuSol"></Div>
</body>
</html>