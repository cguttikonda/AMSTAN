
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iUserEzcAuthListBySysKey.jsp"%>
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
	String[] sortArrEzc = {"EUAD_AUTH_DESC"};
	retauth.sort( sortArrEzc, true );

	retuserauth = (ReturnObjFromRetrieve)UserManager.getUserMasterAuth(uparams);
	retuserauth.check();
%>
<html>
<head>
	<script src="../../Library/JavaScript/User/ezUserEzcAuthListBySysKey.js">
	</script>

	<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
	<Title>Business User Authorizations</Title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
	<body onLoad='scrollInit()' onResize = "scrollInit()" scroll="no">
	<form name=myForm method=post action="ezSaveUserEzcAuthListBySysKey.jsp">
	<br>

	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
	<Tr align="center">
	<Td class="displayheader">User Authorizations</Td>
	</Tr>
	</Table>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
	<Tr>
	<Th >
		<div align="right"><%=areaLabel.substring(0,areaLabel.length()-1)%>:</div>
	</Th>
	<Td >
<%
			String wsk=null;
			for(int i=0;i<ret.getRowCount();i++)
			{
				if(websyskey.equals(ret.getFieldValue(i,SYSTEM_KEY)))
				{

					wsk=ret.getFieldValueString(i,SYSTEM_KEY_DESCRIPTION);

				}
			}
%>
<a href= "../Config/ezSetBusAreaDefaults.jsp?Area=<%=areaFlag%>&SystemKey=<%=websyskey%>"><%= wsk %> (<%=websyskey%>)&nbsp;</a>
		</Td>
	<Th >
		<div align="right">User:</div>
	</Th>
		<Td >
		<%
						if("2".equals((String)session.getValue("myUserType")))
						{
		%>
							<a href="../User/ezViewIntranetUserData.jsp?UserID=<%=bus_user%>"><%=bus_user%></a>
		<%
						}
						else
						{
		%>
							<a href="../User/ezUserDetails.jsp?UserID=<%=bus_user%>"><%=bus_user%></a>
		<%
						}
%>
		</Td>
	</Tr>
	</Table>

	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
	<Tr>
	<Th width="100%" colspan="2" >The following authorizations are independent
		of system.
		<!--
		For a list of system dependent authorizations
			<a class=subclass href="ezUserAuthListBySysKey.jsp?BusUser=<%=bus_user%>&Area=<%=areaFlag%>&WebSysKey=<%=websyskey%>" >

		<b>Click Here</b>
		-->
		</Th>
	</Tr>
	</Table>
	<div id="theads">
	<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0">
	<Tr align="left">

		<Th width="5%" align="center" title="Select/Deselect All"><input type='checkbox' name='chk1Main' onClick="selectAll()"></Th>
		<Th width="95%" align="center">List of System Independent Authorizations</Th>
	</Tr>
	</Table>
	</div>

	<DIV id="InnerBox1Div">

	<Table id="InnerBox1Tab" border=0 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>

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
	if ( sysRows > 0 )
	{
		for ( int i = 0 ; i < sysRows; i++ )
		{
%>
			<Tr>

      			<Td bgcolor="#CCCCCC" align="left">
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="100%">

<%
	if ( authRows > 0 )
	{
		showFlag = true;
		for ( int j = 0 ; j < authRows ; j++ )
		{
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
			<label for="cb_<%=j%>">
			<Td align="center" width="5%">
<%
			if (retuserauth != null  && retuserauth.find(USERAUTH_KEY, retauth.getFieldValue(j,BP_AUTH_KEY)))
			{
%>
				<input type="checkbox" name="Check" id="cb_<%=j%>" value="<%=retauth.getFieldValueString(j,BP_AUTH_KEY)%>#<%=retauth.getFieldValueString(j,AUTH_DESCRIPTION)%>#<%=roleIndicator%>" checked >
				<input type=hidden name=Stat value="<%=retauth.getFieldValueString(j,BP_AUTH_KEY)%>#<%=retauth.getFieldValueString(j,AUTH_DESCRIPTION)%>#<%=roleIndicator%>">
<%
			} else{
%>
				<input type="checkbox" name="Check" id="cb_<%=j%>" value="<%=retauth.getFieldValueString(j,BP_AUTH_KEY)%>#<%=retauth.getFieldValueString(j,AUTH_DESCRIPTION)%>#<%=roleIndicator%>" >
<%
			}
%>
			</Td>

			<Td width = "95%" align = "left">
				<%=(retauth.getFieldValue(j,AUTH_DESCRIPTION))%>
        		</Td>
        		<input type=hidden name=allKeys value="<%=retauth.getFieldValueString(j,BP_AUTH_KEY)%>" >
			</label>
			</Tr>

<%
			}

%>

		 </Table>
<%
}
else
{
%>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
	<Tr>
		<Td class = "labelcell">
			<div align="center"><b>No Authorizations to list .</b></div>

		</Td>
	</Tr>
</Table>
<%
}
%>

	<input type="hidden" name="BusUser" value=<%=bus_user%> >
<%
	}//End for
}//End If
%>
  </Table></div>
<%
	if ( showFlag )
	{
%>
<div id="ButtonDiv" align="center" style="position:absolute;;visibility:visible;top:90%;width:100%">

      <input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/save.gif" name="Submit" value="Update">

      <a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
      <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

</div>
        <input type="hidden" name="FromAdd" value="<%= FromAdd %>">
  <% } else { %>
  	<div align="center">
  	<br><br>
  	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
		<Tr>
			<Td class = "labelcell" align="center">
				<b>No Authorizations available.</b>
			</Td>
		</Tr>
</Table>
<center><br>
	  	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

	  </center>
</div>
  <% } %>
  <input type="hidden" name="Area" value="<%=areaFlag%>">
  <input type="hidden" name="WebSysKey" value="<%=websyskey%>" >
  <input type="hidden" name="BusUser" value="<%=bus_user%>" >
</form>
<%
	String saved = request.getParameter("saved");
	if ( saved != null && saved.equals("Y") )
	{
%>
		<script language="JavaScript">
			alert('System Independent Authorization(s) updated successfully');
			history.go(-2);
		</script>
<%
	} //end if
%>

</body>
</html>
