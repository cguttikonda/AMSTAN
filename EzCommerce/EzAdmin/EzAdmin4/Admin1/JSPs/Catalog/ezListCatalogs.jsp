<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Catalog/iListCatalogs.jsp"%>

<html>
<head>

<Title>EzCommerce.....The Next Generation eBusiness Solutions</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/Catalog/ezListCatalogs.js" >
</script>

<Script src="../../Library/JavaScript/ezTabScroll.js"></script>

</head>
<body bgcolor="#FFFFF7" onLoad='scrollInit()' onresize='scrollInit()' scroll="no">
<br>
 <%
	int catRows = retcat.getRowCount();
	String catalogName = null;
	if ( catRows > 0 )
	{
%>
		<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
  		<Tr align="center">
    		<Td class="displayheader">
<%
		if(pChange.equals("Y"))
		{
%>
			Select a Catalog to Change
<%
		}else{
%>
			List of Catalogs
<%
		}
%>
		</Td>
  		</Tr>
		</Table>
		<div id="theads">
		<Table id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
  		<Tr align="left">
      			<Th width="21%" align = "center"> Catalog </Th>
      			<Th width="79%" align = "center">Description </Th>
     		</Tr>
 		</Table>
 		</div>

<DIV id="InnerBox1Div">
		<Table id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >

 <%
 		retcat.sort(new String[]{CATALOG_DESC},true);
		for ( int i = 0 ; i < catRows; i++ )
		{

			String catNum = retcat.getFieldValue(i,CATALOG_DESC_NUMBER).toString();
			catalogName = (String)retcat.getFieldValue(i,CATALOG_DESC);

			catalogName = catalogName.replace('\u0020','+');

%>
  			<Tr align="left">
    			<Td width="21%">
<%
			if(pChange.equals("Y"))
			{
%>
			  <a style="text-decoration:none" href = "ezSelChangeCatalog.jsp?catNum=<%=catNum%>" >
<%
			}else{
%>
				<a style="text-decoration:none" href = "ezShowCatalog.jsp?CatNumber=<%=catNum%>&catDesc=<%=catalogName%>" >
<%
			}
%>
			<%=catNum%>
	              	</a>
    			</Td>
    			<Td width="79%">
<%
			if(catalogName != null)
			{
%>
                       <%= catalogName.replace('+','\u0020')%>
<%
			}

%>
                      </Td>
               		</Tr>
<%
		}//for close
%>


 		</Table>
 		</div>
		<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">		

		<a href="ezAddCatalogNumber.jsp"><img src="../../Images/Buttons/<%= ButtonDir%>/add.gif" border=none></a>	
		 <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
			
                </div>

<%
	}//End If
	else
	{
%>
<br><br><br><br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  		<Tr align="center">
    		<Th>There are No Catalogs </Th>
  		</Tr>
		</Table>
		<center>
		 <br>
		 <a href="ezAddCatalogNumber.jsp"><img src="../../Images/Buttons/<%= ButtonDir%>/add.gif" border=none></a>	
		 <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
                </center>
<%
	}
%>

</body>
</html>
