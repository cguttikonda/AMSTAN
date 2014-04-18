<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iListOrganogramsLevels.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<html>
<head>
<Script src="../../Library/JavaScript/WorkFlow/ezListOrganogramsLevels.js"></script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
<Script src="../../Library/JavaScript/chkEditAndDeleteOrganogramLevels.js"></Script>
<Script src="../../Library/JavaScript/ezSubmitForm.js"></Script>
</head>
<Body onLoad="scrollInit()" onResize="scrollInit()" scroll="no" >
<Br>
<Form name=myForm method="post" onSubmit="return goForSubmit(document.myForm)">

<%
	//String searchPartner=request.getParameter("searchcriteria");
	session.putValue("mySearchCriteria",searchPartner);
	String chk1= "";
	chk1 = orgCode+","+templateCode+","+orgDesc;
%>
	<input type = "hidden" name = "templateCode" value = "<%=templateCode%>">
	<input type = "hidden" name = "orgCode" value = "<%=orgCode%>">
	<input type = "hidden" name = "orgDesc" value = "<%=orgDesc%>">
	<input type = "hidden" name = "chk1" value = "<%=chk1%>">
	<input type="hidden" name="searchcriteria" value="$">
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
<Tr align="center">
	  <Th width="35%" class="labelcell">Level
      </Th>
      <Td width="65%" class="blankcell">
        	<select name="level" style="width:100%" id=FullListBox onChange="funSubmit()">
		<option value="sel">--Select Level--</option>
<%
		retSteps.sort(new String[]{"STEP_DESC"},true);
		int stepCount = retSteps.getRowCount();
		for(int i=0;i<stepCount;i++)
		{
			if(level!=null)
			{

				if(level.equals(retSteps.getFieldValueString(i,"STEP")))
				{
%>
					<option value='<%=retSteps.getFieldValueString(i,"STEP")%>,<%=retSteps.getFieldValueString(i,"ROLE")%>,<%=retSteps.getFieldValueString(i,"OPTYPE")%>' selected><%=retSteps.getFieldValueString(i,"STEP_DESC")%> (<%=retSteps.getFieldValueString(i,"STEP")%>)</option>
<%				}
				else
				{
%>
					<option value='<%=retSteps.getFieldValueString(i,"STEP")%>,<%=retSteps.getFieldValueString(i,"ROLE")%>,<%=retSteps.getFieldValueString(i,"OPTYPE")%>'><%=retSteps.getFieldValueString(i,"STEP_DESC")%> (<%=retSteps.getFieldValueString(i,"STEP")%>)</option>
<%				}
			}
			else
			{
%>
					<option value='<%=retSteps.getFieldValueString(i,"STEP")%>,<%=retSteps.getFieldValueString(i,"ROLE")%>,<%=retSteps.getFieldValueString(i,"OPTYPE")%>'><%=retSteps.getFieldValueString(i,"STEP_DESC")%> (<%=retSteps.getFieldValueString(i,"STEP")%>)</option>
<%
			}
		}
%>

</select>
</Td>
</Tr>
</Table>
<%
	if(level!=null && !level.equals("sel"))
	{
		if(listRet.getRowCount()==0)
		{
%>
			<br><br><br><br>
			<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
			<Tr>
				<Th width="100%" align=center>
					No Organograms Levels To List.
				</Th>
			</Tr>
			</Table>
			<br>
			<center>
				<input type=image  src="../../Images/Buttons/<%= ButtonDir%>/add.gif"  alt="Click Here To Add" border=no onClick="funOpt(1,'ezAddOrganogramLevels.jsp')">
				<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
			</center>
<%
		}
		else
		{
%>
 			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
			<Tr>
			<td align = "center">
				<%@ include file="../../../Includes/Lib/WFAlphabetBean.jsp" %>
			</Td>
			</Tr>
			</Table>
<%
			if(listRet!=null && alphaTree.size()>0 )
			{
				ezc.ezbasicutil.EzSearchReturn mySearch = new ezc.ezbasicutil.EzSearchReturn();
				if(searchPartner !=null && (! "null".equals(searchPartner)) && searchPartner.length()!=0)
				{
	      	    		mySearch.search(listRet,"PARTICIPANT",searchPartner.toUpperCase());
				}
				if(searchPartner !=null && (! "null".equals(searchPartner)) && searchPartner.length()!=0 && listRet.getRowCount()==0)
				{
%>
					<br><br><br><br>
					<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
					<Tr>
				    	<Td class="displayheader">
    		      			<div align="center">There are no Organogram Levels to list with alphabet starts with "<%=searchPartner.substring(0,searchPartner.indexOf("*"))%>".</div>
		    			</Td>
				  	</Tr>
				  	</Table>
					<br>
					<center>
						<input type=image  src="../../Images/Buttons/<%= ButtonDir%>/add.gif"  alt="Click Here To Add" border=no onClick="funOpt(1,'ezAddOrganogramLevels.jsp')">
						<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
					</center>
<%
					return;
				}
			}
%>
			<Table  align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
			<Tr class=trClass>
			<Td align=center class=displayheader>Organogram Levels List of <%=orgDesc%> (<%=orgCode%>)</Td>
			</Tr>
			</Table>
			<div id="theads">
			<Table id="tabHead" align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="100%">
			<Tr class=trClass>
			<Th align=center width="5%">&nbsp;</Th>
			<Th align=center width="25%">Participant</Th>
			<Th align=center width="40%">Description</Th>
			<Th align=center width="25%">Parent</Th>
			</Tr>
			</Table>
			</Div>
			<div id="InnerBox1Div">
			<Table id="InnerBox1Tab" align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<%
			listRet.sort(new String[]{"PARTICIPANT"},true);
			int orgCount = listRet.getRowCount();
			for(int i=0;i<orgCount;i++)
			{
			//	if(level.equals(listRet.getFieldValueString(i,"ORGLEVEL")))
			//	{
					String parent = listRet.getFieldValueString(i,"PARENT");
					if(parent.equals("") || parent.equals("null"))
						parent = " ";
%>
					<Tr class=trClass>
					<label for="cb_<%=i%>">
					<Td class=tdClass align=left width="5%">
						<input type=checkbox name=chk id="cb_<%=i%>" value="<%=listRet.getFieldValue(i,"CODE")%>#<%=listRet.getFieldValue(i,"ORGLEVEL")%>#<%=listRet.getFieldValue(i,"PARTICIPANT")%>#<%=listRet.getFieldValue(i,"LANG")%>#<%=listRet.getFieldValue(i,"DESCRIPTION")%>#<%=parent%>">
					</Td>
					<Td class=tdClass align=left width="25%"><%=listRet.getFieldValue(i,"PARTICIPANT")%>&nbsp;</a>
					</Td>
					<Td class=tdClass align=left width="40%"><%=listRet.getFieldValue(i,"DESCRIPTION")%>&nbsp;</Td>
					<Td class=tdClass align=left width="25%"><%=parent%>&nbsp;</Td>
					</label>
					</Tr>
<%
			//	}
			}
%>
			</Table>
			</Div>

			<Div align="center" id="ButtonDiv" style="position:absolute;top:90%;width:100%">
				<input type=image  src=../../Images/Buttons/<%= ButtonDir%>/add.gif  alt="Click Here To Add" border=no onClick="funOpt(1,'ezAddOrganogramLevels.jsp')">
				<input type=image  src=../../Images/Buttons/<%= ButtonDir%>/edit.gif  alt="Click Here To Edit" border=no onClick="funOpt(2,'ezEditOrganogramsLevels.jsp')">
				<input type=image  src=../../Images/Buttons/<%= ButtonDir%>/delete.gif  alt="Click Here To Delete" border=no onClick="funOpt(3,'ezDeleteOrganogramsLevels.jsp')">
				<img src = "../../Images/Buttons/<%= ButtonDir%>/back.gif" style = "cursor:hand" onClick = "JavaScript:history.go(-1)">
			</Div>
<%
		}
	}
	else
	{
%>
		<br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
		<Tr>
			<Td class = "labelcell">
				<div align="center"><b>Please Select Level to continue.</b></div>
			</Td>
		</Tr>
		</Table>
		<br>
		<center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</center>
<%
	}
%>

</Form>
</body>
</html>
