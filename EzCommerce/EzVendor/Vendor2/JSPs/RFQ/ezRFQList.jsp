<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@include file="../../../Includes/JSPs/Rfq/iRFQList.jsp"%>
<%
	ezc.ezutil.FormatDate fD=new ezc.ezutil.FormatDate();
	int myRetCount = myRet.getRowCount();	
	java.util.Hashtable hashTable = (java.util.Hashtable)session.getValue("rankHash"); 
	if(hashTable==null) hashTable =new java.util.Hashtable();
	/*String[] ranks = request.getParameterValues("ranks");
	
	java.util.StringTokenizer stoken = null;
	int rankslen = ranks.length;
	String QuotNo="",vendRank=""; 
	
	for(int i=0;i<rankslen;i++)
	{
		stoken	= new java.util.StringTokenizer(ranks[i],"е");
		QuotNo	= (String)stoken.nextElement();
		vendRank= (String)stoken.nextElement();
		if(vendRank==null || "null".equals(vendRank))
			vendRank="-1";
		hashTable.put(QuotNo,vendRank);
	}*/	
%>
<html>
<head>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<Script>
	var tabHeadWidth=70
	var tabHeight="35%"
</Script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<script>
function funBack()
{
	document.myForm.action="ezQCS.jsp?collectiveRFQNo=<%=collectiveRFQNo%>";
	document.myForm.submit();
}
function createPO()
{	
	var Count = 0;
	var len = document.myForm.chk1.length;
	if(isNaN(len))
	{
		if(document.myForm.chk1.checked)
		{
			if(document.myForm.status.value == 'N' || document.myForm.status.value == 'R')
			{
				alert("You cannot Create PO for this RFQ");
				document.myForm.chk1.checked = false;
				return;
			}
			else
			{
				Count++;	
			}
		}
	}	
	else
	{
		for(var i=0;i<len;i++)
		{
			if(document.myForm.chk1[i].checked)	
			{
				
				if(document.myForm.status[i].value == 'N' || document.myForm.status[i].value == 'R')
				{
					alert("You cannot Create PO for this RFQ");
					document.myForm.chk1[i].checked = false;
					return;
				}
				else
				{
					Count++;	
				}
				/* Added by Ramesh.S on 13/12/2004 */
				
				var rank = document.myForm.ranks[i].value
				if(rank != 1)
				{
					url = "ezRemarks.jsp";
					values="";
					dialogvalue=window.showModalDialog(url,values,"center=yes;dialogHeight=16;dialogWidth=20;help=no;titlebar=no;status=no;resizable=no")
					if ((dialogvalue=='Canceld~~')||(dialogvalue==null))
					{
					}
					else
					{
						document.myForm.remarks.value = dialogvalue;
					}
				}
				
			}			
		}
	}
	if(Count < 1)
	{
		alert("Please Select atleast one RFQ to Create PO.")	
		return;
	}
	
	document.myForm.action = "ezCreatePO_New.jsp";
	document.myForm.submit();
}
function selectQuotes()
{
	var Count = 0;
	var len = document.myForm.chk1.length;
	if(isNaN(len))
	{
		if(document.myForm.chk1.checked)
		{
			if(document.myForm.status.value == 'N' || document.myForm.status.value == 'R')
			{
				alert("You cannot couner offer for this RFQ");
				document.myForm.chk1.checked = false;
				return;
			}
			else
			{
				Count++;	
			}
		}
	}	
	else
	{
		for(var i=0;i<len;i++)
		{
			if(document.myForm.chk1[i].checked)	
			{
				if(document.myForm.status[i].value == 'N' || document.myForm.status[i].value == 'R')
				{
					alert("You cannot couner offer for this RFQ");
					document.myForm.chk1[i].checked = false;
					return;
				}
				else
				{
					Count++;	
				}
			}
		}
	}
	if(Count < 1)
	{
		alert("Please Select atleast one RFQ to send Counter Offer.")	
		return;
	}
	document.myForm.action = "ezCounterOffer.jsp";
	document.myForm.submit();	
}
function sendReminder()
{
	var Count = 0;
	var len = document.myForm.chk1.length;
	if(isNaN(len))
	{
		if(document.myForm.chk1.checked)
		{
			if(document.myForm.status.value == 'Y' || document.myForm.status.value == 'R')
			{
				alert("You cannot send reminders for this RFQ");
				document.myForm.chk1.checked = false;
				return;
			}
			else
			{
				Count++;	
			}
		}
	}	
	else
	{
		for(var i=0;i<len;i++)
		{
			if(document.myForm.chk1[i].checked)	
			{
				if(document.myForm.status[i].value == 'Y' || document.myForm.status[i].value == 'R')
				{
					alert("You cannot send reminders for this RFQ");
					document.myForm.chk1[i].checked = false;
					return;
				}
				else
				{
					Count++;	
				}
			}
		}
	}
	if(Count < 1)
	{
		alert("Please Select atleast one RFQ to send Reminder.")	
		return;
	}
	document.myForm.action = "ezSendReminderMail.jsp";
	document.myForm.submit();	
}
function rejectQuotes()
{
	var Count = 0;
	var len = document.myForm.chk1.length;
	if(isNaN(len))
	{
		if(document.myForm.chk1.checked)
		{
			if(document.myForm.status.value == 'Y')
			{
				alert("You cannot Reject this RFQ");
				document.myForm.chk1.checked = false;
				return;
			}
			else
			{
				Count++;	
			}
		}
	}	
	else
	{
		for(var i=0;i<len;i++)
		{
			if(document.myForm.chk1[i].checked)	
			{
				if(document.myForm.status[i].value == 'R')
				{
					alert("You cannot Reject this RFQ");
					document.myForm.chk1[i].checked = false;
					return;
				}
				else
				{
					Count++;	
				}
			}
		}
	}
	if(Count < 1)
	{
		alert("Please Select atleast one RFQ to Reject.")
		return;
	}
	/*if(Count == len)
	{
		alert("You cannot Reject All RFQs.")
		return;
	}*/
	document.myForm.action = "ezRejectRFQ.jsp";
	document.myForm.submit();	
}
</script>
</Head>
<body onLoad="scrollInit()" onResize="scrollInit()">
<form name="myForm" method="post">
<input type ="hidden" name="remarks" value ="">
<%
	if(myRetCount==0)
	{
%>
		<br><br><br><br>
		<table width="50%" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 align="center">
		<tr align="center">
			<th>No RFQs Exist.</th>
		</tr>
		</table>
		<br>
		<Center>
			<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand" border=none onClick="JavaScript:history.go(-1)">
		</Center>
</form>
</body>
</html>
<%
		return;
	}
%>
	<table align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1  width="40%">
  	<tr align="center">
    	<td class="displayheader">List of RFQs</td>
  	</tr></table><br>
	<DIV id="theads">
  	<table id="tabHead" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1  width="70%">
	    	<tr align="center" valign="middle">
			<th width="5%">&nbsp;</th>
			<th width="10%">RFQ No.</th>
			<th width="10%">Coll. RFQ No.</th>
			<th width="20%">Vendor</th>
			<th width="25%">RFQ Valid Upto</th>
			<th width="25%">Status</th>
			<th width="5%">Rank</th>
	    	</tr>
 	</table>
 	</DIV>
	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:70%;height:60%;left:2%">
	<TABLE id="InnerBox1Tab" width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
<%
	for(int i=0;i<myRetCount;i++)
	{
		String myStatus = "Quoted";
		String bgColor = "lightgreen";
		if("N".equals(myRet.getFieldValueString(i,"STATUS")))
		{
			myStatus = "Yet to be Quoted";
			bgColor = "lightblue";
		}
		else if("R".equals(myRet.getFieldValueString(i,"STATUS")))
		{
			myStatus = "Rejected";
			bgColor = "red";
		}
			
		java.util.Date dd=(java.util.Date)myRet.getFieldValue(i,"VALID_UPTO");
%>   
		<tr bgcolor = "<%=bgColor%>">
			<td width="5%"><input type="checkbox" name="chk1" value="<%=myRet.getFieldValueString(i,"RFQ_NO")%>ее<%=myRet.getFieldValueString(i,"SOLD_TO")%>ее<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>ее<%=myRet.getFieldValueString(i,"EXT1")%>ее<%=myRet.getFieldValueString(i,"EXT2")%>ее<%=myRet.getFieldValueString(i,"EXT3")%>"</td>
			<td width="10%"><a href = "ezRFQDetails.jsp?PurchaseOrder=<%=myRet.getFieldValueString(i,"RFQ_NO")%>&collectiveRFQNo=<%=collectiveRFQNo%>" ><%=myRet.getFieldValueString(i,"RFQ_NO")%></a></td>
			<td width="10%"><%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%></td>
			<td width="20%"><!--<a href = "ezVendorContactDetails.jsp?SysKey=<%//=myRet.getFieldValueString(i,"SYS_KEY")%>&SoldTo=<%//=myRet.getFieldValueString(i,"SOLD_TO")%>">--><%=myRet.getFieldValueString(i,"SOLD_TO_NAME")%><!--</a>--></td>
			<td width="25%"><%=fD.getStringFromDate(dd,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%></td>
			<td width="25%"><%=myStatus%></td>
			<%
				String Str = (String)hashTable.get(myRet.getFieldValueString(i,"RFQ_NO"));
				if(Str==null || "null".equals(Str))
					Str="-1";
			%>
			<td width="5%"><%=Str%><input type=hidden name="ranks" value="<%=Str%>"></td>			
	      	</tr>
	      	<input type = "hidden" name = "status" value = "<%=myRet.getFieldValueString(i,"STATUS")%>">
<%
	}
%>
	</table>
	</div>

	<div id="buttons" style="position:absolute;top:92%;width:100%;visibility:visible" align="center">
		
		<img src="../../Images/Buttons/<%=ButtonDir%>/createpo.gif" style="cursor:hand" border=none onClick="JavaScript:createPO()">
		<img src="../../Images/Buttons/<%=ButtonDir%>/requote.gif" style="cursor:hand" border=none onClick="JavaScript:selectQuotes()">
		<!--<img src="../../Images/Buttons/<%=ButtonDir%>/sendreminder.gif" style="cursor:hand" border=none onClick="JavaScript:sendReminder()">-->
		<!--<img src="../../Images/Buttons/<%=ButtonDir%>/reject.gif" style="cursor:hand" border=none onClick="JavaScript:rejectQuotes()">-->
		<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand" border=none onClick="funBack()">
	</div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
