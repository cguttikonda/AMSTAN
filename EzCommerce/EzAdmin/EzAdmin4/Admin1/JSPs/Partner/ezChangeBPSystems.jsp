<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iChangeBPSystems.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<html>
<head>
	<script src="../../Library/JavaScript/Partner/ezChangeBPSystems.js"></script>
	<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
	<Title>Add Business Partner Systems</Title>
</head>
<body  onLoad='scrollInit()' onResize='scrollInit()' scroll="no">
<form name=myForm method=post action="ezSaveChangeBPSystems.jsp">
<%
if ( numBP == 0 )
{
%>
	<br><br><br><br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="99%">
  	<Tr align="center">
    		<Td class="displayheader">There are No Business Partners  </Td>
  	</Tr>
	</Table>
<%
	return;
}
%>
	<br>
	<div id="theads">
	<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="99%">
		<Tr align="center">
	    		<Td class="displayheader">Change Systems for Partner</Td>
  		</Tr>
	</Table>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
    	<Tr>
      	<Th width="20%" class="labelcell">
	        <div align="right">Business Partner:</div>
      	</Th>
      	<Td width="30%" >
	      <a href = "../Partner/ezBPSummaryBySysKey.jsp?WebSysKey=<%=websyskey%>&Area=<%=Area1%>&BusinessPartner=<%=Bus_Partner%>"><%=BPDesc%></a>
      	</Td>
      	<Th width="20%" class="labelcell" nowrap>
        	<div align="right">Catalog:</div>
      	</Th>


	<Td width="30%" nowrap>

<%
				if ( CatalogNumber.equals("0") )
				{
					CatalogNumberDesc = "No Catalogs Selected";
%>

					<%=CatalogNumberDesc%>
<%
				}
				else
				{
%>
					<a href = "../Catalog/ezShowCatalog.jsp?CatNumber=<%=CatalogNumber%>&catDesc=<%=CatalogNumberDesc%>"><%=CatalogNumberDesc%></a>
<%
				}
%>

      	</Td>
    	</Tr>
  	</Table>
	</div>
	<DIV id="InnerBox1Div">
<% 	if(retRows>0)
	{
%>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="99%">
        	<Tr>
        	<Th colspan="2" class="labelcell">
              		Synchronizable Areas
		</Th>
		</Tr>
        	<Tr>
        		<Th width="30%">Systems</Th>
	        	<Th width="70%"><b>Description</b></Th>
	        </Tr>
       		</Table>
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
	if(retRows >0)
	{
%>
		<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="99%">
<%
		for( int j = 0; j < retRows; j++)
		{
			String SystemDesc = "System - "+retCatAreas.getFieldValueString(j,"ESKD_SYS_NO");
			if(!SystemDesc.equals(checkSystemDesc))
			{
				sysCount++;
				System = "ChkSys_"+sysCount;
				String isCatalogAreaSelected = "";
				String CatalogSystemNo = retCatAreas.getFieldValueString(j,"ESKD_SYS_NO");
				if(retbpsys.find(BPP_KEY_VALUE,CatalogSystemNo))
				{
    					isCatalogAreaSelected = "checked disabled";
				}
				else
				{
    					isCatalogAreaSelected = "";
				}
%>
          			<Tr>
				<label for="cb_<%=j%>">
		          		<Td width="30%" >
            				<input type="checkbox" name="<%= System %>" id="cb_<%=j%>" value="<%= retCatAreas.getFieldValueString(j,"ESKD_SYS_NO")%>" <%= isCatalogAreaSelected %>>
              				<%= SystemDesc %>
             				</Td>
          				<Td width="70%" >&nbsp;</Td>
				</label>
          			</Tr>
<%
			} //end if
			for( int i=0; i<1; i++)
			{
				String catAreaDesc = retCatAreas.getFieldValueString(j,"ESKD_SYS_KEY_DESC");
				CheckBox = "CheckBox_"+i;
%>
          			<Tr>
          			<Td width="30%" >&nbsp;</Td>
          			<Td width="70%" >


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
}
if ( retOrgRows > 0 )
{
%>
      	<Table  id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="99%">
        <Tr>
		<Th colspan="4" nowrap class="labelcell">
               		Non Synchronizable Areas
              	</Th>
       	</Tr>
        <Tr>
        <Th width="20%" nowrap>
		Systems
	</Th>
        <Th width="20%" nowrap>Area</Th>
        <Th width="60%" nowrap>Description</Th>
        </Tr>
<%
	String checkOrgDesc = retOrgs.getFieldValueString(0,"ESKD_SYS_NO");
	String checkOrgFlag = "";
	for ( int j = 0; j < retOrgRows; j++ )
	{
		String OrgDesc = "System - "+retOrgs.getFieldValueString(j,"ESKD_SYS_NO");
		if ( !OrgDesc.equals(checkOrgDesc) )
		{
			sysCount++;
			Area = "ChkSys_"+sysCount;
			checkOrgFlag = "";
			String isOrgAreaSelected = "";
			String OrgSystemNo = retOrgs.getFieldValueString(j,"ESKD_SYS_NO");
			if ( retbpsys.find(BPP_KEY_VALUE,OrgSystemNo) )
			{
    				isOrgAreaSelected = "checked disabled";
			}
			else
			{
    				isOrgAreaSelected = "";
			}
%>
            		<Tr>
            		<label for="cb_<%=j%>">
              		<Td width="20%">
                		<input type="checkbox" name="<%= Area %>" id="cb_<%=j%>" value="<%= retOrgs.getFieldValueString(j,"ESKD_SYS_NO")%>" <%= isOrgAreaSelected %>>
                		<%=OrgDesc%>
			</Td>
              		<Td width="15%">&nbsp;</Td>
              		<Td width="45%">&nbsp;</Td>
			</label>
            		</Tr>
<%
		} //end if
	      	String orgAreaDesc = retOrgs.getFieldValueString(j,"ESKD_SYS_KEY_DESC");
            	String actAreaDesc = retOrgs.getFieldValueString(j,"ESKD_SYS_KEY");
	      	String orgFlag = retOrgs.getFieldValueString(j,"ESKD_SUPP_CUST_FLAG");
      		String orgFlagDesc = "";
		AreaCheckBox = "OrgArea_"+j;
            	AreaCheckBoxFlag = "OrgAreaFlag_"+j;
            	String isOrgDescSelected = "";
		if ( retbpareas.find("ESKD_SYS_KEY",actAreaDesc) )
		{
		    	isOrgDescSelected = "checked";
		}
		else
		{
			isOrgDescSelected = "";
		}

	      	if ( orgFlag.equals("C") )
		{
			orgFlagDesc="Sales Area";
		}
	      	else if ( orgFlag.equals("V") )
		{
			orgFlagDesc="Purchase Area";
		}
	      	else if ( orgFlag.equals("S") )
		{
			orgFlagDesc="Service Area";
		}
	      	else
		{
			orgFlagDesc="Service Area";
		}
	      	if ( (!orgFlag.equals(checkOrgFlag)) )
	      	{
%>
            		<Tr>
              		<Td width="20%">&nbsp;</Td>
              		<Td nowrap width="20%"><%=orgFlagDesc%></Td>
              		<Td width="60%">&nbsp;</Td>
            		</Tr>
<%
		}
%>
		<Tr>
		<label for="cb_<%=j%>">
              	<Td width="20%">&nbsp;</Td>
              	<Td width="20%">&nbsp;</Td>
              	<Td nowrap width="60%">
		   	<input type="hidden" name = "<%= AreaCheckBox+"_CHG" %>" value = "N" >
                	<input type="checkbox" name="<%= AreaCheckBox %>" id="cb_<%=j%>" value="<%= retOrgs.getFieldValueString(j,"ESKD_SYS_KEY") %>" <%= isOrgDescSelected %> onClick="CHG(this.name, <%=sysCount%>)">
                	<a href= "../Config/ezSetBusAreaDefaults.jsp?Area=V&SystemKey=<%=actAreaDesc%>"><%=orgAreaDesc%> (<%=actAreaDesc%>)&nbsp;</a>
                	<input type="hidden" name="<%= AreaCheckBoxFlag %>" value="<%= retOrgs.getFieldValueString(j,"ESKD_SUPP_CUST_FLAG")%>">
                	<input type="hidden" name="<%= AreaCheckBox+"_VAL" %>" value="<%= retOrgs.getFieldValueString(j,"ESKD_SYS_KEY")%>">
              	</Td>

		</label>
            	</Tr>
<%
      		checkOrgDesc = OrgDesc;
      		checkOrgFlag = orgFlag;
	}
	/**Keep the row count in hidden type for processing while saving this information**/
        sysCount++; //Since sysCount starts with -1;
%>
	<input type="hidden" name="TotalCount" value=<%=sysCount%> >
	<input type="hidden" name="AreaCount" value=<%=retOrgRows%> >
       	</Table>
<%
} //end if ( retOrgRows > 0 )
%>
	</div>
   	<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
<%
	if(retOrgRows > 0)
	{
%>
    		<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/save.gif" onClick="checkAll();return document.returnValue;" style="cursor:hand">
<%
   	}
%>
    		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
	</div>
      	</Td>
    	</Tr>
  	</Table>
  	<input type="hidden" name="BusPartner" value=<%=Bus_Partner%> >
 	<input type="hidden" name="Area" value=<%=Area1%> >
	<input type="hidden" name="WebSysKey" value=<%=websyskey%> >
</form>
<%
	String saved = request.getParameter("saved");
	if ( saved != null && saved.equals("Y") )
	{
%>
		<script language="JavaScript">
			alert('Partner Systems updated successfully');
		</script>
<%
	} //end if
%>
</body>
</html>
