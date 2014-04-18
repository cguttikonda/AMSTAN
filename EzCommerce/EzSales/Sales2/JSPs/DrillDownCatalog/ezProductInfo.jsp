<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../../Includes/JSPs/BusinessCatalog/iProductInfo.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iProductInfo_Lables.jsp"%>
<html>
<head>
	<Script>
		  var tabHeadWidth=70
 	   	  var tabHeight="65%"
	</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
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
	attach=window.open("ezImagePopup.jsp?matNo="+matNo+"&fileName="+fileName,"UserWindow","width=750,height=675,left=150,top=90,resizable=yes,scrollbars=yes,toolbar=no,menubar=no");
}
</script>
<body scroll=no>
<!--table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="70%">
<tr>
    <td height="20" class="displayheaderback" align=center width="100%"><%=prodInfo_L%></td>
</tr>
</table-->
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
		String tempmatNum = "";
		
		try
		{
			tempmatNum=Integer.parseInt(matNum)+"";
		}
		catch(Exception e)
		{
			tempmatNum = matNum;
		}
%>
		<table width="60%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
			<tr align="left"> 
				<th width="30%" height="14"><%=desc_L%></th>
				<td width="70%" height="14"><%=tempmatNum%>--><%=matDesc%></td>
			</tr>
		</table>
<br>
<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:70%;height:65%;left:15%">
		<Table width="100%" id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<tr>
	<th valign="top" width="37%"><%=image_L%></th>
</tr>
<tr align="center">
      <td width="37%" class="blankcell"> 
	<a href="JavaScript:popUp('<%=matNum%>','<%=fileName%>')"><img src="../../Images/IMAGEUPLOAD/<%=fileName%>" border="2"  height="200" width="150" vspace="10" hspace="10"  <%=statusbar%>></a>
        <input type="hidden" name="ProdNum" value=<%=matNum%>>
      </td></tr></table>
</Div>      
<br>
	<div align="center" style="overflow:auto;position:absolute;top:90%;left:45%">
<%
    		buttonName   = new java.util.ArrayList();
    		buttonMethod = new java.util.ArrayList();
    		String mainf = request.getParameter("win");
    		
    		if(mainf!=null)
    		{
    			mainf = mainf.trim();

			if(mainf!="")
			{
				buttonName.add("Close");
				buttonMethod.add("window.close()");
			}	
		}	
		else
		{
    			buttonName.add("Back");
    			buttonMethod.add("history.go(-1)");
    		}	
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
