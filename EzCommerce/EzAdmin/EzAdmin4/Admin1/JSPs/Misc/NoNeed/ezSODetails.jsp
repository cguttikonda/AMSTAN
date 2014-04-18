<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/SalesOrder/isoDetails.jsp"%>


<html>
<head>
<Title>SO Details</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body bgcolor="#FFFFF7">
<%

if (statinfo != null && statRow != null) {
%>
<Table  width="50%" border="0" align="center">
  <Tr align="center"> 
    <Td class="displayheader"> Sales Order Details </Td>
  </Tr>
</Table>
<br>
<form name="myForm" method="post">
  <br>
  <div align="center"> 
    <Table  width="85%" align="center" bgcolor="#FFFFF7" bordercolor="#660066" border="3">
      <Tr> 
        <Td width="22%" height="26" bordercolor="#FFFFF7" >Order Number: </Td>
        <Td width="29%" height="26" bordercolor="#FFFFF7" >
          <%=statRow.getDocNumber()%></Td>
        <Td width="25%" height="26" bordercolor="#FFFFF7">Order Date:</Td>
        <Td width="24%" height="26" bordercolor="#FFFFF7">
          <%=formatDate.getCorrectedStringFromDate( getConvertedDate(statRow.getDocDate())) %> 
         </Td>
      </Tr>
      <Tr bordercolor="#FFFFF7"> 
        <Td width="22%" height="28">PO Number:</Td>
        <Td width="29%" height="28" bordercolor="#FFFFF7" >
          <%=statRow.getPurchNo()%></Td>
      </Tr>
    </Table>
  </div>
  <div align="center"></div>
  <br>
  <Table  width="95%" border="0" align="center">
    <Tr align="center"> 
      <Th width="4%" height="21">Line</Th>
      <Th width="11%" height="21">Material # </Th>
      <Th width="28%" height="21">Description</Th>
      <Th width="7%" height="21">Order Qty</Th>
      <Th width="11%" height="21">Planned Date</Th>
      <Th width="9%" height="21">Delivery Qty</Th>
      <Th width="11%" height="21">Delivery Date</Th>
      <Th width="7%" height="21">Total Value </Th>
      <Th width="12%" height="21">Delivery # </Th>
    </Tr>
    <% 
int i = 0;
int count = statinfo.getRowCount();
while (i++ < count ) {
	statRow = statinfo.getRow((i-1));
%> 
    <Tr align="center"> 
      <Td width="4%"><%
	out.println(statRow.getItmNumber());
%></Td>
      <Td width="11%"><%
	out.println(statRow.getMaterial());
%></Td>
      <Td width="28%"><%
	out.println(statRow.getShortText());
%></Td>
      <Td width="7%"><%
	out.println(statRow.getReqQty());
%></Td>
      <Td width="11%"><%
	out.println(formatDate.getCorrectedStringFromDate(getConvertedDate(statRow.getReqDate())));
%></Td>
      <Td width="9%"><%
	out.println(statRow.getDlvQty());
%></Td>
      <Td width="11%"><%
	out.println(JSPformatDate( statRow.getDelivDate(), formatDate ) );
%></Td>
      <Td width="7%"><%
	out.println(statRow.getNetValue());
%></Td>
      <Td align="center" width="12%"><a href = ezShipTrack.jsp target = "_blank"> 
       <%
	//out.println(statRow.getDelivNumb());
       //here change was made to get the track number instead of delivery number
        out.println("1ZE4W5110241765649");
%></a></Td>
    </Tr>
    <%
} // end of while
%> 
  </Table>
</form>
<%
}//end if statinfo
%>
</body>
</html>

