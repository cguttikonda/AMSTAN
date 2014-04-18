<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iLoginBanner_Lables.jsp"%>
<%@ page import="java.util.*,java.text.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />

<%
 	String username		=Session.getUserId();
	String userRole		=(String)session.getValue("UserRole");
 %>
 

<HTML>
<HEAD>

<title>Welcome To Continental Resources Web Portal</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<Script>
	function callFun(clickedOn)
	{
		if(clickedOn=='C')
		{
			top.display.location.href = "../ShoppingCart/ezViewCart.jsp";
		}	
		else if(clickedOn=='L')
		{
			top.location.href='../Misc/ezCUsrLogout.jsp'
		} 
	}
	
</Script>
<Style>
	a{
	   color: #30366A;
	   text-decoration:none;
	}
	
	a:link{
	   color: #30366A;
	   text-decoration:none;
	}
	
	a:hover{
	   color: #30366A;
	   text-decoration:underline;
	   font-weight:normal
	}
	
	a:visited{
	   color: #30366A;
	}
</Style>	
</HEAD>

<Body leftMargin=0 topMargin=0 bgcolor='#FFFFFF' MARGINWIDTH="0" MARGINHEIGHT="0">
<Form name="myForm" method="POST">
<TABLE cellSpacing=0 cellPadding=0 width="100%" align=center border=0  class='blankcell'>
<TR>
<TD width=100% valign=top bgcolor="#FFFFFF">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" align=center border=0 class='blankcell'>
	
	<TR class='blankcell'>
		<Td width='10%' class='blankcell' > 
			<IMG src="../../../../EzCommon/Images/Banner/continental_resources_logo.png" border=0>
		</Td> 
		<TD width='50%' valign='center' align='right' class='blankcell' wrap>
			<Font color='#333333' size='1px'  face="Verdana" > <b> Welcome <%=username%>&nbsp;&nbsp;</Font></b><a title="Click here to log out" href="javascript:callFun('L')" style="cursor:hand;text-decoration: none" ><Font color='red' size='1px'  face="Verdana" ><b>( Log Out )</b></Font></a>
		</TD>
		<TD width='40%' valign='center' align='right' class='blankcell' wrap>
			&nbsp;
		</TD>

	</TR>
	</TABLE>
</TD>

</TR>
</Table>
</BODY>

</HTML>