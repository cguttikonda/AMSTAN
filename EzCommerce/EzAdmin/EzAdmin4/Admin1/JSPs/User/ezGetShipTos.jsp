<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<jsp:useBean id="BPManager1" class="ezc.client.CEzBussPartnerManager" scope="session"></jsp:useBean>
<%

	String selSysKey	= request.getParameter("WebSysKey");
	//out.println("selSysKey:::::::::::::::::"+selSysKey);
	String websys="";
	if("All".equals(selSysKey)) 
	{
		for(int i=0;i<ret.getRowCount();i++)
		{
			if(i==0)
			{
				selSysKey="'"+ret.getFieldValueString(i,SYSTEM_KEY)+"'";
			}
			else
			{
				selSysKey=selSysKey+",'"+ret.getFieldValueString(i,SYSTEM_KEY)+"'";
			}
		}
	}
	ReturnObjFromRetrieve ret1 = null;
	if((selSysKey!=null))
	{

		EzcBussPartnerParams bparams = new EzcBussPartnerParams();
		EzcBussPartnerNKParams bnkparams = new EzcBussPartnerNKParams();
		bnkparams.setSys_key(selSysKey);
		//out.println("getSys_key::::::"+bnkparams.getSys_key());
		bnkparams.setLanguage("EN");
		bparams.setObject(bnkparams);
		Session.prepareParams(bparams);
		// Get Business Partners

		ezc.ezcommon.EzLog4j.log("getBussPartnersBySysKeygetBussPartnersBySysKey","D");
		ret1 =(ReturnObjFromRetrieve) BPManager1.getBussPartnersBySysKey(bparams);
		ezc.ezcommon.EzLog4j.log("getBussPartnersBySysKeygetBussPartnersBySysKey","D");
	}	
	int rCount = ret1.getRowCount();
	//out.println("ret1:::::::::::::::::"+ret1.toEzcString());
	ret1.sort(new String[]{"EBPC_BUSS_PARTNER"},true);

%>
<html>
<head>
<Title>List Of Users</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script src="../../Library/JavaScript/ezTrim.js"></script>
<Script>

function funSelectedSolto()
{
	var chkLen = document.myForm.chk.length
	var count=0
	var chkObj  ="";
	for(i=0;i<chkLen;i++)
	{
		
		if(document.myForm.chk[i].checked)
		{
			//alert(chkObj.length)	
			chkObj = (chkObj +(chkObj.length > 0 ? "*" : "") +funTrim(document.getElementById("cb_"+i).value));	
			count++;
		}	
	}
	if(count==0)
	{
		alert("No details are selected ")
		return;
	}	
	else
	{
		//alert(chkObj)
		opener.document.myForm.selectedShip.value=chkObj
		//alert(eval("opener.document.myForm.selectedShip"))
		self.close()
	}
	
	
	

}
function funClose()
{
	self.close()
}
	
</script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></script>

</head>
<body onLoad='scrollInit()' onresize='scrollInit()' scroll="no">
    <form name=myForm method=post>
<%
	
	if ( rCount > 0 )
	{
%>	
	<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center">
		<font color='red' size='2'>Select Ship To's to restrict the visibilty to particular ids</font>
	
	</Tr>
	</Table>	
	<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center">
		<Td class="displayheader">List Of Partners </Td>
	</Tr>
	</Table>
		
	<div id="theads">
		<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
		<Tr align="left">
			<Th width="5%">&nbsp;</Td>
			<Th width="15%" align = "center">Ship To</Th>
			<Th width="68%" align = "center">Company  Name</Th>
			
			
		</Tr>
		</Table>
	</div>
	<div id="InnerBox1Div">
	<Table align="center" id="InnerBox1Tab" border=1 borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
<%
	
	for (int i = 0 ; i < rCount; i++)
	{

		String pGroup = ret.getFieldValueString(i,"ESKD_SYS_KEY");
		String pDesc = ret.getFieldValueString(i,"ESKD_SYS_KEY_DESC");
%>
		<Tr align="left">
		
			<Td width="5%" align=center>
				<input type="checkbox" name="chk" id="cb_<%=i%>" value="<%=ret1.getFieldValueString(i,"EBPC_BUSS_PARTNER")%>" >
			</Td>
			<Td width="15%">
				<a href = "../Partner/ezShowBPInfo.jsp?BusPartner=<%=ret1.getFieldValueString(i,"EBPC_BUSS_PARTNER")%>" class=bb><%=ret1.getFieldValueString(i,"EBPC_BUSS_PARTNER")%></a>
			</Td>
			<Td width="68%" id="compName">
				<%=ret1.getFieldValueString(i,"ECA_COMPANY_NAME")%>
			</Td>
	
		
		</Tr>
<%
	}
%>
	</Table>
	</div>
	
	
	<div id="ButtonDiv" align="center" style="position:absolute;top:80%;width:100%">
		<a href="javascript:funSelectedSolto()"><img src="../../Images/Buttons/<%= ButtonDir%>/ok.gif" border=none></a>
		<a href="javascript:funClose()"><img src="../../Images/Buttons/<%= ButtonDir%>/close.gif" border=none></a>
		
	</div>	
<%
	}
	else
	{
%>
		<Table  width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr align="center">
			<Td class="displayheader">No Users to list</Td>
		</Tr>
		</Table>
		<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
			<a href="javascript:funClose()"><img src="../../Images/Buttons/<%= ButtonDir%>/close.gif" border=none></a>
		
		</div>		
<%
	}
%>	

	
</form>
</body>
</html>