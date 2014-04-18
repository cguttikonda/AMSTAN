

<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>

<%@ include file="../../../Includes/JSPs/SelfService/iUpdateInfo.jsp"%>
<%@ include file="../../../Includes/JSPs/Inbox/iSendMail.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iAcCopy_Lables.jsp"%>
<html>
<head>
<title>Update Billing and Shipping Info</title>
<%
Enumeration keys=null;
ResourceBundle crb=null;
crb=ResourceBundle.getBundle("COUNTRIES");
keys = crb.getKeys();
%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<script>
	function gotoHome()
	{
		document.location.href="../Misc/ezWelcome.jsp";
	}
</script>
</head>
<body scroll=no>
<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
<tr>
    <td height="35" class="displayheaderback" align=center width="100%"><%=reqaddrinfo_L%></td>
</tr>
</table>
<DIV id="tabHead" style="overflow:auto;width:100%;height:60%;">
         <table width="50%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
          <tr align="left">
	<th align="left"><%=comp_L%></th>
            <td>&nbsp; <%=companyName%> </td>
          </tr>
          <tr align="left">
	<Th><%=addr_L%></Th>
            <td>&nbsp; <%=billAddr1%> </td>
	<tr>

          </tr>
			 <%
				 if (billAddr2!=null && billAddr2.trim().length()>0) {
				 %>
			 <tr>
				<Th>&nbsp;</Th>
				<td>&nbsp; <%=billAddr2%> </td>
			 </tr>
			 <%
			 	} //if billAddr2
			 %>
          <tr align="left">
	<Th><%=city_L%></Th>
            <td>&nbsp;&nbsp;<%=billCity%></td>
          </tr>
          <tr align="left">
	<Th><%=zip_L%></Th>
            <td>&nbsp; <%=billZip%> </td>
          </tr>
   <tr align="left">
	<Th><%=state_L%></Th>
            <td>&nbsp; <%=billState%> </td>
          </tr>

          <tr align="left">
	<Th><%=coun_L%></Th>

        	<td width="60%">
		
		        <%while(keys.hasMoreElements()){
				String countryKey=(String)keys.nextElement();
				if(billCountry.equals(countryKey.trim())){
			  %>
				 &nbsp;&nbsp;<%=crb.getString(countryKey)%>&nbsp;
                                                           
			  <%}}%>
                </td>

            
          </tr>
 <tr>
            <th  width="40%" align="left">Phone</th>
            <td width="60%">&nbsp;
              <%=phone%>
            </td>
          </tr>
  <tr align="left">
	<Th>Ship To Address1</Th>
            <td>&nbsp; <%= shipAddr1 %>&nbsp; </td>
          </tr>
  <tr align="left">
	<Th>Ship To Address2</Th>
            <td>&nbsp; <%= shipAddr2 %>&nbsp; </td>
          </tr>
  <tr align="left">
	<Th>Web Address</Th>
            <td>&nbsp; <%= webAddr %> &nbsp;</td>
          </tr>
        </table>
</div>
<br>
 <DIV id="buttonDiv" style="width:100%;" align=center>
<%	
 	 	buttonName = new java.util.ArrayList();
 	 	buttonMethod = new java.util.ArrayList();
 	 	buttonName.add("Ok");
 	 	buttonMethod.add("gotoHome()");
 	 	out.println(getButtonStr(buttonName,buttonMethod));
%>
</div>
<Div id="MenuSol"></Div>
</body>
</html>

