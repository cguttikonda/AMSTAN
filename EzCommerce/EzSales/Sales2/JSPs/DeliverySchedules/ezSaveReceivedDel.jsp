
<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%
	String recdate=request.getParameter("recDate");
	String sono=request.getParameter("SoNum");
	String delno=request.getParameter("DelNum");
	
	
	//delno	= "0080000314";
	//sono	= "0000000417";
	
	int count=Integer.parseInt(request.getParameter("TotCount"));
	
%>
<%@ include file="../../../Includes/JSPs/DeliverySchedule/iSaveReceivedDel.jsp"%> 
     