<%@ include file="../../Library/Globals/errorPagePath.jsp"%>

<%@ include file="../../../Includes/JSPs/Partner/iBPSummary.jsp"%>

<html>
<head>
<Title>Business Partner Summary</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/Partner/ezBPSummary.js">
</script>
<% String browFlag = "IE"; %>
<script language="JavaScript">
function asBrow()
{
	if(navigator.appName=="Netscape")
	{
		<% browFlag = "NS"; %>
	}
	else
	{
		<% browFlag = "IE"; %>
	}
} //end asBrow
</script>

</head>
<body onLoad="asBrow()">

<%
String isIntranetBP = "";
if ( numBP > 0 )
{
	String addr1 = retbpinfo.getFieldValueString(0,"ECA_ADDR_1");
	if ( addr1.equals("null") )addr1="";
	String addr2 = retbpinfo.getFieldValueString(0,"ECA_ADDR_2");
	if ( addr2.equals("null") )addr2="";
	String state = retbpinfo.getFieldValueString(0,"ECA_STATE");
	String country = retbpinfo.getFieldValueString(0,"ECA_COUNTRY");
	String Zip = retbpinfo.getFieldValueString(0,"ECA_POSTAL_CODE");
%>
<br>

<form name=myForm method=post action="">
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  <Tr align="center">
    <Td class="displayheader" nowrap>Business
      Partner Summary</Td>
  </Tr>
</Table>

<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
    <Tr >
      <Td valign="top">
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="100%">
          <Tr>
            <Th colspan="2"><div align="center">
              Basic Business Partner Information</div>
            </Th>
          </Tr>
          <Tr>
            <Td width="49%" height="18" >Business
              Partner:</Td>
            <Td width="51%" height="18">
            <%@ include file="../../../Includes/Lib/ListBox/LBBusPartner.jsp"%>
            </Td>
          </Tr>
  <%
	String numUsers = retconfig.getFieldValueString(0,"EBPC_UNLIMITED_USERS");
	if ( numUsers.equals("Y") )
	{
		numUsers = "Unlimited Users";
	}
	else
	{
		numUsers = retconfig.getFieldValueString(0,"EBPC_NUMBER_OF_USERS");
	}

	isIntranetBP = retconfig.getFieldValueString(0,"EPBC_INTRANET_FLAG");
	if ( isIntranetBP.equals("Y"))
	{
		isIntranetBP = "Yes";
	}
	else
	{
		isIntranetBP = "No";
	}

%>
          <Tr >
            <Td width="49%" height="17">Max.
              No of Users:</Td>
            <Td width="51%" height="17"><%=numUsers%></Td>
          </Tr>
          <Tr valign="top" >
            <Td width="49%" nowrap height="17">Intranet
              Business Partner:</Td>
            <Td width="51%" height="17"><%=isIntranetBP%></Td>
          </Tr>
          <Tr >
            <Td width="49%" nowrap>Selected
              Catalog:</Td>
            <Td width="51%" nowrap><%= CatalogNumberDesc %>
            </Td>
          </Tr>
        </Table>
      </Td>
      <Td valign="top">
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="100%">
          <%
	if ( numBPUsers > 0 )
	{
%>
          <Tr >
            <Th colspan="2" nowrap><div align="center">
			Users Assigned to Business Partner</div>
            </Th>
          </Tr>
          <Tr >
            <Td width="49%" >User
              </Td>
            <Td width="51%" >Description
              </Td>
          </Tr>
<%
		for ( int i = 0; i < numBPUsers; i++)
		{
		   String isBuiltIn = retbpusers.getFieldValueString(i,"EU_IS_BUILT_IN_USER");
		   isBuiltIn = isBuiltIn.trim();

		   /**

		   	Venkat Commented the following if, to show all users on 7/20/2001

		   **/
		   String uId = retbpusers.getFieldValueString(i,"EU_ID");
		   String uName = retbpusers.getFieldValueString(i,"EU_FIRST_NAME");
		   uName += " "+retbpusers.getFieldValueString(i,"EU_LAST_NAME");
		   String userUrl = "";
		   if ( isIntranetBP.equals("Yes") )
		   {
				userUrl = "../User/ezChangeIntranetUserData.jsp?UserID="+uId+"&Show=Yes";
		   }
		   else
		   {
				userUrl = "../User/ezUserDetails.jsp?UserID="+uId;
		   }
%>
          <Tr >
            <Td width="49%" height="32"><a href="<%=userUrl%>"><%=uId %></a></Td>
            <Td width="51%" height="32"><%= uName %></Td>
          </Tr>
<%
		} //end for
%>
          <Tr >
            <Td colspan="2" height="32">
              <div align="center">
               <img   src="../../Images/Buttons/<%= ButtonDir%>/ViewUserAreas.gif" name="userarea"  onClick="UsersSummary()">
              </div>
            </Td>
          </Tr>
<%
	}
	else
	{
%>
          <Tr>
            <Th colspan="2" nowrap class="displayheader">No Users
              Assigned to Business Partner</Th>
          </Tr>
<%
	} //end numUsers
%>
        </Table>

      </Td>
    </Tr>
  </Table>
  </form>


<% /** Pasted from ezChangeBPSystems.jsp **/%>


<form method="post" action="" name="BPAreaSummary">
<%
	if ( browFlag.equals("IE") )
	{
%>
		<div id="bparea" style="position:absolute; visibility: visible;">
<%
	}
	else
	{
%>
		<layer visiblity=show>
<%
	}
%>
  <Table  width="90%" align="center">
    <Tr>
      <Td valign="top" align="left" width="100%" class="blankcell" colspan="2">
        <div align="center"></div>
          <Table  width="75%" align="center" bordercolor="#336699" border="1" cellpadding="0" cellspacing="0">
            <% if ( retRows > 0 ) { %>
            <Tr >
              <Th colspan="2" class="labelcell">
                <div align="center">Synchronizable
                  Areas</div>
              </Th>
            </Tr>
            <Tr >
              <Th>Systems
                </Th>
              <Th>Description
                </Th>
            </Tr>
            <% } %> <%
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
String isCatalogAreaSelected = "";
String CatalogSystemNo = retCatAreas.getFieldValueString(j,"ESKD_SYS_NO");
if ( retbpsys.find(BPP_KEY_VALUE,CatalogSystemNo) )
{
    isCatalogAreaSelected = "checked disabled";
}
else
{
    isCatalogAreaSelected = "";
}
%>
            <Tr >
              <Td>
                <input type="checkbox" name="<%= System %>" value="<%= retCatAreas.getFieldValueString(j,"ESKD_SYS_NO")%>" <%= isCatalogAreaSelected %> disabled>
                <%= SystemDesc %> </Td>
              <Td>&nbsp;</Td>
            </Tr>
            <%
} //end if
	for( int i=0; i<1; i++)
	{
      String catAreaDesc = retCatAreas.getFieldValueString(j,"ESKD_SYS_KEY_DESC");
	CheckBox = "CheckBox_"+i;
	%>
            <Tr >
              <Td>&nbsp;</Td>
              <Td>
                <input type="checkbox" name="<%= CheckBox %>" value="checkbox" checked disabled>
                <%= catAreaDesc %></Td>
            </Tr>
            <%
	}
	checkSystemDesc = SystemDesc;
}
%>
          </Table>

        <div align="center">

          <Table  width="75%" align="center" bordercolor="#336699" cellpadding="0" cellspacing="0" border="1">
            <Tr>
              <Th colspan="4" nowrap class="labelcell">
                <div align="center">Non
                    Synchronizable Areas</div>
                </Th>
              </Tr>

            <Tr>
              <Th width="40%" nowrap>Systems
                </Th>

              <Th width="38%" nowrap>
                Area Type</Th>

              <Th width="38%" nowrap>
                Description</Th>
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
String isOrgAreaSelected = "";
String OrgSystemNo = retOrgs.getFieldValueString(j,"ESKD_SYS_NO");
if ( retbpsys.find(BPP_KEY_VALUE,OrgSystemNo) )
{
    isOrgAreaSelected = "checked disabled";
}
else
{
	continue;
}

%>

            <Tr>
              <Td width="40%" nowrap>
                <input type="checkbox" name="<%= Area %>" value="<%= retOrgs.getFieldValueString(j,"ESKD_SYS_NO")%>" <%= isOrgAreaSelected %> disabled>
                  <%=OrgDesc%></Td>

              <Td width="38%">&nbsp;</Td>

              <Td>&nbsp;</Td>
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

	      if ( orgFlag.equals("C") ) {orgFlagDesc="Sales Area";}
	      else if ( orgFlag.equals("V") ) { orgFlagDesc="Purchase Area"; }
	      else if ( orgFlag.equals("S") ) { orgFlagDesc="Service Area"; }
	      else { orgFlagDesc="Service Area"; }

	      if ( (!orgFlag.equals(checkOrgFlag)) || (j == retOrgRows-1) )
	      {
        %>

            <Tr>
              <Td width="40%">&nbsp;</Td>

              <Td width="38%"> 
                <%=orgFlagDesc%></Td>

              <Td>&nbsp;</Td>
              </Tr>
              <%
	}
	%>

            <Tr>
              <Td width="40%">&nbsp;</Td>
                <Td width="38%">&nbsp;</Td>
                <Td width="38%">
                  <input type="hidden" name = "<%= AreaCheckBox+"_CHG" %>" value = "N" >
                  <input type="checkbox" name="<%= AreaCheckBox %>" value="<%= retOrgs.getFieldValueString(j,"ESKD_SYS_KEY") %>" <%= isOrgDescSelected %> onClick="CHG(this.name, <%=sysCount%>)" disabled>
                  <%=orgAreaDesc%>
                  <input type="hidden" name="<%= AreaCheckBoxFlag %>" value="<%= retOrgs.getFieldValueString(j,"ESKD_SUPP_CUST_FLAG")%>">
                </Td>
                <input type="hidden" name="<%= AreaCheckBox+"_VAL" %>" value="<%= retOrgs.getFieldValueString(j,"ESKD_SYS_KEY")%>">
              </Tr>
              <%
      checkOrgDesc = OrgDesc;
      checkOrgFlag = orgFlag;
}

/**
Keep the row count in hidden type for processing while saving this information
**/
            sysCount++; //Since sysCount starts with -1;
%>
		<input type="hidden" name="TotalCount" value=<%=sysCount%> >
		<input type="hidden" name="AreaCount" value=<%=retOrgRows%> >

            </Table>
          <br>
        </div>
      </Td>
    </Tr>
  </Table>

<% /** Paste ends here **/ %>
<%
	if ( browFlag.equals("IE") )
	{
%>
		</div>
<%
	}
	else
	{
%>
		</layer>
<%
	}
%>
</form>
<form method="post" action="" name="BPUserSummary">
<%
	if ( browFlag.equals("IE") )
	{
%>
		<div id="bpuser" style="position:absolute; visibility: hidden;" >
<%
	}
	else
	{
%>
		<layer visiblity=hide>
<%
	}
%>
<%
if ( !isIntranetBP.equals("Yes") )
{
%>
      <Table  width="90%" align="center" bordercolor="#336699" border="1" cellpadding="0" cellspacing="0">
	     	<Tr >
              <Th colspan="3" nowrap class="labelcell">
                <div align="center">Business User
                   Areas</div>
              </Th>
            </Tr>
            <Tr >
              <Td width="40%">User
                </Td>
              <Td width="38%">Area</Td>
              <Td width="38%">Customer
                </Td>
            </Tr>
<%
	for( int j = 0; j < numBPUsers; j++)
	{
		ReturnObjFromRetrieve retS = (ReturnObjFromRetrieve)retSoldTo[j];
		int soldLen = retS.getRowCount();
		String chgUid = "";
		String chgUArea = "";
		for ( int i = 0; i < soldLen; i++)
		{
		   	String isBuiltIn = retbpusers.getFieldValueString(j,"EU_IS_BUILT_IN_USER");
		   	isBuiltIn = isBuiltIn.trim();
		   	if ( isBuiltIn.equals("N") )continue;

			// Erp Customer Number
			String uId = retbpusers.getFieldValueString(j,"EU_ID" );
			String erp_cust_no = retS.getFieldValueString(i,"ECA_NO");
			String userArea = retS.getFieldValueString("EUD_SYS_KEY");
			String ezc_cust_no = retS.getFieldValueString(i,"EC_NO"); // TBD : We need to think about it
			if ( !chgUid.equals(uId) )
			{
%>
				<Tr>
				<Td width="40%">
		      	<B><%=uId%></B>
				</Td>
				<Td width="38%">&nbsp;
				</Td>
				<Td width="38%">&nbsp;
				</Td>
				</Tr>
<%
			}
			if ( !chgUArea.equals(userArea) )
			{
%>
				<Tr>
				<Td width="40%">&nbsp;
				</Td>
				<Td nowrap width="38%">
		      	<B><%=userArea%></B>
				</Td>
				<Td width="38%">&nbsp;
				</Td>
				</Tr>
<%
			}
%>
			<Tr>
			<Td width="40%">&nbsp;
			</Td>
			<Td width="38%">&nbsp;
			</Td>
			<Td nowrap width="38%">
		      <%=retS.getFieldValueString(i,ERP_CUST_NAME)%>(<%=erp_cust_no%>)
		     </Td>
			</Tr>
<%
			chgUid = uId;
			chgUArea = userArea;
		}
	}
%>
</Table>
<%
}
else
{
%>
      <Table  width="90%" align="center" bordercolor="#336699" border="1" cellpadding="0" cellspacing="0">
      	<Tr >
              <Th colspan="3" nowrap class="labelcell">
                <div align="center">Intranet User
                   Areas</div>
              </Th>
            </Tr>
            <Tr>
              <Td width="40%">User ID
                </Td>
              <Td width="38%">Area</Td>
              <Td width="38%">Customer
                </Td>
            </Tr>
<%

	for( int j = 0; j < numBPUsers; j++)
	{
		ReturnObjFromRetrieve retUA = (ReturnObjFromRetrieve)retUserAreas[j];
		int usLen = retUA.getRowCount();
		String chgUid = "";
		String chgUArea = "";
		for ( int i = 0; i < usLen; i++)
		{
			// Erp Customer Number
			String uId = retbpusers.getFieldValueString(j,"EU_ID" );
			//String erp_cust_no = retS.getFieldValueString(i,"EC_ERP_CUST_NO");
			String erp_cust_no = retUA.getFieldValueString(i,"ECA_NO");
			String userArea = retUA.getFieldValueString(i,"ESKD_SYS_KEY_DESC");
			String ezc_cust_no = retUA.getFieldValueString(i,"EC_NO"); // TBD : We need to think about it
			if ( !chgUid.equals(uId) )
			{
%>
				<Tr>
				<Td width="40%">
		      	<B><%=uId%></B>
				</Td>
				<Td width="38%">&nbsp;
				</Td>
				<Td width="38%">&nbsp;
				</Td>
				</Tr>
<%
			}
			if ( !chgUArea.equals(userArea) )
			{
%>
				<Tr>
				<Td width="40%">&nbsp;
				</Td>
				<Td nowrap width="38%">
		      	<B><%=userArea%></B>
				</Td>
				<Td width="38%">&nbsp;
				</Td>
				</Tr>
<%
			}
%>
			<Tr>
			<Td width="40%">&nbsp;
			</Td>
			<Td width="38%">&nbsp;
			</Td>
			<Td nowrap width="38%">
		      <%=(retUA.getFieldValueString(i,"ESKD_SYS_KEY_DESC") )%>
		     	</Td>
			</Tr>
<%
			chgUid = uId;
			chgUArea = userArea;
		}
	}
%>
</Table>
<%
} //end if isIntranetBP
%>
<%
	if ( browFlag.equals("IE") )
	{
%>
		</div>
<%
	}
	else
	{
%>
		</layer>
<%
	}
%>
<%
}
else
{
%>
<Table  width="50%" border="0" align="center">
  <Tr align="center">
    <Td class="displayheader" nowrap>No Business Partners To Display</Td>
  </Tr>
</Table>
<%
} //end numBP
%>

</form>
</body>
</html>

