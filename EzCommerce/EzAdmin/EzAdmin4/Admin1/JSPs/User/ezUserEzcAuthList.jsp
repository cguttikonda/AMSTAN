
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>

<%@ include file="../../../Includes/JSPs/User/iUserEzcAuthList.jsp"%>
<%

String language = "EN";
bparams.createContainer();
bNKParams.setLanguage(language);
bparams.setObject(bNKParams);
bparams.setBussPartner(Bus_Partner);
Session.prepareParams(bparams);
retauth = (ReturnObjFromRetrieve) BPManager.getBussPartnerMasterAuth(bparams);
retauth.check();







		
int authRows = retauth.getRowCount();
String[] sortArrList = {"EUAD_AUTH_DESC"};
retauth.sort( sortArrList, true );
retuserauth = (ReturnObjFromRetrieve)UserManager.getUserMasterAuth(uparams);
retuserauth.check();
%>
<html>
<head>
<script src="../../Library/JavaScript/User/ezUserEzcAuthList.js">

</script>

<Script src="../../Library/JavaScript/ezTabScroll.js"></script>


<Title>Business User Authorizations</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body onLoad='scrollInit()' onResize = "scrollInit()" scroll="no">
<br>

<form name=myForm method=post action="ezSaveUserEzcAuthList.jsp">

  <Table  width="50%" border="1" align="center">
    <Tr>
      <Th width="43%" class="labelcell">
        <div align="right">User:</div>
      </Th>
      <Td width="57%">
      	<%=bus_user%>
      	<input type="hidden" readonly name="Bus_Partner" size="15" value = "<%=bus_user%>" >

	</Td>
    </Tr>
  </Table>
  <br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  <Tr align="center">
    <Td class="displayheader">User Authorizations</Td>
  </Tr>
</Table>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
    <Tr>
      <Th width="100%" colspan="2" >The following authorizations are independent
        of system. For a list of system dependent authorizations
		<a class="subclass" href="ezUserAuthList.jsp?BusUser=<%=bus_user%>" >

        <b>Click Here</b></Th>
    </Tr>
    </Table>


  <div id="theads">
<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
    <Tr align="left">
         <Th width="70%" >List of System Independent Authorizations</Th>
	 
    </Tr>
    
    </Table>
    </div>

    <DIV id="InnerBox1Div">

<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>

<%
	String userRolesYN = null;

	java.util.ResourceBundle res = java.util.ResourceBundle.getBundle("Site");

	try
	{
			userRolesYN = res.getString("Roles");


	}
	catch ( Exception e )
	{
			e.printStackTrace();
			userRolesYN = "N";

	}

	boolean showRoles = true;
	if ( userRolesYN != null && userRolesYN.trim().equals("N") )
	{
		showRoles = false;
	}
	else
	{
		showRoles = true;
	}


boolean showFlag = false;
int sysRows = 1;
if ( sysRows > 0 ) {
	for ( int i = 0 ; i < sysRows; i++ ){
%>
		<Tr>
      <Td bgcolor="#CCCCCC" align="left">
      	<Table >
 <%
if ( authRows > 0 ) {
	showFlag = true;
	int kCnt = 0;
	for ( int j = 0 ; j < authRows ; j++ ){
		String roleIndicator = "";
		if ( !retRoles.find("ROLE_NR",retauth.getFieldValueString(j,BP_AUTH_KEY)) )
		{
			roleIndicator = " ";
			if ( showRoles ) continue;
		}
		else
		{
			roleIndicator = "R";
			if ( !showRoles ) continue;
		}

%>

		<Tr align="center" >

		<Td align="center" bgcolor="#CCCCCC">
<%
		if (retuserauth != null  && retuserauth.find(USERAUTH_KEY, retauth.getFieldValue(j,BP_AUTH_KEY)))
		{
%>
	      	<input type="checkbox" name="Check" value="<%=retauth.getFieldValueString(j,BP_AUTH_KEY)%>#<%=retauth.getFieldValueString(j,AUTH_DESCRIPTION)%>#<%=roleIndicator%>" checked >
	      	<input type="hidden" name="Stat" value="<%=retauth.getFieldValueString(j,BP_AUTH_KEY)%>#<%=retauth.getFieldValueString(j,AUTH_DESCRIPTION)%>#<%=roleIndicator%>" >
<%
		} else{
%>
	      	<input type="checkbox" name="Check" value="<%=retauth.getFieldValueString(j,BP_AUTH_KEY)%>#<%=retauth.getFieldValueString(j,AUTH_DESCRIPTION)%>#<%=roleIndicator%>" unchecked >
<%
		}
%>
		</Td>
		<Td align="left">
	      <%=(retauth.getFieldValue(j,AUTH_DESCRIPTION))%>
        	</A>
        	</Td>

		<Td>
		<input type="hidden" name="AuthKey"  value=<%=(retauth.getFieldValue(j,BP_AUTH_KEY))%> >
		<input type="hidden" name="AuthDesc" value=<%=(retauth.getFieldValue(j,AUTH_DESCRIPTION))%> >
		<input type="hidden" name="RoleInd" value=<%=roleIndicator%> >
        </Td>
		</Tr>
<%
		kCnt++;
	}//End for

	// Row for hidden fields
%>
	<input type="hidden" name="AuthCount" value=<%=authRows%> >
 	</Table>
<%
 }//End If
%>
	<input type="hidden" name="TotalCount" value=<%=sysRows%> >
	<input type="hidden" name="BusUser" value=<%=bus_user%> >
<%
	}//End for
}//End If
%>
  </Table></div>
<div id="ButtonDiv" align = "center" style="position:absolute;visibility:visible;top:90%;width:100%">
      <img src = "../../Images/Buttons/<%= ButtonDir%>/selectall.gif" style = "cursor:hand" name="Button" value="Select All" onClick=setChecked(1)>
      <input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/save.gif" name="Submit" value="Update">
      <image src = "../../Images/Buttons/<%= ButtonDir%>/clearall.gif" style = "cursor:hand" name="Reset" value="Clear All" onClick=setChecked(0)>

</div>
        <input type="hidden" name="FromAdd" value="<%= FromAdd %>">
  <% } else { %>
  	<div align="center">No Authorizations available</div>
  <% } %>
</form>
<%
	String saved = request.getParameter("saved");
	if ( saved != null && saved.equals("Y") )
	{
%>
		<script language="JavaScript">
			alert('System Independent Authorization(s) updated successfully');
		</script>
<%
	} //end if
%>

</body>
</html>
