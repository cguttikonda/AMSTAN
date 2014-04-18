<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/BusinessCatalog/iCatalogNextLevel.jsp"%>
<%@ include file="../../../Includes/JSPs/BusinessCatalog/iViewCart.jsp"%>

<html>
<head>
<title>ezCatalog</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
	<Script>
		  var tabHeadWidth=60
 	   	  var tabHeight="60%"
	</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
</head>
<body  onLoad="scrollInit();" onresize="scrollInit()" scroll=no>

<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
<tr>
    <td height="35" align=center class="displayheaderback" width="80%"><%=groupDesc%></td>
    <td height="35" class="displayheaderback" align=right  width="20%">Shopping Cart Items:<%=Cart.getRowCount()%></td>
</tr>
</table>

	<Div id="theads">
	<table id="tabHead"  width="60%"  align="center">
		<tr align="center"> 
			<td class="displayheader">&nbsp;</td>
		</tr>
	</table><br>
	</Div>
 	<DIV id="InnerBox1Div">
	<table id="InnerBox1Tab" width="100%"  align=center style="overflow:auto;position:absolute;width:63%;height:60%;left:20%">
	
	<%
	// Display the Product Groups out.println(CatalogDescription);
	
	int MaxLength = 18 ; // ***** For SAP (Can be different for other ERP's)
	String GroupNumber = null;   
	String Level = null;  
	for ( int i = 0 ; i < retCount; i++ ) 
	{
		GroupNumber = ret.getFieldValueString(i,PROD_GROUP_NUMBER); 
	     	if(ret.getFieldValue(i,PROD_GROUP_LEVEL) != null)
			Level = ret.getFieldValueString(i,PROD_GROUP_LEVEL);
		if(Level.charAt(0) == pcLevel ){ // Check for the Group Level
		if (i%3==0)
		{
%>		
			<tr>
<%				
		}

%> 
		
		<td class="blankcell">
<%
		String webDescUrl = ret.getFieldValueString(i,PROD_GROUP_WEB_DESC);
		if (webDescUrl.indexOf(" ") > 0)
		{
			java.util.StringTokenizer strtok = new java.util.StringTokenizer(webDescUrl," ");
			webDescUrl = "";
			while(strtok.hasMoreTokens())
			{
					webDescUrl = webDescUrl + strtok.nextToken() + "%20";
			}
		}	
		if (!((ret.getFieldValue(i,PROD_GROUP_TERMINAL_FLAG))).equals("Y"))
		{
%>
			
			<br><A HREF ="ezCatalogNextLevel.jsp?CatalogDescription=<%=CatalogDescription%>&ProductGroup=<%=GroupNumber%>&GroupLevel=<%=Level%>&GroupDesc=<%=webDescUrl%>" <%=statusbar%>> 
			<%=ret.getFieldValue(i,PROD_GROUP_WEB_DESC)%></A>
			
<%
		}else {  // Last Level Route it to the FinalLevel JSP  
			  // Display List of Products
%>
			<br><A HREF ="ezCatalogFinalLevel.jsp?CatalogDescription=<%=CatalogDescription%>&ProductGroup=<%=GroupNumber%>&GroupDesc=<%=webDescUrl%>" <%=statusbar%>> 
			<%=ret.getFieldValue(i,PROD_GROUP_WEB_DESC)%></A>
<%
		}  //End if Last Level
%> 
		</td>
		<%--
		<td class="blankcell">
	      		<a href="ezAddCustomCatalog.jsp?CatalogDescription=<%=CatalogDescription%>&ProductGroup=<%=GroupNumber%>&GroupLevel=<%=Level%>" onMouseover="window.status='Click to add to Favourites'; return true" onMouseout="window.status=' '; return true"> 
	      		<img src="../../Images/Icons/addtofav.gif" border="0">
	      		</a>
		</td>
		--%>
<%
		if ((i!=0)&&(i/3.0==0))
		{
%>		
		</tr>
<%
		}
		}//End if Same Level
	}//End For
%> 
 </Table>
</Div>
			

<div align=center id="buttonDiv" style="position:absolute;top:90%;width:100%">
<%
		
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Back");
		buttonMethod.add("history.go(-1)");
		out.println(getButtonStr(buttonName,buttonMethod));
%>
</div>
<Div id="MenuSol"></Div>
</body>
</html>

