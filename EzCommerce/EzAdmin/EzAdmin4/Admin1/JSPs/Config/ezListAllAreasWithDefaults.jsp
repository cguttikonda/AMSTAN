<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListAllAreasWithDefaults.jsp"%>
<%	
	String bussArea = "Purchase Area";
	if(areaFlag.equals("AC"))
		bussArea = "Sales Area";
	String WebSysKey= request.getParameter("WebSysKey");
%>
<html>
<head>
<Title>List All Areas With Defaults</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/ezTabScroll.js"></script>
<Script>
function funSubmit()
{
	document.myForm.action="ezListAllAreasWithDefaultsExcel.jsp";
	document.myForm.submit();
}
</Script>
</head>
<body onLoad='scrollInit()' onresize='scrollInit()' scroll="no">
<form name="myForm" action="">
<input type=hidden name=Area value="<%=areaFlag%>">
<%
	if(defRet.getRowCount()==0)
	{
%>
		<br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  		<Tr align="center">
    		<Th>There are no <%=bussArea%>s to List</Th>
  		</Tr>
		</Table>
		<br>
		<center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</center>
<%
		return;
	}
%>
<br>
	<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width = "89%">
	<Tr>
		<Th width="16%"><%=bussArea%>s With Defaults</Th>
	</Tr>
	</Table>

<%
	int sysRows = defRet.getRowCount();
	java.util.Hashtable myHashCols= new java.util.Hashtable();
	for(int j=0;j<defRet.getColumnCount();j++)
	{
		String tempName=defRet.getFieldName(j);
		if(tempName.endsWith("_DESC"))
		{
			String tempDesc = "";
			for(int i=0;i<sysRows;i++)
			{
				if(!"null".equals(defRet.getFieldValueString(i,tempName)))
				{
					tempDesc = defRet.getFieldValueString(i,tempName);
					break;
				}
			}
			myHashCols.put(tempName.substring(0,tempName.length()-5),tempDesc);
		}
	}
%>
<%
	if ( sysRows > 0 )
	{
%>
		<div id="theads">
		<Table  id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
		<Tr>
			<Th width="11%"><%=bussArea%></Th>
<%
			java.util.Enumeration enum1= myHashCols.keys();
			String tempKey="";
			String tempValue="";
			while(enum1.hasMoreElements())
			{
				tempKey=(String)enum1.nextElement();
				tempValue=(String)myHashCols.get(tempKey);
			 	if(tempValue==null || "null".equals(tempValue))
			 		tempValue = "N/A";
%>
					<Th width="11%"><%=tempValue%></Th>
<%
			}
%>
		</Tr>
 		</Table>
 		</div>
		<div id="InnerBox1Div">
		<Table id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
		<Tr>
<%		
		for(int i=0;i<sysRows;i++)
		{
%>
			
			<Td width="11%" title="<%=defRet.getFieldValueString(i,"SYSKEY")%> (<%=defRet.getFieldValueString(i,"SYSKEYDESC")%>)"><input type=text value="<%=defRet.getFieldValueString(i,"SYSKEY")%> (<%=defRet.getFieldValueString(i,"SYSKEYDESC")%>)" class="DisplayBox" size="15" readOnly></Td>
<%
			java.util.Enumeration enum11= myHashCols.keys();
			while(enum11.hasMoreElements())
			{
				tempKey=(String)enum11.nextElement();
				tempKey = defRet.getFieldValueString(i,tempKey);
			 	if(tempKey==null || "null".equals(tempKey))
			 		tempKey = "N/A";
%>
					<Td width="11%"><%=tempKey%>&nbsp;</Td>
<%

			}
%>
			</Tr>
<%
		}
%>
		</Table>
		</div>
<%	
	}
%>
		<div id="ButtonDiv" align = center style="position:absolute;top:90%;width:100%;">
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
			<img src="../../Images/Buttons/<%= ButtonDir%>/downloadinexcel.gif" height="20" style="cursor:hand" onClick="funSubmit()">
		</div>
</body>
</html>
