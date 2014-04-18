<%
	ezc.ezcommon.EzLog4j.log("ezCatUserFrameset.jsp>> ValidSalesUser >>>>>>>>>>"+session.getValue("ValidSalesUser"),"I");
	ezc.ezcommon.EzLog4j.log("ezCatUserFrameset.jsp>>>>>>session>>>>"+session.isNew(),"I");
%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iLang_Lables.jsp"%>
<html>
<head>
<title>Welcome To Continental Resources Web Portal</title>
</head> 
<frameset rows="65,*,3%" cols="*" border="0" framespacing="0"  marginheight=0 margintop=0> 
  <frame src="../Misc/ezCatUserHeader.jsp" scrolling="NO" name="banner" frameborder="NO" marginwidth="0"  marginheight=0 margintop=0>
  <Frameset rows="36,*" cols="*"  border=no scrolling=no  framespacing="0"  marginheight=0 margintop=0 noresize>
 	<frame src="../Misc/ezHSalesCUMenu.jsp" scrolling="no" name="menu" frameborder="NO" marginwidth="0"  marginheight=0 margintop=0>
 	<Frame src="../DrillDownCatalog/ezDrillDownVendorCatalog.jsp" scrolling="auto" name="display" frameborder="NO" marginwidth="0"  border=no marginheight=0 margintop=0 noresize>
 </Frameset> 
  <frame src="../Misc/ezFooter.jsp" name="footer" marginwidth="0"  marginheight=0 margintop=0 scrolling="NO" frameborder="NO">	
</frameset>
<noframes> 
<body bgcolor="#FFFFFF"> 
</body>
</noframes> 
<Div id="MenuSol"></Div>
</html>