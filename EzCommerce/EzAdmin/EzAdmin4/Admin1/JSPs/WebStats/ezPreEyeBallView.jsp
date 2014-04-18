<%@ page import="javax.xml.parsers.*,org.w3c.dom.*,javax.xml.transform.*" %>

<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>

<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session" />
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />

<%
	String type=request.getParameter("type");

	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
	ReturnObjFromRetrieve ret = (ReturnObjFromRetrieve) sysManager.getCatalogAreas(sparams);

	ReturnObjFromRetrieve ret1 = (ReturnObjFromRetrieve) sysManager.getPurchaseAreas(sparams);

	ezc.ezparam.EzDescStructure eds = new ezc.ezparam.EzDescStructure();
	eds.setAreaFlag("S");
	eds.setSyncFlag("N");
	snkparams.setEzDescStructure(eds);
	ReturnObjFromRetrieve ret2 = (ReturnObjFromRetrieve) sysManager.getBusinessAreas(sparams);

	ret.append(ret1);
	ret.append(ret2);

	java.util.Vector grpsVect=new java.util.Vector();
	java.util.Vector opsVect=new java.util.Vector();
	ReturnObjFromRetrieve groupsDetails=new ReturnObjFromRetrieve(new String[]{"GROUP","DESC","OPTIONS"});
	try
	{
		ezc.ezwebstats.EzEyeBallRecorder recorder=new ezc.ezwebstats.EzEyeBallRecorder(false);
		//ReturnObjFromRetrieve grRet=recorder.getGroups();
		ReturnObjFromRetrieve opRet=recorder.getOptions();

		int opCount=opRet.getRowCount();
		if("1".equals(type))
			grpsVect.add("23");
		else if("2".equals(type))
		{
			grpsVect.add("24");
			grpsVect.add("25");
			grpsVect.add("26");
		}
		else
		{
			grpsVect.add("28");
			grpsVect.add("29");
			grpsVect.add("30");
		}

		String grpNum="";
		for(int i=0;i<opCount;i++)
		{
			grpNum=opRet.getFieldValueString(i,"GROUP_NO");
			if(grpsVect.contains(grpNum))
				opsVect.add(opRet.getFieldValueString(i,"OPTION_NO"));

		}

	}
	catch(Exception e)
	{
		out.println(e);
	}
%>

<html>
<head>
 	<script src="../../Library/JavaScript/EzMDYCalender.js"></script>
	<script>

		function funSubmit()
		{
			if(document.myForm.fromdate.value != "" && document.myForm.todate.value == "")
			{
				alert("Please enter TO date");
			}
			else if(document.myForm.fromdate.value == "" && document.myForm.todate.value != "")
			{
				alert("Please enter FROM date");
			}
			else
			{
				document.myForm.action="ezEyeBallView.jsp"
				document.myForm.submit()
			}
		}
	</script>
</head>
<body> <!-- onLoad="setGroups()">-->
<form name=myForm method=post>
	<br>
	<Table  width="90%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	
	<Tr>
		<Td class=displayheader align=center colspan=2>EzEyeBall Track Info Selection </Td>
	</Tr>
	<Tr>
		<Th align=left width="15%">Domain</Th>
		<Td align=left width="85%">
		<Select name=domain multiple size=3 id="FullListBox" style="width:100%">
		<option value="A">Admin</option>
		<option value="C">Customer</option>
		<option value="V">Vendor</option>
		<option value="S">Service</option>
		<option value="R">Reverse Auction</option>
		</Select>
		</Td>
	</Tr>
	<Tr>
	<Th align=left width="15%" >Syskey</Th>
	<Td align=left width="85%">
		<Select name=syskey multiple size=3 id="FullListBox" style="width:100%">
	<%
		for(int i=0;i<ret.getRowCount();i++)
		{
	%>
		<option value="<%=ret.getFieldValue(i,"ESKD_SYS_KEY")%>"><%=ret.getFieldValue(i,"ESKD_SYS_KEY_DESC")%></option>
	<%
		}
	%>
		</Select>
	</Td>	
	</Tr>
	
	<Tr>
		<Td colspan=2 width="100%">
		<Table width=100% align=center height=100% cellspacing=1 cellpadding=0>
		<Tr>
			<Th align=left width="15%">From</Th>
			<Td align=left width="35%"><nobr><Input type=text name=fromdate class=InputBox size=15 readonly><a href="javascript:showCal('document.myForm.fromdate',130,280)"> <img border=no style="cursor:hand" src="../../Library/JavaScript/calender.gif" alt = "Calender" align="middle" ></nobr>
			<Th align=left width="15%">To</Th>
			<Td align=left width="35%">
			<nobr><Input type=text name=todate class=InputBox size=15 readonly><a href="javascript:showCal('document.myForm.todate',130,280)"> <img border=no style="cursor:hand" src="../../Library/JavaScript/calender.gif" alt = "Calender" align="middle" ></nobr>
			</Td>
		</Tr>
		</Table>
		</Td>
		
	</Tr>
	<Tr>
		<Td colspan=2 width="100%">
		<Table width=100% align=center height=100% cellspacing=1 cellpadding=0>
		<Tr>
			<Th align=left width="15%">SoldTo</Th>
			<Td align=left width="35%"><nobr><Input type=text name=soldto class=InputBox style="width:100%"></nobr>
			<Th align=left width="15%">UserId</Th>
			<Td align=left width="35%">
			<nobr><Input type=text name=userid class=InputBox style="width:100%"></nobr>
			</Td>
		</Tr>
		</Table>
		</Td>
	</Tr>	
		
	<!--<Tr>
		<Th align=left width="15%">Group</Th>
		<Td align=left width="85%">
		<Select name=group onChange="setOptions()">
			<option value="">--Select--</option>
		</Select>
		</Td>
	</Tr>

	<Tr>
		<Th align=left width="15%">Feature</Th>
		<Td align=left width="85%">
		<Select name=option>
			<option value="">--Select--</option>
		</Select>
		</Td>
	</Tr>
	-->

	<Tr>
		<Th align=left width="15%">Value1</Th>
		<Td align=left width="85%"><input type=text name=value1 class=InputBox style="width:100%"></Td>
	</Tr>
	<Tr>
		<Th align=left width="15%">Value2</Th>
		<Td align=left width="85%"><input type=text name=value2 class=InputBox style="width:100%"></Td>
	</Tr>

	<Tr>
		<Th align=left width="15%">Value3</Th>
		<Td align=left width="85%"><input type=text name=value3 class=InputBox style="width:100%"></Td>
	</Tr>
	<!--<Tr>
		<Th align=left width=15%">Consolidate On</Th>
		<Td align=left width="85%">
		<Table>
		<Tr>
			<Td><input type=checkbox name=chk1 value="YEAR">Year</Td>
			<Td><input type=checkbox name=chk1 value="MONTH">Month</Td>
			<Td><input type=checkbox name=chk1 value="DAY">Day</Td>
			<Td><input type=checkbox name=chk1 value="DAY">Date</Td>
			<Td><input type=checkbox name=chk1 value="USERID">USERID</Td>
		</Tr>
		<Tr>
			<Td><input type=checkbox name=chk1 value="GROUP">Group</Td>
			<Td><input type=checkbox name=chk1 value="OPTION">Feature</Td>
			<Td><input type=checkbox name=chk1 value="VALUE1">Value1</Td>
			<Td><input type=checkbox name=chk1 value="VALUE2">Value2</Td>
			<Td><input type=checkbox name=chk1 value="VALUE3">Value3</Td>

		</Tr>
		</Table>

	</Tr>
	-->
	</Table>
		<input type=hidden name=chk1 value="USERID">

	<%
		for(int i=0;i<grpsVect.size();i++)
		{
	%>
			<input type=hidden name=group value="<%=grpsVect.elementAt(i)%>">
	<%
		}
		for(int i=0;i<opsVect.size();i++)
		{
	%>
			<input type=hidden name=option value="<%=opsVect.elementAt(i)%>">
	<%
		}
	%>

	<br>
	<center>
	<a href="JavaScript:funSubmit()"><img src="../../Images/Buttons/<%= ButtonDir%>/continue.gif" border=none></a>
	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
	</center>
	
</form>
</body>
</html>
