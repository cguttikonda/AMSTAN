<% System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Inside Error Path"); %>
<%@ page language="java" errorPage="../../JSPs/Misc/ezBannerErrorDisplay.jsp"%>
<%
	
	
	if(!"Y".equals((String)session.getValue("ValidVendorUser")))
	{
%>
		<script>
			top.banner.location.href='ezBlank.htm'
			top.menu.location.href='ezBlank.htm'
			top.display.location.href='../../../Vendor2/Library/Globals/ezValidVendorUserError.jsp'
		</script>
<%	
	}
%>