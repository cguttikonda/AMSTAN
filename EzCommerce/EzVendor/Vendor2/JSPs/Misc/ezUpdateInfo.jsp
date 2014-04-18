<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ include file="../../../Includes/JSPs/Misc/iUpdateInfo.jsp"%>

<html>
<head>

<title>Update Paying and Orderping Info</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
</head>
<body bgcolor="#FFFFF7">
<div align="center">
<TABLE width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
    <tr align="center"> 
         <td class="displayheader">Requested Address Update Information</td>
    </tr>
  </table>
  <br>
  <font face="Verdana" size="4" color="#006666"><u> </u></font> 
<TABLE width="90%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
    <tr align="center"> 
         <td width="92%" valign="top" class="blankcell" colspan="2" height="22">&nbsp;</td>
    </tr>
    <tr> 
      <td width="46%" valign="top" class="blankcell"> 
        <table width="75%" border="0" align="center">
		  <%
		  	if (payToCustNum!=null || !payToCustNum.equalsIgnoreCase("null")) {
		  	%>
          <tr > 
                  <th> Pay To Address </th>
          </tr>
          <tr> 
            <td> <%=companyName%> </td>
          </tr>
          <tr> 
            <td> <%=payAddr1%> </td>
          </tr>
			 <%
				 if (payAddr2!=null && payAddr2.trim().length()>0) {
				 %>
			 <tr>
				<td> <%=payAddr2%> </td>
			 </tr>
			 <%
			 	} //if payAddr2
			 %>
          <tr> 
            <td><%=payCity%></td>
          </tr>
          <tr> 
            <td> <%=payState+" "+payZip%> </td>
          </tr>
          <tr> 
            <td> <%=payCountry%> </td>
          </tr>

			 	<%
				} else { // payToCustNum is null
			 %>
			 <tr>
			 	<td>No Pay To Address</td>
			 </tr>
			 <%
			 	} // end if payToCust is null
			 %>
        </table>
      </td>
      <td width="46%" valign="top" class="blankcell"> 
	<TABLE width="75%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
          <tr > 
                  <th> Order To Address</th>
          </tr>
			 <%
			 	if (!isShpToPayTo){
			 		if (shpTocustNum.trim().length()>0){
			 %>
          <tr> 
            <td> <%=shpCompanyName%> </td>
          </tr>
          <tr> 
            <td> <%=orderAddr1%> </td>
          </tr>
<%
String addr2a = orderAddr2;
if ( addr2a != null && !addr2a.trim().equalsIgnoreCase("null") && addr2a.trim().length()!=0){
%>
          <tr> 
            <td><%=addr2a%></td>
          </tr>
<%
}//end if
%>		  
          <tr> 
            <td> <%=orderCity%> </td>
          </tr>
          <tr> 
            <td> <%=orderState+" "+orderZip%> </td>
          </tr>
          <tr>
            <td><%=orderCountry%></td>
          </tr>
			 <%
			 } else { // no Orderto
			 %>
			 <tr>
			 	<td>
					No order to address available
				</td>
			 </tr>
			 <%
				 	} // end if no order to
				} else { // shpTo is pay to
			 %>
			 <tr>
			 	<td>
					same as pay to.
				</td>
			 </tr>
			 <%
			 	} //end if shp to is pay to
			 %>
        </table>
      </td>
    </tr>
  </table>
</div>
<Div id="MenuSol"></Div>
</body>
</html>
