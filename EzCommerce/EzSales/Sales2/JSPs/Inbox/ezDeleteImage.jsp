<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@page import="java.io.*"%>
<%@ include file="../../../Includes/JSPs/Uploads/iImagePath.jsp"%>

<center>
		<Center><b>Deleting Image... Please wait</Center>
		<br>
		<img src="../../../../EzCommon/Images/Body/loading.gif">
</center>
<%
	
	String File = request.getParameter("file");
	File f = new File(imagePath+"\\"+File); 
	f.delete();
	
%>
	<script>
	window.close();
	</script>