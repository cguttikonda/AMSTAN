
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iAddBPSystems.jsp"%>

<html>
<head>
	<Title>Add Business Partner Systems</Title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
</head>
<body bgcolor="#FFFFF7" onLoad="scrollInit()" onResize = "scrollInit()" scroll="no">
<script src="../../Library/JavaScript/Partner/ezAddBPSystems.js">
</script>
<script src="../../Library/JavaScript/ezTabScroll.js"></script>

<%
if(retOrgRows==0 && retRows==0)
{

%>

<br><br><br><br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
	<Tr>
		<Td class = "displayheader">
			<div align="center">No Areas To add Partners.</div>
		</Td>
	</Tr>
</Table>
<br>
<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>
<%
return;
}
%>
<form name=myForm method=post action="ezSaveBPInfo.jsp">
<br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
  <Tr align="center">
    <Td class="displayheader">Select Systems for the Partner</Td>
  </Tr>
</Table>

<div id="theads"></div>
<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
   <Tr>
      <Td width="41%" class="labelcell" align="right" nowrap>Selected Catalog:</Td>

        	
            	<Td>
<%
		if ( CatalogNumber.equals("0") )
		{
			CatalogNumberDesc = "No Catalogs Selected";
%>

				<%= CatalogNumberDesc %>
<%
		}
		else
		{
%>
<Td width="59%" class="blankcell" nowrap><a href = "../Catalog/ezShowCatalog.jsp?CatNumber=<%=CatalogNumber%>&catDesc=<%=CatalogNumberDesc%>"><%=CatalogNumberDesc%></a>

<%
		}
%>


      </Td>
    </Tr>
  </Table>



<div id="InnerBox1Div">
 <Table id="InnerBox1Tab" border=0 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
    <Tr>
      <Td valign="top" align="left" width="100%" class="blankcell" colspan="2">
<%
	if ( retRows > 0 )
	{
%>

        <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="100%">

          <Tr>
            <Th colspan="2" class="labelcell">
              <div align="center">Synchronizable
                Areas</div>
            </Th>
          </Tr>
          <Tr>
            <Th>Systems
              </Th>
            <Th><b>Description</b></Th>
          </Tr>
<%
	}
%>

<%
String Area = null;
String AreaCheckBoxFlag = null;
String AreaCheckBox = null;
String System = null;
String CheckBox = null;
String checkSystemDesc = "";
int sysCount = -1;
for( int j = 0; j < retRows; j++)
{
String SystemDesc = "System - "+retCatAreas.getFieldValueString(j,"ESKD_SYS_NO");
if ( !SystemDesc.equals(checkSystemDesc) )
{
sysCount++;
System = "ChkSys_"+sysCount;

%>
          <Tr>
            <Td>
              <input type="checkbox" name="<%= System %>" value="<%= retCatAreas.getFieldValueString(j,"ESKD_SYS_NO")%>" onClick="selectSystems(this.value,<%=sysCount%>)">

              <b><%= SystemDesc %></b></Td>
            <Td>&nbsp;</Td>
          </Tr>
          <%
} //end if
	for( int i=0; i<1; i++)
	{
      String catAreaDesc = retCatAreas.getFieldValueString(j,"ESKD_SYS_KEY_DESC");
	CheckBox = "CheckBox_"+i;
	%>
          <Tr>
            <Td>&nbsp;</Td>
            <Td>
              <input type="checkbox" name="<%= CheckBox %>" value="checkbox" checked disabled>
<a href= "../Config/ezSetBusAreaDefaults.jsp?Area=C&SystemKey=<%=retCatAreas.getFieldValueString(j,"ESKD_SYS_KEY")%>"><%= catAreaDesc %> (<%= retCatAreas.getFieldValueString(j,"ESKD_SYS_KEY")%>)&nbsp;</a>

              </Td>
          </Tr>
          <%
	}
      checkSystemDesc = SystemDesc;
}

%>
        </Table>

<%
	if(retOrgRows > 0)
	{
%>

          <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="100%">
            <Tr>
              <Th colspan="3" nowrap class="labelcell">
                <div align="center">Non
                  Synchronizable Areas</div>
              </Th>
            </Tr>
            <Tr>
              <Th width="40%" nowrap><b>Systems
                </Th>
              <Th width="15%" nowrap>Area Type</Th>
              <Th width="45%" nowrap>
                Description</Th>
            </Tr>
<%
	int k=0;
	String checkOrgDesc = retOrgs.getFieldValueString(0,"ESKD_SYS_NO");
	String checkOrgFlag = "";
	for ( int j = 0; j < retOrgRows; j++ )
	{
		String OrgDesc = "System - "+retOrgs.getFieldValueString(j,"ESKD_SYS_NO");
		if ( !OrgDesc.equals(checkOrgDesc) )
		{
			sysCount++;
			checkOrgFlag="";
			Area = "ChkSys_"+sysCount;

%>
	    <Tr>

	      <label for="cb_<%=k%>">
	      <Td width="40%">
                <input type="checkbox" id="cb_<%=k%>" name="<%= Area %>" value="<%= retOrgs.getFieldValueString(j,"ESKD_SYS_NO")%>">

				
                <%=OrgDesc%></Td>
              <Td width="15%">&nbsp;</Td>
              <Td width="45%">&nbsp;</Td>
	   
	    </Tr>
<%
		} //end if
	      String orgAreaDesc = retOrgs.getFieldValueString(j,"ESKD_SYS_KEY_DESC");
	      String orgFlag = retOrgs.getFieldValueString(j,"ESKD_SUPP_CUST_FLAG");
	      String orgFlagDesc = "";
		AreaCheckBox = "OrgArea_"+j;
	      AreaCheckBoxFlag = "OrgAreaFlag_"+j;

	      if ( orgFlag.equals("C") ) {orgFlagDesc="Sales Area";}
	      else if ( orgFlag.equals("V") ) { orgFlagDesc="Purchase Area"; }
	      else if ( orgFlag.equals("S") ) { orgFlagDesc="Service Area"; }
	      else { orgFlagDesc="Service Area"; }

	      if ( !orgFlag.equals(checkOrgFlag) )
	      {
%>
            <Tr>
              <Td width="40%">&nbsp;</Td>
              <Td nowrap width="15%">
				
				<%=orgFlagDesc%></Td>
              <Td width="45%">&nbsp;</Td>

	    </Tr>
<%
	    }

%>
            <Tr>

	     <Td width="40%">&nbsp;</Td>
              <Td width="15%">&nbsp;</Td>
              <Td nowrap width="45%">
                <input type="checkbox" id="cb_<%=k%>" name="<%= AreaCheckBox %>" value="<%= retOrgs.getFieldValueString(j,"ESKD_SYS_KEY") %>" onClick="checkAreaBox(<%=sysCount%>)">
<a href= "../Config/ezSetBusAreaDefaults.jsp?Area=V&SystemKey=<%=retOrgs.getFieldValueString(j,"ESKD_SYS_KEY")%>"><%= orgAreaDesc %> (<%= retOrgs.getFieldValueString(j,"ESKD_SYS_KEY")%>)&nbsp;</a>

                <input type="hidden" name="<%= AreaCheckBoxFlag %>" value="<%= orgFlag %>">
              </Td>
	    </label>
	    </Tr>
            <%
      checkOrgDesc = OrgDesc;
      checkOrgFlag = orgFlag;

    }
 %>
</Table>
 <%
 }

/**
Keep the row count in hidden type for processing while saving this information
**/
            sysCount++; //Since sysCount starts with -1;


%>
</Table>
</div>

<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
         <input type="image" name="org"src="../../Images/Buttons/<%= ButtonDir%>/add.gif" onClick="checkAll();return document.returnValue;">
          <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</div>


<!--  put all the variables from iAddBPSystems.jsp as hidden parameters -->
	<input type="hidden" name="TotalCount" value=<%=sysCount%> >
	<input type="hidden" name="AreaCount" value=<%=retOrgRows%> >
	<input type="hidden" name="CatalogNumber" value="<%=CatalogNumber%>">
	<input type="hidden" name="Company" value="<%=Company%>">
	<input type="hidden" name="BPDescription" value="<%=BPDescription%>">
	<input type="hidden" name="ContactName" value="<%=ContactName%>">
	<input type="hidden" name="Email" value="<%=Email%>">
	<input type="hidden" name="WebAddress" value="<%=WebAddress%>">
	<input type="hidden" name="Address1" value="<%=Address1%>">
	<input type="hidden" name="Address2" value="<%=Address2%>">
	<input type="hidden" name="City" value="<%=City%>">
	<input type="hidden" name="State" value="<%=State%>">
	<input type="hidden" name="Zip" value="<%=Zip%>">
	<input type="hidden" name="Country" value="<%=Country%>">
	<input type="hidden" name="Phone11" value="<%=Phone11%>">
	<input type="hidden" name="Phone12" value="<%=Phone12%>">
	<input type="hidden" name="Phone13" value="<%=Phone13%>">
	<input type="hidden" name="Phone21" value="<%=Phone21%>">
	<input type="hidden" name="Phone22" value="<%=Phone22%>">
	<input type="hidden" name="Phone23" value="<%=Phone23%>">
	<input type="hidden" name="Fax1" value="<%=Fax1%>">
	<input type="hidden" name="Fax2" value="<%=Fax2%>">
	<input type="hidden" name="Fax3" value="<%=Fax3%>">
	<input type="hidden" name="UnlimitedUsers" value="<%=UnlimitedUsers%>">
	<input type="hidden" name="NumUsers" value="<%=NumUsers%>">
	<input type="hidden" name="busintuser" value="<%=busIntUser%>">

        

      </Td>
    </Tr>
  
</form>
</body>
</html>
