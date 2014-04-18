<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import="java.util.*,java.text.*,ezc.ezutil.FormatDate" %>
<%@ include file="../../../Includes/Jsps/Rfq/iSAPVendorList.jsp" %>
<Html>
<Head>
	<base TARGET="_self">
	<Script>
		var tabHeadWidth=95
		var tabHeight="57%"
		var quantity = <%=quantity%>
	</Script>
	<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
	<Script src="../../Library/JavaScript/Rfq/ezSAPVendorList.js"></Script>
	<Title>SAP Vendor List</Title>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
</Head>

<Body bgcolor="#FFFFF7"  onLoad="scrollInit()" onResize="scrollInit()" scroll=no>
<Form name="myForm1">

<%
	if(retSAPVendorCount > 0)
	{
%>

		<Div id="theads">
		<Table id="tabHead" width=95% align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
		<Tr align="center" valign="middle">
			<Th width="10%">		&nbsp;		</Th>
			<Th width="45%">	Vendor Code	</Th>
			<Th width="45%">	Vendor Name	</Th>
		</Tr>
		</Table>
		</Div>
		<DIV id="InnerBox1Div">
		<Table id="InnerBox1Tab" width=100% border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>
<%
		String dbVendCode = "";
		String dbVendName = "";
		String dfltChkd = "";
		for(int i=0;i<retSAPVendorCount;i++)
		{
			dbVendCode = retSAPVendorList.getFieldValueString(i,"VENDOR_CODE");
			dbVendName = retSAPVendorList.getFieldValueString(i,"VENDOR_NAME");
			if(vc.contains(dbVendCode.trim()))
				dfltChkd = "checked";
			else
				dfltChkd = "";
%>

			<Tr>
				<Td width="10%" align='center'><input type=checkbox name='ven1' <%=dfltChkd%> value='<%=dbVendCode+"#"+dbVendName%>'></Td>
				<Td width="45%"><%=dbVendCode%></Td>
				<Td width="45%"><%=dbVendName%></Td>
			</Tr>	
<%
		}
	}
	else
	{
%>		
		<Div id="theads" style='position:absolute;top:40%'>
		<Table id="tabHead" width=95% align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
		<Tr align="center" valign="middle">
			<Th>No vendors with the selected option</Th>
		</Tr>
		</Table>
		</Div>
<%		
	}
%>

</Table>
</Div>
<Div id="ButtonDiv" style="position:absolute;top=94%;width=100%" align="center" >
<Table align="center">
<Tr>
	<Td  align="center" class=blankcell>
		<img src="../../Images/Buttons/<%=ButtonDir%>/ok.gif"  border="none" style="cursor:hand" valign=bottom onclick='selectedVendors()'>
	</Td>
</Tr>
</Table>	
</Div>
</Form>
<Div id="MenuSol"></Div>
</Body>
</Html>
