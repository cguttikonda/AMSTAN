<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Catalog/iPostSync.jsp"%>

<html>
<head>
	<Title>PostSync</Title>
	<meta http-equiv="Content-Type" content=" text/html; charset=iso-8859-1">
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<script src="../../Library/JavaScript/Catalog/ezPostSync.js" ></script>
	<Script src="../../Library/JavaScript/ezTabScroll.js"></script>

</head>
<body  onLoad='scrollInit()' onResize = "scrollInit()">
<br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="89%">
	<Tr align="center">
		<Td class="displayheader">Synchronized Products</Td>
	</Tr>
	</Table>

	<div id="theads">
	<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr>
		<Th width="85%" colspan="3"> List of Product Groups Synchronized Successfully</Th>
	</Tr>
	</Table>
	</div>

	<DIV id="InnerBox1Div">
	<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="100%">

<%
	ReturnObjFromRetrieve retobj = (ReturnObjFromRetrieve)ret.getObject("OffsetTable");

	//Total levels in the catalog
	int iTotalCells = retobj.getRowCount();
	if (ret!= null)
	{
		int Rows = ret.getRowCount();
		int level;
		String chkname=null;
		for ( int i = 0 ; i <  Rows; i++ )
		{
			level = ((java.math.BigDecimal)ret.getFieldValue(i,PROD_GROUP_LEVEL)).intValue();
%>
			<Tr bgcolor="#E1E1FF" >
<%
			for ( int j = 0 ; j < (level -1); j++ )
			{
				if (level != 1)
				{
%>
					<Td>&nbsp;</Td>
<%
				}
			}

			chkname = ret.getFieldValueString(i,PROD_GROUP_NUMBER);

%>
			<Td align="left">
        			<input type="checkbox" name="CheckBox" value=<%=chkname%> checked disabled>
				
				<%=(ret.getFieldValue(i,PROD_GROUP_WEB_DESC))%>
				</A>
			</Td>
<%
			for ( int k = 0 ; k < (iTotalCells - level)  ; k++ )
			{
%>
				<Td>&nbsp;</Td>
<%
			}
%>
			</Tr>
<%
		}//End for
%>

	</Table></div>

<%
	}//End if
%>
	<div id="ButtonDiv" align="center" style="position:absolute;visibility:visible;top:90%;width:100%">
	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
	</div>
	
</body>
</html>
