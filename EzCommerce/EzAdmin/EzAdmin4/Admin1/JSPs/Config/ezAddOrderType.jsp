<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import="java.util.*,javax.xml.bind.*,java.io.*,ezc.ezadmin.ordertypes.*" %>
<%@ include file="../../../Includes/JSPs/Config/iSetBusAreaDefaults.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iChangeGroupDesc.jsp"%>
<%
	String alert = request.getParameter("alert");
	String prdGrp=request.getParameter("prdGrp");
	String list[] = new String[]{"","","",""};
	String creation[] = new String[]{"","","",""};
	java.util.List salesAreas =null;
	java.util.List prdgroups=null;
	java.util.List ordNatures = null;
	ezc.ezadmin.ordertypes.OrdNatures ordNat=null;
	SalesAreaListType.SalesAreasType salesareas=null;
	SalesAreaListType.SalesAreasType.PrdGroupsType prdgroupT=null;
	SalesAreaList salesareaList=null;

	if(sys_key!=null && !"sel".equals(sys_key) && prdGrp!=null && !"sel".equals(prdGrp))
	{
		try
		{
			java.util.ResourceBundle bundle=java.util.ResourceBundle.getBundle("Site");
			String filePath=bundle.getString("XSLTEMPDIR") + "EzSales\\";
	
			JAXBContext jc = JAXBContext.newInstance("ezc.ezadmin.ordertypes");
			Unmarshaller u =jc.createUnmarshaller();
			salesareaList = (SalesAreaList)u.unmarshal(new FileInputStream(filePath+"ordertypes.xml"));
		}
		catch(Exception e)
		{
		}
	}
	if(salesareaList != null)
	{
		salesAreas = salesareaList.getSalesAreas();
		String salesarea=null;
		String prdgroup=null;
		int k=0;
		boolean flag=false;
		
		for( Iterator iter = salesAreas.iterator(); iter.hasNext(); )
		{
			salesareas= (SalesAreaListType.SalesAreasType)iter.next();
			salesarea=salesareas.getSalesArea();
			if(sys_key.equals(salesarea))
			{
				prdgroups =salesareas.getPrdGroups();
				for( Iterator iter1 = prdgroups.iterator(); iter1.hasNext(); )
				{
					prdgroupT =(SalesAreaListType.SalesAreasType.PrdGroupsType)iter1.next();
					prdgroup=prdgroupT.getPrdGroup();
	
					if(prdGrp.equals(prdgroup))
					{
						ordNatures =prdgroupT.getOrdNatures();				
						for( Iterator iter2 = ordNatures.iterator(); iter2.hasNext(); )
						{
							ordNat =(ezc.ezadmin.ordertypes.OrdNatures)iter2.next();
							list[k]=ordNat.getListType();
							creation[k]=ordNat.getCreationType();
							k++;	
						}
						flag=true;
						break;	
					}
				}
			}
			if(flag)
				break;
		}
	}
%>
<html>
<head>
<Title>Sales Area Order Types</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/ezTrim.js"></script>
<script>
<%
	if("a".equals(alert))
	{
%>
		alert("Order Types have been updated");
<%
	}   
%>
	function myalert(label)
	{
		if(document.myForm.SystemKey.selectedIndex != 0)
		{
			document.myForm.action="ezAddOrderType.jsp?Area=C";
			document.myForm.submit();
		}
	}
	function myalert1(label)
	{
		if(document.myForm.prdGrp.selectedIndex != 0)
		{
			document.myForm.action="ezAddOrderType.jsp?Area=C";
			document.myForm.submit();
		}
	}
	function chkall()
	{
		for(i=0;i<4;i++)
		{
			obj1=eval("document.myForm.Creation_"+i);
			obj2=eval("document.myForm.List_"+i);
			obj1.value=funTrim(obj1.value);
			obj2.value=funTrim(obj2.value);
			if(obj1.value=="")
			{
				alert("Please Enter Creation");
				obj1.focus();
				return false;
			}
			if(obj2.value=="")
			{
				alert("Please Enter List");
				obj2.focus();
				return false;
			}
		}
		return true;
	}
	function ezAdd()
	{
		if(chkall())
		{
			document.myForm.action="ezAddSaveOrderType.jsp"
			document.myForm.submit();
		}
	}
	function funFocus()
	{
		if(document.myForm.SystemKey != null)
			document.myForm.SystemKey.focus()
	}
	</script>
</head>
<body onLoad="funFocus()">
<form name=myForm method="post">
<%
	int sysRows = retsyskey.getRowCount();
	if(sysRows==0)
	{
%>
		<br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	  	<Tr align="center">
			<Th>There are no Sales Areas to List</Th>
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
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="90%">
<Tr>
	<Td Class = "displayheader" align = "center">Add Order Type</Td>
<Tr>
</Table>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="90%">
<Tr>
	<Th width="20%">Sales Area</th>
	   <Td width="30%">
<%		
		if ( sysRows > 0 )
		{
%>
		      <select name="SystemKey" style="width:100%" id=FullListBox onChange="myalert('<%=areaLabel%>')">
			<option value="sel">--Select <%=areaLabel%>--</option>
<%
			retsyskey.sort(new String[]{SYSTEM_KEY_DESCRIPTION},true);
			for ( int i = 0 ; i < sysRows ; i++ )
			{
				String val = (String)(retsyskey.getFieldValue(i,SYSTEM_KEY));
				String checkFlag = (String)retsyskey.getFieldValue(i,"ESKD_SUPP_CUST_FLAG");
				String syskeyDesc = (String)(retsyskey.getFieldValue(i,SYSTEM_KEY_DESCRIPTION));
				val = val.toUpperCase();
				val = val.trim();
				if(sys_key!=null && !sys_key.equals("sel"))
				{
					if(sys_key.equals(val))
					{
%>
		        			<option selected value=<%=val%> ><%if(checkFlag.equals(areaFlag)){out.println(syskeyDesc);}else{out.println(syskeyDesc);}%></option>
<%					}
					else
					{
%>
		        			<option value=<%=val%> ><%if(checkFlag.equals(areaFlag)){out.println(syskeyDesc);}else{out.println(syskeyDesc);}%></option>
<%
					}
				}
				else
				{
%>
					<option value=<%=val%> ><%if(checkFlag.equals(areaFlag)){out.println(syskeyDesc);}else{out.println(syskeyDesc);}%></option>
<%
				}
			}
%>
			</select>
<%
		}
%>
	   </Td>
	<Th width="20%">Product Group</th>
	<Td width="30%">
		<select  name="prdGrp" style="width:100%" id =FullListBox onChange="myalert1('Please Select product group')">
			<option value="sel">--Select Product Group--</option>
<%
			String grp="";
			if(retPrdGroupsCount>0)
			{
				retPrdGroups.sort(new String[]{"EPGD_WEB_DESC"},true);
				for(int i=0;i<retPrdGroupsCount;i++)
				{
					grp=retPrdGroups.getFieldValueString(i,"EPG_NO");
					if(grp.equals(prdGrp))
					{
%>
						<option value="<%=grp%>" selected><%=retPrdGroups.getFieldValueString(i,"EPGD_WEB_DESC")%></option>
<%				
					}
					else
					{
%>
						<option value="<%=grp%>"><%=retPrdGroups.getFieldValueString(i,"EPGD_WEB_DESC")%></option>
<%
					}
				}
			}
%>
		 </select>
	</Td>
</Tr>
	<th colspan=2 width=50% >Standard Order<input type=hidden name="ordNature" value="ORD"></th>
	<th colspan=2 width=50%>Returns Order<input type=hidden name="ordNature" value="RET"></th>
</tr>
<tr>
	<th align="left">Creation </th>
	<td><input type = "text" class = "InputBox" name="Creation_0" value="<%=creation[0]%>" size=4 maxlength=4></td>
	<th align="left">Creation</th>
	<td ><input type = "text" class = "InputBox" name="Creation_1" value="<%=creation[1]%>" size=4 maxlength=4></td>
</tr>	
<tr>
	<th align="left">List </th>
	<td><input type = "text" class = "InputBox" name="List_0" value="<%=list[0]%>"></td>
	<th align="left">List</th>
	<td><input type = "text" class = "InputBox" name="List_1" value="<%=list[1]%>"></td>
</tr>
<tr>
	<th colspan=2 width=50%>Breakages Order<input type=hidden name="ordNature" value="BRE"></th>
	<th colspan=2 width=50%>FRS order<input type=hidden name="ordNature" value="FRS"></th>
</tr>
<tr>
	<th align="left">Creation </th>
	<td><input type = "text" class = "InputBox" name="Creation_2" value="<%=creation[2]%>" size=4 maxlength=4></td>
	<th align="left">Creation</th>
	<td><input type = "text" class = "InputBox" name="Creation_3" value="<%=creation[3]%>" size=4 maxlength=4></td>
</tr>
<tr>
	<th align="left">List </th>
	<td><input type = "text" class = "InputBox" name="List_2" value="<%=list[2]%>"></td>
	<th align="left">List</th>
	<td><input type = "text" class = "InputBox" name="List_3" value="<%=list[3]%>"></td>
</tr>
</table>
<br>
<center>
    		<a href="javascript:ezAdd()"><img src="../../Images/Buttons/<%= ButtonDir%>/add.gif" border=none></a>
    		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>
</form>
</body>
</html>