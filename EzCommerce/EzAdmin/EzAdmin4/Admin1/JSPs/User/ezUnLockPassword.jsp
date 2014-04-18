<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import= "java.sql.*" %>
<html>
<head>
 <%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script>
	function gotoHome()
	{
		document.myForm.action="../Config/ezListSystems.jsp";
		document.myForm.submit();
	}
</script>
</head>
<%@ page import = "ezc.ezparam.*" %>

<%
	String userId = request.getParameter("userid");
	String PwdFlg = request.getParameter("PwdFlg");
	String statusMsg = "";
	boolean userExist = false;
	boolean allowLk = true;
	boolean allowUnLk = true;
	boolean executeStmt = false;
	boolean alowUl = true;

	Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
	Connection connection = DriverManager.getConnection("jdbc:microsoft:sqlserver://localhost:1433;DatabaseName=ezranbaxypartners;SelectMethod=cursor","ezranbaxypartner","test");
	//PreparedStatement st = connection.prepareStatement("update EZC_WEB_STATS set EWS_SOLD_TO = '0' where EWS_USER_ID = ? and EWS_SYSKEY = 'LOGINFAIL'");	
	
	
	ResultSet rs = null;
	PreparedStatement stmt = connection.prepareStatement("select * from EZC_WEB_STATS where EWS_USER_ID = ? order by EWS_LOGGED_OUT desc");
	stmt.setString(1,userId);
	rs = stmt.executeQuery();
	if(rs.next())
	{
		userExist = true;
		String skey = rs.getString("EWS_SYSKEY");
		
		
		if("LOCKED".equals(skey) && "L".equals(PwdFlg.trim()))
		{
			allowLk = false;	
			
		}
		else if("UNLOCKED".equals(skey) && "U".equals(PwdFlg.trim()))
		{
			allowUnLk = false;	
			
		}
		else
		if(!("LOCKED".equals(skey) || "UNLOCKED".equals(skey)) && "U".equals(PwdFlg.trim()))
		{
			alowUl = false;	
			
		}
	}
	
	if(userExist)
	{
	
		PreparedStatement st = null;
		if(allowUnLk)
		{
			
			if("U".equals(PwdFlg.trim()) && alowUl)
			{
				st = connection.prepareStatement("insert into EZC_WEB_STATS(EWS_USER_ID,EWS_SYSKEY,EWS_IP,EWS_LOGGED_IN,EWS_LOGGED_OUT) VALUES(?,'UNLOCKED',?,getdate(),getdate())");	
				executeStmt = true;
				statusMsg = "Password of "+userId+"  is Unlocked successfully.";
			}
			else
			{
				statusMsg = "Password of "+userId+" has not been locked.";
			}
		}
		else
		if("U".equals(PwdFlg.trim()))
		{
			statusMsg = "Password of "+userId+" is already Unlocked.";
		}
			
		if(allowLk)
		{	
			if("L".equals(PwdFlg.trim()))
			{
				st = connection.prepareStatement("insert into EZC_WEB_STATS(EWS_USER_ID,EWS_SYSKEY,EWS_IP,EWS_LOGGED_IN,EWS_LOGGED_OUT) VALUES(?,'LOCKED',?,getdate(),getdate())");	
				executeStmt = true;				
				statusMsg = "Password of "+userId+"  is Locked successfully.";
			}
		}
		else
		if("L".equals(PwdFlg.trim()))
		{
			statusMsg = "Password of "+userId+" is already Locked.";
		}
		
		if(executeStmt)
		{
			st.setString(1,userId);
			st.setString(2,request.getRemoteAddr());
			st.executeUpdate();
			st.close();
			
		}
		connection.close();
	}	

%>
<body>
<form name="myForm">
<br><br><br>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
<Tr>
	<Th width="100%" align=center>
<%
	if(userExist)
	{
%>	
		<%=statusMsg%> 
<%
	}
	else
	{
%>
		No user found  with this User Id <%=userId%>.
<%
	}
%>
	</Th>
</Tr>
</Table><br><center>

<br><br>
<Table align="center">
<Tr><Td align=center class="blankcell">
<a href="JavaScript:gotoHome()" style="text-decoration:none"><img src="../../Images/Buttons/<%= ButtonDir%>/ok.gif" border="none" title="Click here to continue"  alt="Click here to continue"  ></a>
</Td></Tr></Table>
</form>
</body>
</html>
