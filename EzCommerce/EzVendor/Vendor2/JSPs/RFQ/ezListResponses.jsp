<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<% 
	String value = request.getParameter("chk1");  

	java.util.StringTokenizer st = new java.util.StringTokenizer(value,"#");

        String num = st.nextToken();
	String date = st.nextToken();


%>

<html>
<head>
<title>List of Purchase Orders</title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
</head>
<body>
<form name="myForm" method="post">
<table width="60%" border="0" align="center">
  <tr align="center">
  <td class="displayheader">Response for RFQ : <%=num%></td>
  </tr>
</table>
<br>
<Table width="70%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
      <Tr> 
       <th align=center>&nbsp; </th>
       <th align=center>Vendor</th>
        <th align="center">Qtn. Ref. </th>
        <th align="center">Qtn. Date</th>
      </Tr>

      <Tr> 
	<Td align="center"><input type="radio" name=chk1 checked></Td>	  
        <Td>BLUESTAR</Td>
        <Td align="center"><%=num%></Td>
        <Td align="center"><%=date%></Td>
      </Tr>
    </Table><br><br>
<center>
<a href="ezViewQuoteDetails.jsp?PurchaseOrder=<%=num%>&OrderDate=<%=date%>"><img src="../../Images/Buttons/<%=ButtonDir%>/viewquotes.gif" style="cursor:hand" border=none></a>
<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand" border=none onClick="javascript:history.go(-1)">
</center>
</form>
</body>
</html>
