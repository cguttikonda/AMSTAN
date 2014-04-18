<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iBPEzcAuthList.jsp"%>

<html>
<head>
<script src="../../Library/JavaScript/Partner/ezBPEzcAuthList.js">
</script>

<Script src="../../Library/JavaScript/ezTabScroll.js"></script>


<Title>Business Partner Authorizations</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
</head>
<%
		String language = "EN";
		EzcSysConfigParams sparams1 = new EzcSysConfigParams();
		EzcSysConfigNKParams snkparams1 = new EzcSysConfigNKParams();
		snkparams1.setLanguage(language);
		sparams1.setObject(snkparams1);
		Session.prepareParams(sparams1);
		retauth = (ReturnObjFromRetrieve)sysManager.getMasterAuthDesc(sparams1);
		retauth.check();
		
		for(int k=retauth.getRowCount()-1;k>=0;k--)
		{
						
			if ( showRoles && !retRoles.find("ROLE_NR",retauth.getFieldValueString(k,"EUAD_AUTH_KEY").trim()) )
			{
					retauth.deleteRow(k);
			}
		}
		
		

		int authRows = retauth.getRowCount();
		String[] sortArr = { "EUAD_AUTH_DESC" };
		retauth.sort( sortArr, true );

		EzcBussPartnerParams bparams2 = new EzcBussPartnerParams();
		bparams2.setBussPartner(Bus_Partner);
		EzcBussPartnerNKParams bnkparams2 = new EzcBussPartnerNKParams();
		bnkparams2.setLanguage("EN");
		bparams2.setObject(bnkparams2);
		Session.prepareParams(bparams2);
		retbpauth = (ReturnObjFromRetrieve)BPManager.getBussPartnerMasterAuth(bparams2);
		retbpauth.check();

%>

<body onLoad='scrollInit()'  onRsesize='scrollInit()' scroll="no">

<br>

<form name=myForm method=post action="ezSaveBPEzcAuthList.jsp">
  <Table  border="1" align="center" width="45%">
    <Tr>
      <Th width="48%" class="labelcell">
        <div align="right">Business Partner:</div>
      </Th>
      <Td width="52%" class="blankcell">
      	<%@ include file="../../../Includes/Lib/ListBox/LBBusPartner.jsp"%>
      </Td>
    </Tr>
  </Table>
  <br>
  <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  <Tr align="center">
    <Td class="displayheader">Update Partner Authorizations</Td>
  </Tr>
</Table>
  <div id="theads">
<Table  id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
    <Tr>
      <Th width="70%" >The following authorizations are independent of system.
        <br>
        For a list of system dependant authorizations

			<a class = "subclass" href="ezBPAuthList.jsp?BusinessPartner=<%=Bus_Partner%>" >
        		Click Here
			</a>

      </Th>
    </Tr>
    <Tr align="left">
         <Th width="70%" class="labelcell" >
          <div align="center">List Of System Independent Authorizations</div>
        </Th>
    </Tr>
    </Table>
    </div>

<DIV id="InnerBox1Div">
<Table id="InnerBox1Tab" align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="100%">

<%

boolean showFlag = false;
int sysRows = 1;
String sysNum = null;
String sysDesc = null;
if ( sysRows > 0 )
{
	for ( int i = 0 ; i < sysRows; i++ )
	{
%>
    <Tr>
      <Td>
        <Table  width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%

		if ( authRows > 0 )
		{
			showFlag = true;
			for ( int j = 0 ; j < authRows ; j++ )
			{

				String master_key = ((String)retauth.getFieldValue(j,"EUAD_AUTH_KEY")).trim();
%>
          <Tr align="center" >
            <Td align="center">
<%

				if (retbpauth != null  && retbpauth.find(BP_AUTH_KEY, master_key))
				{
%>
	      				<input type="checkbox" name="Check_<%=i%>_<%=j%>" value="Selected" checked>
	      				<input type="hidden" name="Stat_<%=i%>_<%=j%>" value="Y" >
<%
				}
				else
				{
%>
	      				<input type="checkbox" name="Check_<%=i%>_<%=j%>" value="Selected" unchecked>
<%
				}
%>
	</Td>
                  <Td align="left">
	      	<%=(retauth.getFieldValue(j,"EUAD_AUTH_DESC"))%>
			<input type="hidden" name="AuthKey_<%=i%>_<%=j%>" value=<%=master_key%> >
			<input type="hidden" name="AuthDesc_<%=i%>_<%=j%>" value=<%=(retauth.getFieldValue(j,"EUAD_AUTH_DESC"))%> >
			<input type="hidden" name="AuthCount_<%=i%>" value=<%=authRows%> >


 		</Td>
           </Tr>
<%
			}//End for

			// Row for hidden fields
%>

        </Table>
 <%
		}//End If
 %>
 	</Td>
    </Tr>
<%
	}//End for
%>
		<input type="hidden" name="TotalCount" value=<%=sysRows%> >

<%
	if ( showFlag )
	{
%>
  </Table>
  </div>



  <br>
  <div ID="ButtonDiv" align=center style="position:absolute;top:90%;width:100%">
  <Table  width="30%" border="0" align="center">
    <Tr align="center">
      <Td class="blankcell">
       		<img src="../../Images/Buttons/<%= ButtonDir%>/selectall.gif" onClick=setChecked(1) style="cursor:hand">
      </Td>
      <Td class="blankcell">
       		<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/update.gif" value="Update" style="cursor:hand">
      </Td>
      <Td class="blankcell">
        	<img src="../../Images/Buttons/<%= ButtonDir%>/clearall.gif" onClick=setChecked(0) style="cursor:hand">
      </Td>
    </Tr>
  </Table>
  </div>
<%
	}
	else
	{
%>
	<div align="center">No Authorizations available</div>
<%
	} //end if
}//End If
%>
</form>
<%
	String saved = request.getParameter("saved");
	if ( saved != null && saved.equals("Y") )
	{
%>
		<script language="JavaScript">
			alert('System independent Authorization(s) updated successfully');
		</script>
<%
	} //end if
%>

</body>
</html>
