<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>Welcome To AF Web Store</title>
</head> 
<frameset rows="55,*,3%" cols="*" border="0" framespacing="0"  marginheight=0 margintop=0> 
  <frame src="ezAFBanner.jsp?callPreWelcomePage=Y" scrolling="NO" name="banner" frameborder="NO" marginwidth="0"  marginheight=0 margintop=0>
  <Frameset rows="30,*" cols="*"  border=no scrolling=no  framespacing="0"  marginheight=0 margintop=0 noresize>
 	<frame src="ezAFSalesCUMenu.jsp" scrolling="no" name="menu" frameborder="NO" marginwidth="0"  marginheight=0 margintop=0>
 	<Frame src="../DrillDownCatalog/ezDrillDownVendorCatalog.jsp" scrolling="auto" name="display" frameborder="NO" marginwidth="0"  border=no marginheight=0 margintop=0 noresize>
 </Frameset> 
  <frame src="ezFooter.jsp" name="footer" marginwidth="0"  marginheight=0 margintop=0 scrolling="NO" frameborder="NO">	
</frameset>
<noframes> 
<body bgcolor="#FFFFFF"> 
</body>
</noframes> 
<Div id="MenuSol"></Div>
</html>