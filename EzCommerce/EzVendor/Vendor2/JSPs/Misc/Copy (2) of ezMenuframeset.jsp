<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<Html>
<Head>
<Title>Welcome To Kiss Products</Title>

</Head>
<Frameset rows="75,*,6%" cols="*" framespacing="0" frameborder="No" border=no scrolling="yes">
<Frame name="banner" src="ezLoginBanner.jsp?callPreWelcomePage=Y&INIT=FIRST" scrolling="No" border=no marginwidth="0" marginheight="0" noresize>
	<Frameset rows="20,*" cols="*"  border=no scrolling=no  framespacing="0"  marginheight=0 margintop=0 noresize>
<%
		String userType=(String)session.getValue("UserType");
		if("3".equals(userType))
		{
%>
			<Frame name="menu" src="../../JSPs/Misc/ezVendorMenu.jsp" scrolling="No" border=no marginwidth="0" marginheight="0" noresize>
<%
		}
		else
		{
%>
			<Frame name="menu" src="../../JSPs/Misc/ezVendorEnterpriseMenu.jsp" scrolling="No"  border=no marginwidth="0" marginheight="0" noresize>
<%
		}
%>
		<Frame src="../../Htmls/ezBlank.htm" scrolling="auto" name="display" frameborder="NO" marginwidth="0"  border=no marginheight=0 margintop=0 noresize>
	</Frameset>
<Frame  name="footer" src="ezFooter.jsp"  border=no scrolling=no noresize>
</Frameset>
</Html>