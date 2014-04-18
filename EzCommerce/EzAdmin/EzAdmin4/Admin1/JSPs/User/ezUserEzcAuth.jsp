<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iUserEzcAuthList.jsp"%>

<%
	String myUser = "Business User";
	if("2".equals((String)session.getValue("myUserType")))
		myUser = "Intranet User";
%>



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
%>
<html>
	<head>
		<script src="../../Library/JavaScript/User/ezUserEzcAuthList.js"></script>
		<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
		<Title>Business User Authorizations</Title>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
	<body onLoad='scrollInit()' onResize = "scrollInit()" scroll="no">
	<form name=myForm method=post action="ezSaveUserEzcAuthList.jsp?FromAdd=Yes">
		<br>

<Table border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">

	    <Tr>
	     <Th width="30%" align = "right"><%=myUser%>:</Th>
	      <Td width="57%" >
	      	<input type="hidden" readonly name="Bus_Partner" size="15" value=<%=bus_user%> >
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
	<div id="theads">
	<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 >
	    <Tr align="center">
		         <Th width="6%" align="center" title="Select/Deselect All"><input type='checkbox' name='chk1Main' onClick="selectAll()"></Th>
	         <Th width="70%" >User System Independent Authorizations</Th>

	    </Tr>
	</Table>
	</div>

	<div id="InnerBox1Div">
	<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 >


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
		if ( authRows > 0 )
		{
		%>


			<Tr>
      			<Td bgcolor="#CCCCCC" align="left">

<%
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

			</Td>
			</Tr>
			<Tr align="center" >
			<label for="cb_<%=j%>">
			<Td width="8%" align="center" bgcolor="#CCCCCC">
<%
			if (retuserauth != null  && retuserauth.find(USERAUTH_KEY, retauth.getFieldValue(j,BP_AUTH_KEY)))
			{
%>
	      			<input type="checkbox" name="Check" id="cb_<%=j%>" value="<%=(retauth.getFieldValue(j,BP_AUTH_KEY))%>#<%=(retauth.getFieldValue(j,AUTH_DESCRIPTION))%>#<%=roleIndicator%>" checked >
	      			<input type="hidden" name="Stat" value="Y" >
<%
			} else{
%>
	      			<input type="checkbox" name="Check" id="cb_<%=j%>" value="<%=(retauth.getFieldValue(j,BP_AUTH_KEY))%>#<%=(retauth.getFieldValue(j,AUTH_DESCRIPTION))%>#<%=roleIndicator%>">
<%
			}
%>
			</Td>
			<Td align="left">
	      		<%=(retauth.getFieldValue(j,AUTH_DESCRIPTION))%>
        		</A>
        		</Td>
			</label>
			</Tr>
<%
			}
%>
 			
<%
		}
%>
		

		  </Table>
		  </div>
		<input type="hidden" name="BusUser" value=<%=bus_user%> >
<%
		}
	}
%>

<%
	if ( showFlag )
	{
%>
	<div id="ButtonDiv" align="center" style="position:absolute;visibility:visible;top:90%;width:100%">
	      
	      <input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/save.gif" name="Submit" value="Update">	      
	      <a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
	      <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

	</div>
        <input type="hidden" name="FromAdd" value="<%= FromAdd %>">
  <% } else { %>
	<br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	  	<Tr>
	  		<Td class = "labelcell">
	  			<div align="center"><b>No Authorizations available</b></div>
	  		</Td>
	  	</Tr>
		</Table>
		<div id="buttons" style="position:absolute;top:90%;left:40%;visibility:visible">
			<input type="image" src = "../../Images/Buttons/<%=ButtonDir%>/continue.gif" name="Submit" value="Continue">
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

		</div>
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
