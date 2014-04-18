<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/BusinessCatalog/iCatalog.jsp"%>
<%@ include file="../../../Includes/JSPs/BusinessCatalog/iViewCart.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iCreate_Lables.jsp" %>
<html>
<head>
<title>ezCatalog</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<Script>
		  var tabHeadWidth=53
 	   	  var tabHeight="60%"
	</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<script>
	function funShow(aURL,aGroup,aDesc,aLevel)
	{
		document.myForm.action=aURL;
		document.myForm.ProductGroup.value=aGroup
		document.myForm.GroupDesc.value=aDesc
		document.myForm.GroupLevel.value=aLevel
		document.myForm.submit();
	}
	function selSoldTo()
	{
		document.location.replace("../Misc/ezWelcome.jsp");
	}
</script>
</head>

<body  onLoad="scrollInit()" onresize="scrollInit()" scroll=no>
<form name=myForm action="ezFavGroupFinalLevel.jsp">
<input type=hidden name=ProductGroup value="">
<input type=hidden name=GroupDesc value="">
<input type=hidden name=GroupLevel value="">
<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
<tr>
    <td height="35" class="displayheaderback" align=right width="50%">Browse Catalogs</td>
    <td height="35" class="displayheaderback" align=right width="50%">Shopping Cart Items:<%=Cart.getRowCount()%>&nbsp;&nbsp;&nbsp;</td>  

</tr>
</table>
<br><br><br>
<%
	int Rows = ret.getRowCount();
	if(Rows==0)
	{
		if ( syncFlag.equals("N") )
		{
%>
			<Table align=center border=0>
			<TR>
      			<TD class=displayalert style="background:transparent"  colspan="4" align="center" ><%=uNotCat_L%></TD>
    			</TR>
   			</Table>
<%
		}
		else
		{
%>
			<br><br><br>
			<Table align=center border=0>
			<TR>
				<Td class=displayalert style="background:transparent"  colspan="4" align="center" nowrap><%=noMatPlzCli_L%> </TD>
			</TR>
			</Table>
	<Div id="MenuSol"></Div>			
			
<%
		} //end if syncFlag.equalsN
		return;
	}
	
%>
		<Div id="theads">
		<table width="53%" id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		
		</Table>
		</Div>
        	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:50%;height:60%;left:0%">
		<table width="100%" id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >		
		<tr>
					<th width="40%"> Catalog</th>
					<th width="60%"> Description </th>
		</tr>
		
<%		
		String GroupNum = "";
		String GroupDescription = "";
		for ( int i = 0 ; i <  Rows; i++ )
		{
			// Check for the Terminal Flag of the Product Group
			GroupNum = (String)ret.getFieldValue(i,PROD_GROUP_NUMBER);
			GroupDescription = (String)ret.getFieldValue(i,PROD_GROUP_WEB_DESC);
			
%>			
			<tr align="left">
				<td width="40%">
<%
			if ( ret.getFieldValue (i, PROD_GROUP_TERMINAL_FLAG).equals("Y") )
			{	// if Last Level
				if ( GroupNum.startsWith("~"))
				{// if Favourite Group
%>
					<A HREF = "JavaScript:funShow('ezFavGroupFinalLevel.jsp' ,'<%=GroupNum%>','<%=GroupDescription%>') " <%=statusbar%>>
					<%=GroupDescription%></A>
<%				}
				else
				{ // not Favourite Group
%>
					<A HREF ="JavaScript:funShow('ezCatalogFinalLevel.jsp' ,'<%=GroupNum%>','<%=GroupDescription%>','<%=ret.getFieldValue(i,PROD_GROUP_LEVEL)%>')" <%=statusbar%>>
					<%=GroupDescription%></A>
<%
				}//End If Favourite Group
			}
			else
			{ // not Last Level
%>
				<A HREF ="JavaScript:funShow('ezCatalogNextLevel.jsp' ,'<%=GroupNum%>','<%=GroupDescription%>','<%=ret.getFieldValue(i,PROD_GROUP_LEVEL)%>')" <%=statusbar%>>
				<%=GroupDescription%></A>
<%			}//End if Last level
%>
      			</TD>
			<TD width="60%"><%=GroupDescription%></TD>
			</tr>
<%			
		}// End for: Complete looping thru all groups
%>
		</Table>
		</Div>

		<div id="buttonDiv" align=center style="position:absolute;top:90%;width:100%">
<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Back");
		buttonMethod.add("selSoldTo()");
		out.println(getButtonStr(buttonName,buttonMethod));
%>
		</div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
