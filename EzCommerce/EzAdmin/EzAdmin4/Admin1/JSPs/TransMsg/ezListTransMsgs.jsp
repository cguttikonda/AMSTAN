<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/InboxBean.jsp"%>
<%@ include file="../../../Includes/Lib/Inbox.jsp"%>
<%@ include file="../../../Includes/JSPs/TransMsg/iListTransMsgs.jsp"%>
<html>
<head>
<Title>Inbox: Personal Messages</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script>
	var tabHeadWidth=80
</script>
<Script src="../../Library/JavaScript/ezScrollDefine.js"></script>
<Script src="../../Library/JavaScript/ezScroll.js"></script>
</head>

<body scroll=no onresize="scrollInit()" onLoad="scrollInit()">

<form name=myForm method=post action="../Inbox/ezDelPersMsgs.jsp">


<%
  if(retProcessedMsgList.getRowCount()>0)
  {
%>

 <Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
  <Tr align="center">
    <Td class="displayheader">Processed Messages</Td>
  </Tr>
</Table>
 <div id="theads">
 <Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
   <Tr align="center" valign="middle">
      <Th width="23%">From </Th>
      <Th width="45%"> Subject </Th>
      <Th width="18%">Processed Date</Th>
      <Th width="18%">Processed Time</Th>
   </Tr>
 </Table>
 </div>
<DIV id="OuterBox1Div">
<DIV id="InnerBox1Div">
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width=100%>

<%
  for (int i = 0 ; i < retProcessedMsgList.getRowCount(); i++)
  {
%>
      <Tr align="center">
        <Td width="23%"><%=retProcessedMsgList.getFieldValueString(i, "ETM_CREATED_BY") %> </Td>
        <Td width="45%">
         <a href="ezDisplayTransMsgInfo.jsp?MessageID='<%=retProcessedMsgList.getFieldValueString(i,"ETM_MSG_ID").trim()%>'">
  	 <%=retProcessedMsgList.getFieldValueString(i,"ETM_MSG_HEADER")%>
  	</Td>
     	<Td width="18%"><%= retProcessedMsgList.getFieldValueString(i,"ETM_PROCESSED_DATE") %></Td>
        <Td width="18%"><%=retProcessedMsgList.getFieldValue(i,"ETM_PROCESSED_TIME")%></Td>
      </Tr>
<%
  }//End for
%>

 </Table>
</div>
</div>

<div id="ScrollBoxDiv" style="position:absolute;top:84%;left:87%;visibility:hidden">
   	<A HREF="javascript:void(0)" onmouseOver="scrolling=1;UpDn='dn'; javascript:scrollMessage(); return false;" onmouseOut="scrolling=0;clearTimeout(timerID)" onClick="javascript:pageUpDnMessage(); return false;">
    	<img name="scrollDn" src="../../Images/Buttons/<%= ButtonDir%>/down.gif" border="0" alt="Scroll Down"></a>
    	<A HREF="javascript:void(0)" onmouseOver="scrolling=1;UpDn='up'; javascript:scrollMessage(); return false;" onmouseOut="scrolling=0;clearTimeout(timerID)" onClick="javascript:pageUpDnMessage(); return false;">
    	<img name="scrollUp" src="../../Images/Buttons/<%= ButtonDir%>/up.gif" border="0" alt="Scroll Up"></a>
</div>
    <input type="hidden" name="DelFlag" value="N">

<%
  }//if(retProcessedMsgList.getRowCount()>0)
else
{
%>

  <br><br>
  <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
  	<Tr>
  		<Td class = "labelcell">
  			<div align="center"><b>No Messages To List</b></div>
  		</Td>
  	</Tr>
  </Table>
  <br>
  <center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>


<%
}
%>
</form>

</body>
</html>