<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%
	String material = request.getParameter("matCode");
	String matNo = material;
	String mat="";
	mat  = "000000000000000000"+material.trim();
	material = mat.substring(mat.length()-18,mat.length());
	ezc.ezpreprocurement.client.EzPreProcurementManager PreProcurementManager=new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezpreprocurement.params.EziPreProcurementParams param=new ezc.ezpreprocurement.params.EziPreProcurementParams();
	param.setMaterial(material);		//"000000000001000000"
	ezc.ezparam.EzcParams mainParams=new ezc.ezparam.EzcParams(true);
	mainParams.setObject(param);
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve myRet=(ezc.ezparam.ReturnObjFromRetrieve)PreProcurementManager.ezGetMaterialDetails(mainParams);
%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<html>
<head>
<Title>Search Result</Title>
<base target="_self">
<Script src="../../Library/JavaScript/Trim.js"></Script>
<Script>
	var tabHeadWidth=96
	var tabHeight="50%"
</Script>
<Script>
	function selectMaterials()
	{
		chkObj = document.myForm.chk.value;
		opener.window.document.myForm.matNo.value="<%=matNo%>";
		opener.window.document.myForm.matNum.value="";
		opener.window.document.myForm.matDesc.value=chkObj;
		window.close();
	}
	function closeWin()
	{
		opener.window.document.myForm.matDesc.value="";
		window.close();
	}
</Script>	
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
</head>
<body>
<form name='myForm'>
<%
	String type 	= "";
	String matDesc	= "";
	
	if(myRet != null)
	{
		type 	= myRet.getFieldValueString(0,"TYPE");
		matDesc	= myRet.getFieldValueString(0,"MAT_DESC").trim();	
	}
	
	if(matDesc==null || "null".equals(matDesc) || "".equals(matDesc))
	{
		matDesc = "No Material Data Available &nbsp;";
	}
	
	if("E".equals(type))
	{
%>
		<br>
		<Table width="60%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>
			<tr>
				<th align="center"><%=myRet.getFieldValueString(0,"MAT_DESC")%>.</th>
			</tr>
		<Table>
		<br>
		
		<Div id="ButtonDiv" style="position:absolute;top=80%;width=100%" align="center" >
<%
			butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;Cancel&nbsp;&nbsp;&nbsp;&nbsp;"); 
			butActions.add("closeWin()");
			out.println(getButtons(butNames,butActions));

%>
		</Div>
<%
		return;
	}
	else
	{
%>
	<Div id="theads">
	<Table id="tabHead" border=0 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=5 cellSpacing=1  width="85%">
	    	<tr align="center" valign="middle">
			<th width="60%">Material Description</th>
	    	</tr>
 	</table>
 	</Div>
	<Div id="InnerBox1Div" style="overflow:auto;position:absolute;width:100%;height:60%;">
	<Table align=center id="InnerBox1Tab" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 width="85%">
		<tr>
			<input type=hidden name="chk" value="<%=matDesc%>">
			<td width="60%" align="center"><%=matDesc%></td>
		</tr>				
	</Table>
	</Div>
	<Div id="ButtonDiv" style="position:absolute;top=80%;width=100%" align="center" >
<%
	butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"); 
	butActions.add("selectMaterials()");
	out.println(getButtons(butNames,butActions));	
%>
	</Div>
<%	}
%>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
