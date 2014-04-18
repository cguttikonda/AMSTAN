<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iListBPBySysKey.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iBPEzcAuthListBySysKey.jsp"%>
<%
int authRows=0;
if(Bus_Partner!=null && !"sel".equals(Bus_Partner))
{
		String language = "EN";
		EzcSysConfigParams sparams1 = new EzcSysConfigParams();
		EzcSysConfigNKParams snkparams1 = new EzcSysConfigNKParams();
		snkparams1.setLanguage(language);
		sparams1.setObject(snkparams1);
		Session.prepareParams(sparams1);

		//retauth = ezc.getMasterAuthDesc(language);
		retauth = (ReturnObjFromRetrieve)sysManager.getMasterAuthDesc(sparams1);
		retauth.check();
		for(int k=retauth.getRowCount()-1;k>=0;k--)
		{

			if ( showRoles && !retRoles.find("ROLE_NR",retauth.getFieldValueString(k,"EUAD_AUTH_KEY").trim()) )
			{
					retauth.deleteRow(k);
			}
		}

		authRows = retauth.getRowCount();
		String[] sortArrEzc = { "EUAD_AUTH_DESC" };
		retauth.sort( sortArrEzc, true );

		EzcBussPartnerParams bparams2 = new EzcBussPartnerParams();
		bparams2.setBussPartner(Bus_Partner);
		EzcBussPartnerNKParams bnkparams2 = new EzcBussPartnerNKParams();
		bnkparams2.setLanguage("EN");
		bparams2.setObject(bnkparams2);
		Session.prepareParams(bparams2);
		retbpauth = (ReturnObjFromRetrieve)BPManager.getBussPartnerMasterAuth(bparams2);
		retbpauth.check();
}

%>

<html>
<head>
<script src="../../Library/JavaScript/Partner/ezBPEzcAuthListBySysKey.js"></script>

<Script src="../../Library/JavaScript/ezTabScroll.js"></script>


<Title>Business Partner Authorizations</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body onLoad='scrollInit()' onResize='scrollInit()' scroll="no">


<form name=myForm method=post action="ezSaveBPEzcAuthListBySysKey.jsp">
<br>
			  <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
				  <Tr align="center">
				    <Td class="displayheader">Update Partner Authorizations</Td>
				  </Tr>
				</Table>

<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<Tr align="center">
	<Th width="16%" align="right"><%=areaLabel.substring(0,areaLabel.length()-1)%>&nbsp;:</Th>
	<Td width="40%" align="left">

	<%
		String wsk=null;
		for(int i=0;i<ret.getRowCount();i++)
		{
			if(websyskey.equals(ret.getFieldValue(i,SYSTEM_KEY)))
			{
				 wsk=ret.getFieldValueString(i,SYSTEM_KEY_DESCRIPTION);
				 break;
			}
		}

	%>
		<a href= "../Config/ezSetBusAreaDefaults.jsp?Area=<%=areaFlag%>&SystemKey=<%=websyskey%>"><%= wsk %> (<%=websyskey%>)&nbsp;</a>

</Td>


      <Th width="18%" align="right">Business Partner:</Th>
      <Td width="26%" align="left">
 <%
		String buspar=null;
		for(int i=0;i<ret1.getRowCount();i++)
		{
			if(Bus_Partner.equals(ret1.getFieldValueString(i,"EBPC_BUSS_PARTNER")))
			{
				 buspar=ret1.getFieldValueString(i,"ECA_COMPANY_NAME");
				 break;
			}
		}
%>
		<a href = "../Partner/ezBPSummaryBySysKey.jsp?WebSysKey=<%=websyskey%>&Area=<%=areaFlag%>&BusinessPartner=<%=Bus_Partner%>"><%=buspar%></a>

      </Td>
    </Tr>
</Table>

  <%

  			if(ret1.getRowCount()==0)
  			{
  %>

  				<input type="hidden" name="Area" value="<%=areaFlag%>">
  				<input type ="hidden" name="flag" value="1">
  				<center>No Partners Present Under This <%=areaLabel.substring(0,areaLabel.length()-1)%></center>
  <% 			return;
  			}
%>

<%
			if(numBP > 0)
			{

%>


	<Table   border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width = "89%">
	    <Tr align="left">
	         <Th width="70%" class="labelcell" >
	          <div align="center">List Of System Independent Authorizations</div>
	        </Th>
	    </Tr>
	    </Table>
	<div id="theads">
	<Table id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
	<Tr align="center">
	<Th width="5%" title="Select/Deselect All"><input type='checkbox' name='chk1Main' onClick="selectAll()"></Th>
      	<Th width="95%" align = "center" class="labelcell" >Authorizations</Th>
    	</Tr>
	</Table>
	</div>
	<DIV id="InnerBox1Div">
	<Table id="InnerBox1Tab" border=0 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>

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
        <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="100%">
<%

		if ( authRows > 0 )
		{
			showFlag = true;
			for ( int j = 0 ; j < authRows ; j++ )
			{

				String master_key = ((String)retauth.getFieldValue(j,"EUAD_AUTH_KEY")).trim();
%>
          <Tr align="center" >
	  <label for="cb_<%=j%>">
            <Td align="center" width = "5%">
<%

				if (retbpauth != null  && retbpauth.find(BP_AUTH_KEY, master_key))
				{
%>
	      				<input type="checkbox" name="CheckBox" id="cb_<%=j%>" value="<%=master_key%>#<%=(retauth.getFieldValue(j,"EUAD_AUTH_DESC"))%>" checked>
	      				<input type="hidden" name="AuthKey" value="<%=master_key%>#<%=(retauth.getFieldValue(j,"EUAD_AUTH_DESC"))%>" >

<%
				}
				else
				{
%>
	      				<input type="checkbox" name="CheckBox" id="cb_<%=j%>" value="<%=master_key%>#<%=(retauth.getFieldValue(j,"EUAD_AUTH_DESC"))%>" unchecked>
<%
				}
%>
	</Td>
                  <Td align="left">
	      	<%=retauth.getFieldValue(j,"EUAD_AUTH_DESC")%>





 		</Td>
		</label>
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




  
  <div id="ButtonDiv" align=center style="position:absolute;top:90%;width:100%">
   		<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/update.gif" value="Update" style="cursor:hand">  				  	     
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
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
}

%>

<%
	String saved = request.getParameter("saved");
	if ( saved != null && saved.equals("Y") )
	{
%>
		<script language="JavaScript">
			alert('System independent Authorization(s) updated successfully');
			history.go(-2)
		</script>
<%
	} //end if
%>
<input type="hidden" name="Area" value="<%=areaFlag%>">
	<input type="hidden" name="WebSysKey" value="<%=websyskey%>" >
	<input type="hidden" name="BusinessPartner" value="<%=Bus_Partner%>" >

</form>
</body>
</html>
