<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iAddIntranetUser.jsp"%>
<%
	session.putValue("myUserType","2");
	String mySearchCriteria = FirstName.substring(0,1)+"*";
	session.putValue("mySearchCriteria",mySearchCriteria);
	String myAreaFlag = (String)session.getValue("myAreaFlag");
%>
<html>
<head>
<script language = "JavaScript" src="../../../Includes/Lib/JavaScript/Users.js"></script>
<Title>Add Intranet User Data NEXT</Title>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<Script>
tabHeight = "40%"
function myCheck()
{
	var pCount=0;
	var selCount=0;
	pCount=document.myForm.CheckBox.length;
	if(isNaN(pCount))
	{
		if(document.myForm.CheckBox.checked)
			selCount=1
	}
	else
	{
		for(i=0;i<pCount;i++)
		{
			if(document.myForm.CheckBox[i].checked)
				selCount=selCount+1;
		}
	}

	if(selCount<1)
	{
		alert("Please Select Area(s) to Continue...");
		return false;
	}
	return true;
}
</Script>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
</head>
<body onLoad="scrollInit()" onResize="scrollInit()" scroll="no">
<form name=myForm method=post action="ezSaveAddIntranetUser.jsp" onSubmit = "return myCheck()">
<br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
		<Tr align="center">
	    	<Td class="displayheader">Add Intranet User Information Contd..</Td>
	  	</Tr>
	</Table>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
       	<Tr>
		<Td class="labelcell">User:</Td>
		<Td><%=UserId%>
		<input type=hidden name=UserID value=<%=UserId%>>
		<input type="hidden" name="InitialPassword" size=10 maxlength=10 value="<%=Password%>">
		</Td>
		<Td class="labelcell">First Name:</Td>
		<Td><%=FirstName%>
		<input type=hidden name=FirstName value=<%=FirstName%>>
		</Td>
	</Tr>
	<Tr>
		<Td class="labelcell">Middle Initial:</Td>
		<Td><%=MiddleInit%>
		<input type=hidden name=MidInit value=<%=MiddleInit%>>
		</Td>
		<Td class="labelcell">Last Name:</Td>
		<Td><%=LastName%>
		<input type=hidden name=LastName value=<%=LastName%>>
		</Td>
	</Tr>
	<Tr>
		<Td class="labelcell">Email:</Td>
		<Td><%=Email%>
		<input type=hidden name=Email value=<%=Email%>>
		</Td>
<%
	String aus = "";
	if ( AdminUser.equals("Y") )
	       aus = "checked";
%>
		<Td class="labelcell">User Type:<font face="Tw Cen MT"></font></Td>
		<Td>IntranetUser
		<input type=hidden name=UserType value="2">
		</Td>
	</Tr>
	<Tr>
		<Td class="labelcell">Admin User:</Td>
		<Td>
		<input type="checkbox" name="Admin" <%=aus%>>
		</Td>
	  	<input type="hidden" name="UserGroup" value="0">

  		<Td class="labelcell">Business Partner:</Td>

  		<Td>
<%
		if(retRows>0)
		{
%>
			<a href = "../Partner/ezBPSummaryBySysKey.jsp?WebSysKey=<%=retcatareas.getFieldValueString(0,"ESKD_SYS_KEY")%>&Area=<%=myAreaFlag%>&BusinessPartner=<%=BusPartner%>"><%=BPDesc%></a>
<%
		}
		else
		{
%>
			<%=BPDesc%>
<%
		}
%>
		<input type="hidden" name="BusPartner" value="<%=BusPartner%>">
		<input type=hidden name=BPDesc value=<%=BPDesc%>>
		</Td>
       	</Tr>
	<Tr>
       	<Td class="labelcell">Catalog:</Td>
	<Td >
<%
	if ( catalog_number.equals("0") )
	{
		catalog_description = "No Catalogs Selected";
%>

			<%=catalog_description%>
<%
	}
	else
	{
%>
	<a href = "../Catalog/ezShowCatalog.jsp?CatNumber=<%=catalog_number%>&catDesc=<%=catalog_description%>"><%=catalog_description%></a>
<%
	}
%>
    	<input type=hidden name=CatDescription value=<%=catalog_description%>>
       	<input type="hidden" name="CatalogNumber" value="<%=catalog_number%>">
      	</Td>
        </Tr>
        </Table>
	<div id="theads">
  	<Table id="tabHead" align=center width=80% border=1 bordercolorlight=#000000 bordercolordark=#ffffff cellspacing=0 cellpadding=2>
  	<Tr>
  		<Th width="50%">Select Systems</Th>
  		<Th width="50%">Select Areas</Th>
  	</Tr>
  	</Table>
  	</div>
	<DIV id="InnerBox1Div">
  	<Table id="InnerBox1Tab" align=center width=80% border=1 bordercolorlight=#000000 bordercolordark=#ffffff cellspacing=0 cellpadding=2>
  	<Tr>
  	<Td width="50%"  valign= "top">
        <Table align=center width=100% border=1 bordercolorlight=#000000 bordercolordark=#ffffff cellspacing=0 cellpadding=2>
<%
	if(retRows>0)
	{
		String cAreaKey = "";
		String myAreaKey = "";
		String cAreaDesc = "";
		String sysDesc = "";
		retcatareas.sort(new String[]{"ESKD_SYS_KEY_DESC"},true);
		for(int i = 0 ; i < retRows; i++ )
		{
            		cAreaKey = retcatareas.getFieldValueString(i,"ESKD_SYS_NO");
            		myAreaKey = retcatareas.getFieldValueString(i,"ESKD_SYS_KEY");
            		cAreaDesc = retcatareas.getFieldValueString(i,"ESKD_SYS_KEY_DESC");
            		sysDesc = "";
            		if ( retcatsys.find("ESD_SYS_NO",cAreaKey) )
            		{
                		int x = retcatsys.getCurrentRowId();
                		sysDesc = retcatsys.getFieldValueString(x,"ESD_SYS_DESC");
            		}
%>
			<Tr>
			<Td colspan="2" title = "<%=cAreaDesc%> (<%=myAreaKey%>)">
				<input type="checkbox" name="ACheckBox" value="<%=cAreaKey%>" checked disabled>
				<input type = "text" Class = "DisplayBox" value = "<%=cAreaDesc%> (<%=myAreaKey%>)" size = "55" readonly>
			</Td>
			</Tr>
<%
		}

	}
	else
	{
%>
		<Tr>
		<Td colspan="2">
		  	<font size="2" color="Red">
        			There are no ERP Customers for this Partner.
        		</font>
        	</Td>
		</Tr>
<%
	}
%>
	</Table>
	</Td>
	<Td width="50%" >
<%
	if ( retbpRows > 0 )
	{
%>
          	<Table align=center width=100% border=1 bordercolorlight=#000000 bordercolordark=#ffffff cellspacing=0 cellpadding=2>
<%
		retbpareas.sort(new String[]{"ESKD_SYS_KEY_DESC"},true);
		String areaKey = "";
		String areaFlag = "";
		String areaDesc = "";
		for ( int i = 0 ; i < retbpRows; i++ )
		{
	            	areaKey = retbpareas.getFieldValueString(i,"ESKD_SYS_KEY");
			areaFlag = retbpareas.getFieldValueString(i,"ESKD_SUPP_CUST_FLAG");
			areaDesc = retbpareas.getFieldValueString(i,"ESKD_SYS_KEY_DESC");
			areaDesc = areaDesc+ " ("+areaKey+")";
%>
			<Tr>
			<Td colspan="2" title = "<%=areaDesc%>">
				<input type="checkbox" name="CheckBox" value="<%=areaKey%>">
			<a href = "../Config/ezSetBusAreaDefaults.jsp?Area=<%=areaFlag%>&SystemKey=<%=retbpareas.getFieldValueString(i,"ESKD_SYS_KEY")%>">
			<input type = "text" value = "<%=areaDesc%>" size = "30" class = "DisplayBox" readonly Style = "Cursor:hand;text-decoration:underline">
			</a>

				<input type=hidden name=areaFlag value="<%=areaFlag%>">
			</Td>
			</Tr>
<%
		}
%>
		</Table>

<%
	}
	else
	{
%>
		<Table align=center border=1 bordercolorlight=#000000 bordercolordark=#ffffff cellspacing=0 cellpadding=2>>
		<Tr>
			<Td colspan="2">
			<font size="2" color="Red">
        			There are Areas for this Business Partner
        		</font>
        		</Td>
		</Tr>
		</Table>
<%
	}
%>
	</Td>
	</Tr>
	</Table>
	</div>
<%
	if ( retbpRows > 0)
	{
%>
  		<div id="ButtonDiv" align="center" style="position:absolute;top:92%;width:100%">
    			<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/continue.gif">
    			<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
    			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
	    	</div>
<%
	}
	else
   	{
%>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
<%
	}
%>
</form>
</body>
</html>
