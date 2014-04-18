<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/BusinessCatalog/iListFavGroups.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iListFavGroups_Lables.jsp"%>
<html>
<head>
<title>ezListFavouriteGroups</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
	<Script>
		  var tabHeadWidth=53
 	   	  var tabHeight="60%"
	</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<script>
function funShow(aGroup,aDesc)
{
       if(document.myForm.onceSubmit.value!=1){
	document.myForm.ProductGroup.value=aGroup
	document.myForm.GroupDesc.value=aDesc
        document.body.style.cursor="wait"
	document.myForm.onceSubmit.value=1
	document.myForm.submit();
     }
}
function ezHref(event)
{
	document.location.href=event;
}
</script>
</head>
<body  onLoad="scrollInit()" onresize="scrollInit()" scroll=no>
<form method="post" action="ezListFavGroups.jsp" name="favgroup">
<%
	String display_header = "Edit Catalog"; 	
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
	
	<br>

<%
	if(retprodfavCount==0)
	{
%>
		<br><br>
		<Table align=center border=0 >
		<TR>
			<Td class=displayalert  colspan="4" align="center"><%=uNotPerCatCli_L%></TD>
		</TR>
		</Table><br><br>
		<center>
<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		
		buttonName.add("Create Catalog");
		buttonMethod.add("ezHref(\"ezAddGroup.jsp\")");		
		out.println(getButtonStr(buttonName,buttonMethod));
%>
		</center>
		<Div id="MenuSol"></Div>
<%
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
					<th width="60%"> <%=desc_L%></th>
		</tr>
<%
		String groupNumber 	="";
		String groupDesc 	="";
		String webDesc 		="";

		for ( int i = 0 ; i < retprodfavCount ; i++ )
		{
			groupNumber 	= retprodfav.getFieldValueString(i,PROD_GROUP_NUMBER);
			groupDesc 	= retprodfav.getFieldValueString(i,PROD_GROUP_DESC);
			webDesc 	= retprodfav.getFieldValueString(i,PROD_GROUP_WEB_DESC);
			java.util.StringTokenizer strtok = new java.util.StringTokenizer(webDesc," ");
			groupDesc=groupDesc.replace('\"',' ');
			groupDesc=groupDesc.replace('\'',' ');
			
%>
			<tr align="left">
				<td width="40%">
					<a HREF = "JavaScript:funShow('<%=groupNumber%>','<%=webDesc%>')"  <%=statusbar%>><%=groupDesc%></a>
				</td>
				<td width="60%"><%=webDesc%></td>
			</tr>
<%
		}//End for
%>
 		</Table>
		</Div>

<div id="buttonDiv" align="center" style="position:absolute;width:100%;top:90%">
<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Create Catalog");
		buttonMethod.add("ezHref(\"ezAddGroup.jsp\")");
		buttonName.add("Change Description");
		buttonMethod.add("ezHref(\"ezGroupDesc.jsp\")");
		buttonName.add("Delete Catalog");
		buttonMethod.add("ezHref(\"ezDeleteFavGroup.jsp\")");
		out.println(getButtonStr(buttonName,buttonMethod));
%>
</div>
</form>

<form onLoad="scrollInit()"name=myForm action="ezFavGroupFinalLevel.jsp">
<input type="hidden" name="onceSubmit" value=0>
<input type=hidden name=ProductGroup value="">
<input type=hidden name=GroupDesc value="">
<input type=hidden name=personalize value="Y">
</form>
<Div id="MenuSol"></Div>
</body>
</html>
