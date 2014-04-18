<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iLoginBanner_Lables.jsp"%>
<%@ page import="java.util.*,java.text.*" %>


<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%
	
 	String username		=Session.getUserId();
 	String agent		=(String)session.getValue("Agent");
 	String ctry		=(String)session.getValue("Country");
	String userRole		=(String)session.getValue("UserRole");
 	String userRoleDesc	=null;
  	String SalesType	=(String)session.getValue("SalesType");
  	
 	if (SalesType==null) SalesType=" ";
 	
 	if("LF".equals(userRole))
 		userRoleDesc="Regional Manager"; 
 	else if("CM".equals(userRole))
 		userRoleDesc="Marketing Manager";
 	else if("CU".equals(userRole))
 		userRoleDesc="Stockist";
 	
 	String xmlTagName  = "Support";	
 %>	
 	<%@ include file="ezXMLDataRead.jsp"%>
 <%
 	String XMLsupportid=xmlTagValue;	
 %>
 

<HTML>
<HEAD>

<title><%= getLabel("BRW_TITLE") %></title>
<%@ include file="../../../Includes/Lib/ezAddBannerDir.jsp"%>
<Script>
	function callFun(clickedOn)
	{
		if(clickedOn=='H')
		{
			top.display.location.href = "ezWelcome.jsp";
		}	
		else if(clickedOn=='L')
		{
			top.location.href='../Misc/ezLogout.jsp'
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

<Body leftMargin=0 topMargin=0 MARGINWIDTH="0" MARGINHEIGHT="0">
<Form name="myForm" method="POST">
<input type=hidden name='changePurArea' value='N'>
<TABLE cellSpacing=0 cellPadding=0 width="100%" align=center border=0 >
<TR>
<TD width=15% valign=top bgcolor="#FFFFFF">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" align=center border=0>
	<TR >
		<TD>
			<IMG src="../../../../EzCommon/Images/Banner/aflogo.jpg" border=0>
		</TD>
	</TR>
	</TABLE>
</TD>
<TD valign=top bgcolor="#FFFFFF">
	<Table align=right  width="100%" height=100% border="0" cellspacing="0" cellpadding="5">
	<Tr>
		<Td colspan=2 valign=top align=right>
			<Font color='#000000' size=2  face="Tahoma">
				<span id='home_mail'>
					<a href="javascript:callFun('H')"><img src="../../../../EzCommon/Images/Banner/home.jpg" border=0>home</a>
					&nbsp;
					<a  href='../Inbox/ezListPersMsgs.jsp' target="display"><img src="../../../../EzCommon/Images/Banner/ic_mail.gif" border=no title='Check Mails' style="cursor:hand">mails</a>
					&nbsp;
				</span>
				<a  href='mailto:<%=XMLsupportid%>'><img src="../../../../EzCommon/Images/Banner/support.jpg" border=no title='Contact us thru Mail' style="cursor:hand">support</a>
				&nbsp;
				<a  href="javascript:callFun('L')"><img src="../../../../EzCommon/Images/Banner/exit.jpg" border=no title='Logout' style="cursor:hand">logout</a>
				&nbsp;
			</Font>
		</Td>	
	</Tr>
	<Tr>
		
		<td width="7%">
		<Td align=left valign=top align="center">
			<Font color='#30366A' size=2  face="Tahoma"> <b> Welcome <i><%=username%> [<%=agent%>]</i> to Customer Portal</b>
		</Td>
		
	</Tr>	
	</Table>
</TD>
</TR>
</Table>
</BODY>
<Script>
<%
	String WelcomePage = request.getParameter("callPreWelcomePage");
	if("Y".equals(WelcomePage))
	{
%>
		top.display.document.location.href="ezWelcome.jsp"
<%
	}
%>
</Script>
</HTML>