<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/BusinessCatalog/iGroupDesc.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iGroupDesc_Lables.jsp"%>
<html>
<head>
<title>Change Group Description</title>

<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>

<Script>
	  var tabHeadWidth=80
   	  var tabHeight="64%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>

<script LANGUAGE="JavaScript">
function trim( inputStringTrim) {
fixedTrim = "";
lastCh = " ";
for( x=0;x < inputStringTrim.length; x++)
{
   ch = inputStringTrim.charAt(x);
 if ((ch != " ") || (lastCh != " ")) { fixedTrim += ch; }
lastCh = ch;
}

if (fixedTrim.charAt(fixedTrim.length - 1) == " ") {
fixedTrim = fixedTrim.substring(0, fixedTrim.length - 1); }
return fixedTrim
}

function CheckSelect() {
     if(document.favgroup.onceSubmit.value!=1){
	var pCount=0;
	var selCount=0;
	var chFlag=true;
	pCount = document.favgroup.TotalCount.value;
	var i = 0;
	for ( i = 0 ; i < pCount; i++ ) {
		if(document.favgroup.elements['CheckBox_' + i].checked){ 
			selCount = selCount + 1;
			chFlag=checkEmpty(i);
			if(chFlag)
				break;
		}
	}
	if(chFlag){
		if(selCount<1){
			alert("<%=selItemCDesc_A%>");
			//document.returnValue = false;
			//return false;
		}else{
			//document.returnValue = true;
			document.favgroup.onceSubmit.value=1
			document.body.style.cursor="wait"
			document.favgroup.submit();
		}
	}
     }
}
function checkEmpty(i) {
	var webdesc = document.forms[0].elements['WebDesc_' + i].value;
 	if ((trim(webdesc) == "")){
		alert("<%=entDesc_A%>");
		return false;
	}else{
		return true;
	}
}

function setCheck(i) {
 //var desc = document.forms[0].elements['GroupDesc_' + i].value;
	var webdesc = document.forms[0].elements['WebDesc_' + i].value;
 //if ((trim(webdesc) == "")|| (trim(desc) == "")){
	if ((trim(webdesc) == "")){
		alert("<%=entDesc_A%>");
		document.returnValue = false;
	}else{
		document.forms[0].elements['CheckBox_' + i].checked = true;
		document.returnValue = true;
	}
}
</script>
</head>
<body   onLoad="scrollInit()" onresize="scrollInit()" scroll=no>
<form method="post" action="ezSaveFavGroupDesc.jsp" name="favgroup">

<input type="hidden" name="TotalCount" value="<%=retprodfavCount%>">
<input type="hidden" name="onceSubmit" value=0>
<%
	String display_header = "Change Catalog Description"; 	 
%>
<%@ include file="../../../Sales2/JSPs/Misc/ezDisplayHeader.jsp"%>
<br>
<%
	if ( retprodfavCount == 0 )
	{
%>
	<br><br><br>
	<table align=center >
	<tr >
		<td width="11%" height="27" align=center class=displayalert>No catalogs to list.</th>
	</tr>
	</table>
	<br><br>
	<center>
<%
	     		buttonName = new java.util.ArrayList();
	     		buttonMethod = new java.util.ArrayList();
	     		buttonName.add("Back");
	     		buttonMethod.add("history.go(-1)");
	     		out.println(getButtonStr(buttonName,buttonMethod));
%>
	</center>
    
<%
	return;
	}

%>
	<Div id="theads">
	<Table  width="80%"  id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<tr>
		<th width="8%">&nbsp;</th>
		<th width="29%">Catalog</th>
		<th width="63%"><%=desc_L%></th>
	</Tr>
	</Table>
	</Div>
	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:80%;height:60%;left:20%">
	<Table id="InnerBox1Tab" align=center  border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">
<%
	for ( int i = 0 ; i < retprodfavCount ; i++ )
	{
		String groupNumber = (String)(retprodfav.getFieldValue(i,PROD_GROUP_NUMBER));
		String groupDesc   = (String)(retprodfav.getFieldValue(i,PROD_GROUP_DESC));
		String webDesc     = (String)(retprodfav.getFieldValue(i,PROD_GROUP_WEB_DESC));
%>
		<tr align="center">
		<td  width="8%" align=center><input type="checkbox" name="CheckBox_<%=i%>" value="Selected" unchecked></td>
		<td  width="29%" align=left><%=groupDesc%>
			<input type='hidden' name="GroupDesc_<%=i%>" value = '<%=groupDesc%>'>
			<input type="hidden" name="FavGroup_<%=i%>" value="<%=groupNumber%>">
		</td>
		<td  width="63%" align=left>
			<input type="text" class=InputBox name="WebDesc_<%=i%>" size="70" maxlength="30" onChange="setCheck(<%=i%>);return document.returnValue" value="<%=webDesc%>" >
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
  		buttonName.add("Save Changes");
  		buttonMethod.add("CheckSelect()");
  		buttonName.add("Back");
  		buttonMethod.add("history.go(-1)");
  		out.println(getButtonStr(buttonName,buttonMethod)); 
%>
	</div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
