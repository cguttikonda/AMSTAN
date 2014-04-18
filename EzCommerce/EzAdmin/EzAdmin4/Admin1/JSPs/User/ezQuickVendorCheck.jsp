<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/Lib/AdminUtilsBean.jsp"%>
<jsp:useBean id="AdminUtilsManager" class="ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager" scope="session" />
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<%@ page import = "ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*" %>
<%
	int bizAreasCnt = 0;
	if(ret!=null)
		bizAreasCnt = ret.getRowCount();
%>
<html>
<head>
	<Title>Quick Add Vendor</Title>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<script src="../../Library/JavaScript/ezTabScroll.js"></script>
	<script src="../../Library/JavaScript/CheckFormFields.js"></script>
	<Script>
	var areasCnt = <%=bizAreasCnt%>;
	function funChk()
	{
		
		var val ="";
		
			 val = document.myForm.payTo.value;
			if(val=="")
			{
				alert("Please Enter PayTo value");
				document.myForm.payTo.focus();
				return;

			}else{
				document.myForm.action="ezPreQuickAddVendor.jsp"
				document.myForm.submit();
			}
		
		
	}
	function funFocus(){
			
		if(areasCnt>0)
			document.myForm.payTo.focus();
			
	
	}
	</Script>
</head>

<body onLoad='scrollInit();funFocus()' onresize='scrollInit()' scroll = "no">
<form name=myForm method=post  >
<%
	if(bizAreasCnt>0){
%>
	<br>
	<div id="theads">
       	<Table id="tabHead" width="40%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Td class = "displayheader" align = "center" colspan = 2>Quick Add Vendor</Td>
	</Tr>
	<Tr>
		<Th>Pay To*</Th>
		<Td><input type = "text" class = "InputBox" name = "payTo" size = 15 maxlength = "10" ></Td>
	</Tr>
	</Table>
       	</Div>
	<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
	 	<a href="JavaScript:funChk()"><image src = "../../Images/Buttons/<%= ButtonDir%>/continue.gif" border=none></a>
	 	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none></a>
	</div>
<%
	}else{
%>
		<br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
		<Tr align="center">
		    		<Th>There are no Purchase Areas to List</Th>
		</Tr>
		</Table>
		<br>
		<center>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none></a>
		</center>
<%
	}
%>	
<input type="hidden" name="Area" value="V" >	
</form>
</html>