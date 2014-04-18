<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/BusinessCatalog/iDeleteFavGroup.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iDeleteFavGroups_Lables.jsp"%>
<html>
<head>
<title>ezListFavouriteGroups</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%></head>
<Script>
	  var tabHeadWidth=70
   	  var tabHeight="60%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<script LANGUAGE="JavaScript">
function CheckSelect() {

    if(document.favgroup.onceSubmit.value!=1){
	var pCount=0;
	var selCount=0;
	pCount = document.favgroup.TotalCount.value;
	var i = 0;
	for ( i = 0 ; i < pCount; i++ ) {
		if(document.favgroup.elements['CheckBox_' + i].checked){
			selCount = selCount + 1;
		}
	}
	if(selCount<1){
		alert("<%=selGrpDel_A%>");
		document.returnValue = false;
		//return false;
	}else{
                document.favgroup.onceSubmit.value=1
		document.body.style.cursor="wait"
		document.returnValue = true;
		document.favgroup.submit();
	}
  }
}
function funBack()
{
	document.location.href="ezListFavGroups.jsp";
}
</script>
<body   onLoad="scrollInit()" onresize="scrollInit()" scroll=no>
<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
<tr>
	<td height="35" class="displayheaderback" align=center width="100%">Delete Catalog</td>
</tr>
</table>
<form method="post" action="ezConfirmDelFav.jsp" name="favgroup">
<input type="hidden" name="TotalCount" value=<%=retprodfavCount%>>
 <input type="hidden" name="onceSubmit" value=0>

<%
	if ( retprodfavCount == 0 )
	{
%>
		<br><br><br>
		<table align=center>
		<tr align="center">
			<td width="16%" height="27" class=displayalert>No catalogs to delete..</td>
		</tr>
		</table>
		<br><br>
		<center>
<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Back");
		buttonMethod.add("funBack()");
		out.println(getButtonStr(buttonName,buttonMethod));
%>		
		</center>
    
<%
		return;
	}
	
%>
		<Div id="theads">
		<Table  width="70%"  id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<tr>
			<th width="10%">&nbsp;</th>
			<th width="25%">Catalog</th>
			<th width="65%"><%=desc_L%></th>
		</Tr>
		</Table>
		</Div>
		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:72%;height:60%;left:20%">
		<Table id="InnerBox1Tab" align=center  border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">
<%
		String groupNumber 	= "";
		String groupDesc 	= "";
		String webDesc 		= "";

		for ( int i = 0 ; i < retprodfavCount ; i++ )
		{
			groupNumber 	= retprodfav.getFieldValueString(i,PROD_GROUP_NUMBER);
			groupDesc 	= retprodfav.getFieldValueString(i,PROD_GROUP_DESC);
			webDesc 	= retprodfav.getFieldValueString(i,PROD_GROUP_WEB_DESC);
%>
			<tr align="center">
				<td width="10%" align=center> 
					<input type="checkbox" name="CheckBox_<%=i%>" value="Selected" unchecked>
				</td>
				<td width="25%"  align="left">
					<a href = "ezFavGroupFinalLevel.jsp?ProductGroup=<%=groupNumber%>&GroupDesc=<%=webDesc%>" <%=statusbar%>><%=groupDesc%></a>
				</td>
				<td width="65%" align="left">
					<%=webDesc%><input type="hidden" name="FavGroup_<%=i%>" value="<%=groupNumber%>">
				</td>
			</tr>
<%
		}//End for
%>
		</table>
		</div>
		<div id="buttonDiv" align=center style="position:absolute;width:100%;top:90%">

<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Delete Catalog");
		buttonMethod.add("CheckSelect()");
		buttonName.add("Back");
		buttonMethod.add("funBack()");
		out.println(getButtonStr(buttonName,buttonMethod));
%>
		
		</div>

</form>
<Div id="MenuSol"></Div>
</body>
</html>
