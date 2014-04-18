
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iListBPBySysKey.jsp"%>
<%@ page import="java.util.*" %>
<%
	//String searchPartner=request.getParameter("searchcriteria");
%>
<html>
<head>
<Title>List Business Partners </Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
<Script>
function funSearch()
{
	if(document.myForm.WebSysKey.selectedIndex==0)
	{
		alert("Please Select <%=areaLabel.substring(0,areaLabel.length()-1)%>")
		document.myForm.WebSysKey.focus();
	}
	else if(document.myForm.searchcriteria.value == "")
	{
		alert("Please enter Search Criteria")
		document.myForm.searchcriteria.focus()
	}
	else
	{
		myCriteria = document.myForm.searchcriteria.value;
		myVal="SW"
		for(i=0;i<document.myForm.chk1.length;i++)
		{
			if(document.myForm.chk1[i].checked)
			{
				myVal=document.myForm.chk1[i].value
				break;
			}
		}
		if(myVal=="SW")
		{
			document.myForm.searchcriteria.value = myCriteria+"*";
		}
		if(myVal=="EW")
		{
			document.myForm.searchcriteria.value="*"+myCriteria;
		}
		document.myForm.action = "ezSearchBPBySysKey.jsp";
		document.myForm.submit();
	}	
}
function funFocus()
{
	document.myForm.searchcriteria.focus()
}
</Script>
</head>
<body onLoad="scrollInit()" onResize = "scrollInit()" scroll=no>
<form name=myForm method=post action="">
<input type="hidden" name="Area" value="<%=areaFlag%>">
<%
if(ret.getRowCount()==0)
{
%>
	<br><br><br><br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr>
		<Td class="displayheader" align="center">No <%=areaLabel%> To List Partners.</Td>
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
<%
	String isSel ="";
		String tabHeader = "<Th width='5%'>M</Th><Th width='20%'>Partner</Th><Th WIDTH='25%'>Description</Th>";
		if("All".equals(websys)){
			isSel = "selected";
			tabHeader = "<Th width='5%'>M</Th><Th width='20%'>Partner</Th><Th WIDTH='25%'>Description</Th><Th WIDTH='25%'>Pur. Area</Th><Th WIDTH='25%'>Pur. Area Desc</Th>";
		}	
			

%>

	
	<br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
	<Tr align="center">
		<Th width="35%" class="labelcell"><%=areaLabel.substring(0,areaLabel.length()-1)%>
      	</Th>
      	<Td width="65%" class="blankcell">
        	<select name="WebSysKey" style="width:100%" id=FullListBox>
		<option value="sel">--Select <%=areaLabel.substring(0,areaLabel.length()-1)%>--</option>
<%
		if ( areaFlag.equals("V") ){
%>			
				<option value="All" <%=isSel%>  >All</option>
<%
		}
		if(websys!=null)
		{
			ret.sort(new String[]{SYSTEM_KEY_DESCRIPTION},true);
			for(int i=0;i<ret.getRowCount();i++)
			{
				if(websyskey!=null)
				{
					if(websyskey.equals(ret.getFieldValue(i,SYSTEM_KEY)))
					{
%>
						<option value='<%=ret.getFieldValue(i,SYSTEM_KEY)%>' selected><%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> (<%=ret.getFieldValue(i,SYSTEM_KEY)%>)</option>
<%				
					}
					else
					{
%>
						<option value='<%=ret.getFieldValue(i,SYSTEM_KEY)%>'><%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> (<%=ret.getFieldValue(i,SYSTEM_KEY)%>)</option>
<%				
					}
				}
				else
				{
%>
					<option value='<%=ret.getFieldValue(i,SYSTEM_KEY)%>'><%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> (<%=ret.getFieldValue(i,SYSTEM_KEY)%>)</option>
<%
				}
			}
		}
%>
	</select>
	</Td>
	</Tr>
	</Table>
	<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
	<label for="cb_<%=0%>">
		<Th><input type=radio name=chk1 id="<%=0%>" value="SW" onClick = funFocus() checked>Starts With</Td>
	</label>
	<label for="cb_<%=1%>">
		<Th><input type=radio name=chk1 id="cb_<%=1%>" value="EW" onClick = funFocus()>Ends With</Td>
	</label>
		<Th><input type=radio name=chk1 value="EQ" onClick = funFocus()>Equals To</Td>
		<Th>Partner Name</Th>
		<Td><input type=text class = "InputBox" size=15 name="searchcriteria"></Td>
		<Td align = "center"><img src="../../Images/Buttons/<%= ButtonDir%>/search.gif" border=none onClick="funSearch()" style = "cursor:hand"></Td>
	</Tr>
	</Table>
<%
	if(searchPartner==null || "null".equals(searchPartner))
	{
%>
		<br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
		<Tr>
			<Th>Please select Search Pattern and click on Search.</Td>
		</Tr>
		</Table>	
		<br>
		<center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</center>
<%
	return;
	}
	if(ret1!=null )
	{
		ezc.ezbasicutil.EzSearchReturn mySearch = new ezc.ezbasicutil.EzSearchReturn();
		if(searchPartner !=null && (! "null".equals(searchPartner)) && searchPartner.length()!=0)
		{
	          mySearch.search(ret1,"ECA_COMPANY_NAME",searchPartner.toUpperCase());
		}
     
		if(searchPartner !=null && (! "null".equals(searchPartner)) && searchPartner.length()!=0 && ret1.getRowCount()==0)
		{
			if(searchPartner.indexOf("*")==-1)
				searchPartner = "Equals to "+searchPartner;
			else if(searchPartner.indexOf("*")==0)
				searchPartner = "Ends with "+searchPartner.substring(searchPartner.indexOf("*")+1,searchPartner.length());
			else
				searchPartner = "Starts with "+searchPartner.substring(0,searchPartner.indexOf("*"));
%>
			<br><br><br><br>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
			<Tr>
			    	<Td class="displayheader" align = "center"><nobr>
					There are no Partners to list with Partner Name <%=searchPartner%>.
				</nobr>
		    		</Td>
		  	</Tr>
		  	</Table>
			<br>
			<center>
				<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
			</center>
<%
			return;
		}
	}
%>	
<%
	if(ret1!=null && !"sel".equals(websyskey))
	{
		if(ret1.getRowCount()>0)
		{
%>
			<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
  			<Tr align="center">
    				<Td class="displayheader">List of Partners</Td>
  			</Tr>
			</Table>
			<div id="theads">
			<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 >
			<Tr>
				<!--<Th width="5%">&nbsp;</Th>
				<Th width="20%">Partner</Th>
				<Th WIDTH="75%">Description</Th>-->
				<%=tabHeader%>
			</Tr>
			</Table>
			</div>
			<div id="InnerBox1Div">
			<Table id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%
			//ret1.sort(new String[]{"ECA_COMPANY_NAME"},true);
			ret1.sort(new String[]{"EBPC_BUSS_PARTNER"},true);
			String chkKey = "";
			for(int j=0;j<ret1.getRowCount();j++)
			{
				chkKey = ret1.getFieldValueString(j,"EBPC_BUSS_PARTNER")+"/"+websyskey;
				if("All".equals(websys)){
					chkKey = ret1.getFieldValueString(j,"EBPC_BUSS_PARTNER")+"/"+ret1.getFieldValueString(j,"EBPA_SYS_KEY");
				}
							
%>
				<Tr>
				<label for="cb_<%=j%>">
					<Td width="5%" align = "center"><input type="radio" name="chk1" id="cb_<%=j%>" value= '<%=ret1.getFieldValueString(j,"EBPC_BUSS_PARTNER")%>' >
					<input type="hidden" name="BPDesch" value= '<%=ret1.getFieldValueString(j,"ECA_COMPANY_NAME")%>' ></Td>
					<Td width="20%"><a href = "ezShowBPInfo.jsp?BusPartner=<%=ret1.getFieldValueString(j,"EBPC_BUSS_PARTNER")%>" class=bb><%=ret1.getFieldValueString(j,"EBPC_BUSS_PARTNER")%></a></Td>
					<Td width="25%"><%=ret1.getFieldValueString(j,"ECA_COMPANY_NAME")%></Td>
<%
						if("All".equals(websys)){
%>
							<Td width="25%"><%=ret1.getFieldValueString(j,"EBPA_SYS_KEY")%></Td>
							<Td width="25%"><%=ret1.getFieldValueString(j,"ESKD_SYS_KEY_DESC")%></Td>
<%
						}
%>
				</Tr>
<%
			}
%>
			</Table>
			</div>
			<div id="ButtonDiv" align="center" style="position:absolute;top:92%;width:100%">
				<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
			</div>
<%		}
		else
		{
%>
			<br><br><br><br>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
			<Tr>
		    	<Td class="displayheader" align="center">No Partners To List In This <%=areaLabel.substring(0,areaLabel.length()-1)%></Td>
			</Tr>
			</Table>
			<br>
			<center>
				<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
			</center>
<%			
		}
	}	
%>
</form>	
</body>
</html>