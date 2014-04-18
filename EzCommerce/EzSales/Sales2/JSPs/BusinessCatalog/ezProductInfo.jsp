<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/BusinessCatalog/iProductInfo.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iProductInfo_Lables.jsp"%>
<html>
<head>
<title>Product Information</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%></head>
<script language="Javascript">
function setAction(){
	var mat = document.forms[0].ProdNum.value;
	document.forms[0].action = "../ShoppingCart/ezAddFromSpecs.jsp?ProductNumber=" + mat;
	document.returnValue = true;
}

function AddToFav(){
	document.forms[0].action = "../BusinessCatalog/ezAddToProductFavFromSpecs.jsp";
	document.forms[0].submit();
	document.returnValue = true;
}

function popUp(matNo,fileName)
{
	attach=window.open("../DrillDownCatalog/ezImagePopup.jsp?matNo="+matNo+"&fileName="+fileName,"UserWindow","width=750,height=675,left=150,top=100,resizable=yes,scrollbars=yes,toolbar=no,menubar=no");
}
</script>
<body scroll=no>
<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
<tr>
    <td height="35" class="displayheaderback" align=center width="100%"><%=prodInfo_L%></td>
</tr>
</table>
<br>
<form method="post">
 <%
	String UserRole = (String)session.getValue("UserRole");
	String fileName = request.getParameter("fileName");
	
	// Show Material Info
	if (ret != null)
	{
	
		String matNum 		= ret.getFieldValueString(0,MAT_NUMBER);
		String matDesc 		= ret.getFieldValueString(0,MATD_WEB_DESC);
		String mat_specs1 	= ret.getFieldValueString(0,MATD_SPECS1);
		String mat_specs2 	= ret.getFieldValueString(0,MATD_SPECS2);
		String mat_specs3 	= ret.getFieldValueString(0,MATD_SPECS3);
		String mat_specs4 	= ret.getFieldValueString(0,MATD_SPECS4);
%>
		<table width="60%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
			<tr align="left"> 
				<th width="30%" height="14"><%=desc_L%></th>
				<td width="70%" height="14"><%=matDesc%></td>
			</tr>
		</table>
<br>
<table width="40%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<tr>
	<th valign="top" width="37%"><%=image_L%></th>
	
</tr>
<tr align="center">
      <td width="37%" class="blankcell"> 
	<a href="JavaScript:popUp('<%=matNum%>','<%=fileName%>')"><img src="../../Images/IMAGEUPLOAD/<%= fileName %>" border="2" height="200" width="150" vspace="10" hspace="10" <%=statusbar%>></a>
        <input type="hidden" name="ProdNum" value=<%=matNum%>>
      </td>
    </tr></table>
<br>
	<div align="center">
<%
    		buttonName = new java.util.ArrayList();
    		buttonMethod = new java.util.ArrayList();
    		buttonName.add("Back");
    		buttonMethod.add("history.go(-1)");
    		out.println(getButtonStr(buttonName,buttonMethod));
%>
	 </div>
</form>
<%
}//End if 
%> 
<Div id="MenuSol"></Div>
</body>
</html>
