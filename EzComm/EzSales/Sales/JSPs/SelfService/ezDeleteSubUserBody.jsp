<%@ page import = "ezc.ezparam.*,ezc.ezmisc.params.*" %>
<jsp:useBean id="MiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"></jsp:useBean>
<%
	String values[] = request.getParameter("BusinessUser").split("¥");
	
	String userId = values[0];
	boolean check = true;
	
	if(userId!=null && !"null".equals(userId) && !"".equals(userId))
	{
		userId = userId.trim();
		
		EziMiscParams subUserParams = new EziMiscParams();
		EzcParams miscMainParams = new EzcParams(true);

		subUserParams.setIdenKey("MISC_DELETE");
		subUserParams.setQuery("DELETE FROM EZC_USERS WHERE EU_ID='"+userId+"'");
		miscMainParams.setObject(subUserParams);
		miscMainParams.setLocalStore("Y");

		Session.prepareParams(miscMainParams);
		
		try
		{
			MiscManager.ezDelete(miscMainParams);
		}
		catch(Exception e)
		{
			check = false;
		}
		
		if(check)
		{
			subUserParams.setIdenKey("MISC_DELETE");
			subUserParams.setQuery("DELETE FROM EZC_USER_DEFAULTS WHERE EUD_USER_ID='"+userId+"'");

			try
			{
				MiscManager.ezDelete(miscMainParams);
			}
			catch(Exception e)
			{
				check = false;
			}

			if(check)
			{
				subUserParams.setIdenKey("MISC_DELETE");
				subUserParams.setQuery("DELETE FROM EZC_USER_AUTH WHERE EUA_USER_ID='"+userId+"'");
				try
				{
					MiscManager.ezDelete(miscMainParams);
				}
				catch(Exception e)
				{
					check = false;
				}
			}
			if(check)
			{
				subUserParams.setIdenKey("MISC_DELETE");
				subUserParams.setQuery("DELETE FROM EZC_ERP_CUSTOMER_DEFAULTS WHERE  EECD_USER_ID='"+userId+"'");
				MiscManager.ezDelete(miscMainParams);
			}			
		}
	}
	
	//response.sendRedirect("../SelfService/ezListSubUsers.jsp");
%>

<html>
<head>
<Title>Add User</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>
	function navigateBack(obj)
	{
		document.myForm.action="../SelfService/ezListSubUsers.jsp";
		document.myForm.submit();
	}
</script>
</head>
<body onContextMenu="return false"> 
<form name="myForm">
<div class="main-container col2-layout middle account-pages">
<div class="main">
<div class="col-main1">
<%
	String noDataStatement_SU ="";
	if(check)
		noDataStatement_SU = "User deleted successfully";
	else
		noDataStatement_SU = "Error While deleting User";

%>

	<div class="page-title">
			<h1> <%=noDataStatement_SU%></h1>
	</div>	

	<br>
	<div >
		
		<input type="button" value="Ok" title="Save" onClick="navigateBack()" />
	</div>	
</form>
</body>
</div>
</div>
</div>
</html>