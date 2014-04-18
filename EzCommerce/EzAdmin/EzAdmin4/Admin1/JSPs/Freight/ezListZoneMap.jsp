<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>
<%@ include file="../../../Includes/JSPs/Freight/iListZoneMap.jsp"%>
<%@ include file="../../../../../EzSales/Sales2/JSPs/DrillDownCatalog/ezCountryStateList.jsp"%>

<Html>
<Head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script>
	var tabHeadWidth=60
	var tabHeight="50%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezTabScroll.js"></Script>
<Script src="../../Library/JavaScript/ezTrim.js"></Script>
<Script>
	function funAdd()
	{
		document.myForm.action="ezAddZoneMap.jsp";
		document.myForm.submit();
	}
	function funDelete()
	{
		var len = document.myForm.mapId.length;
		var cnt = 0;
		var chkMap = "";

		if(isNaN(len))
		{
			if(document.myForm.mapId.checked)
			{
				chkMap = document.myForm.mapId.value;
				cnt++;
			}
		}
		else
		{	
			for(i=0;i<len;i++)
			{	
				if(document.myForm.mapId[i].checked)
				{
					chkMap = document.myForm.mapId[i].value;
					cnt++;
					break;
				}
			}
		}
		if(cnt==0)
		{
			alert("Please Select a Mapping to Delete");
			return
		}
		else
		{
			var y = confirm("Are you sure to Delete?");
			
			if(eval(y))
			{
				document.myForm.action="ezDelZoneMap.jsp?chkMap="+chkMap;
				document.myForm.submit();
			}
		}
	}	
	
</Script>
</Head>
<Body  onLoad="scrollInit()" onResize="scrollInit()" scroll="no" >
<Form name=myForm method=post >
<br><br><br>

	<Div align=center>
<%
	if(zmCnt>0)
	{
%>
	<div id="theads">
	<Table width="60%" id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
	<Tr>
		<Th align="center" valign="middle" width="5%">&nbsp;</Th>
		<Th align="center" valign="middle" width="30%">Country</Th>
		<Th align="center" valign="middle" width="20%">From Zip</Th>
		<Th align="center" valign="middle" width="20%">To Zip</Th>
		<Th align="center" valign="middle" width="25%">Zone</Th>
	</Tr>
	</Table>
	</div>
	<div id="InnerBox1Div" style="overflow:auto;position:absolute;width:60%;height:50%">
	<Table width="100%" id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<%
		for(int i=0;i<zmCnt;i++)
		{
			String mapId 	= zoneMapRet.getFieldValueString(i,"EFZ_ID");
			String cCode 	= zoneMapRet.getFieldValueString(i,"EFZ_COUNTRY_CODE");
			String fZip 	= zoneMapRet.getFieldValueString(i,"EFZ_FROM_ZIP");
			String tZip	= zoneMapRet.getFieldValueString(i,"EFZ_TO_ZIP");
			String zone	= zoneMapRet.getFieldValueString(i,"EFZ_ZONE");
			
%>
		<Tr>
			<Td align="center" valign="top" width="5%"><input type="radio" name="mapId" value="<%=mapId%>"></Td>
			<Td align="left" valign="top" width="30%"><%=ezCountry.get(cCode)%></Td>
			<Td align="left" valign="top" width="20%"><%=fZip%></Td>
			<Td align="left" valign="top" width="20%"><%=tZip%></Td>
			<Td align="left" valign="top" width="25%"><%=zone%></Td>
		</Tr>
<%
		}
%>
	</Table>
	</div>
<%
	}
	else
	{
%>
	<br><br><br><br>
	<Table   width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Th>No data present. Click on Add to create.</Th>
	</Tr>
	</Table>
<%
	}
%>
	</Div>
	<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
		<a href="JavaScript:funAdd()"><img src="../../Images/Buttons/<%=ButtonDir%>/add.gif" border=none></a>
		<a href="JavaScript:funDelete()"><img src="../../Images/Buttons/<%=ButtonDir%>/delete.gif" border=none></a>
	</Div>
</Form>
</Body>
</Html>