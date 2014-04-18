<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%@ page import ="ezc.ezparam.*,java.util.*" %>
<%
	String matDesc = request.getParameter("matDesc");
	ezc.ezpreprocurement.client.EzPreProcurementManager ezrfqmanager = new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezpreprocurement.params.EziGenericFMParams ezigenericfmparams     = new ezc.ezpreprocurement.params.EziGenericFMParams();
	
	ezc.ezparam.EzcParams ezcparamsunits  = new ezc.ezparam.EzcParams(true);
	
	ezigenericfmparams.setObjectId("MAT_DESC_SEARCH");
	ezigenericfmparams.setInput1(matDesc);
	
	ezcparamsunits.setObject(ezigenericfmparams);
	Session.prepareParams(ezcparamsunits);
	
	
	ezc.ezparam.ReturnObjFromRetrieve retAmdPODetails =  (ezc.ezparam.ReturnObjFromRetrieve)ezrfqmanager.ezCallGenericFM(ezcparamsunits);
%>	

<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<html>
<head>
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
		<Table width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
			<tr>
				<th align="center"><%=myRet.getFieldValueString(0,"MAT_DESC")%>.</th>
			</tr>
		<Table>
		<br>
		
		<Div id="ButtonDiv" style="position:absolute;top=80%;width=100%" align="center" >
		<Table align="center">
		<Tr>
			<Td  align="center" class=blankcell>
				<img src="../../Images/Buttons/<%=ButtonDir%>/Cancel.gif"  border="none" style="cursor:hand" valign=bottom onclick='closeWin()'>
			</Td>
		</Tr>
		</Table>	
		</Div>
<%
		return;
	}
	else
	{
%>
	<Div id="theads">
	<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0  width="85%">
	    	<tr align="center" valign="middle">
			<th width="60%">Material Description</th>
	    	</tr>
 	</table>
 	</Div>
	<Div id="InnerBox1Div" style="overflow:auto;position:absolute;width:100%;height:60%;">
	<Table align=center id="InnerBox1Tab" border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="85%">
		<tr>
			<input type=hidden name="chk" value="<%=matDesc%>">
			<td width="60%" align="center"><%=matDesc%></td>
		</tr>				
	</Table>
	</Div>
	<Div id="ButtonDiv" style="position:absolute;top=80%;width=100%" align="center" >
	<Table align="center">
	<Tr>
		<Td  align="center" class=blankcell>
			<img src="../../Images/Buttons/<%=ButtonDir%>/ok.gif"  border="none" style="cursor:hand" valign=bottom onclick='selectMaterials()'>
		</Td>
	</Tr>
	</Table>	
	</Div>
<%	}
%>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
