<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iListBPBySysKey.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iBPAuthListBySysKey.jsp"%>
<html>
<head>
<Title>Business Partner Authorizations</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/Partner/ezBPAuthListBySysKey.js">
</script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
</head>
<%
	if(ret.getRowCount()!=0)
	{
%>
		<body  onLoad='scrollInit();' onresize='scrollInit()' scroll="no">
<%
	}
	else
	{
%>
	<body  >
<%
	}
%>


<form name=myForm method=post action="ezSaveBPAuthListBySysKey.jsp" onSubmit="return funSelect()">
<Table  width="50%" border="0" align="center">
<%
	boolean showFlag = false;
	int authRows=0;
	if(ret.getRowCount()==0)
	{
%>
	<br><br><br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
		<Tr>
		<Td class="displayheader">
	      	<div align="center">No <%=areaLabel%> To List Authorisations</div>
	    	</Td>
	  	</Tr>
	</Table>
	<input type="hidden" name="Area" value="<%=areaFlag%>">
	<input type ="hidden" name="flag" value="1">

<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>
<% return;
	}
%>
<br>
	<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr align="center">
		<Td class="displayheader">Update Partner Authorizations</Td>
		</Tr>
	</Table>

<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center">
	<Th width="16%" align="right"><%=areaLabel.substring(0,areaLabel.length()-1)%>&nbsp;:</Th>
	<Td width="40%" align = "left">
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
<a href= "../Config/ezSetBusAreaDefaults.jsp?Area=<%=areaFlag%>&SystemKey=<%=websyskey%>"><%= wsk %> (<%=websyskey%>)</a>&nbsp;

	</Td>
	<Th width="18%" align="right">Business Partner:</Th>
      	<Td width="26%" align = "left">
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
		if(ret1.getRowCount()==0 )
			{
%>
			<input type="hidden" name="Area" value="<%=areaFlag%>">
			<input type ="hidden" name="flag" value="1">

			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
				<Tr>
				<Td class = "labelcell">
				<div align="center"><b>No Partners Present Under This <%=areaLabel.substring(0,areaLabel.length()-1)%>.</b></div>
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
<%
				int sysRows = retbpsys.getRowCount();
				String sysNum = null;
				String sysDesc = null;
				if ( sysRows > 0 )
					{
%>
<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<Tr>
<Th class="labelcell" >
	          <div align="center">List Of System Dependent Authorizations</div>
</Tr>
</Table>
				<div id="theads">
			<Table id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
			<Tr align="center">

			<Th width="31%" class="labelcell" >System</Th>
			<Th width="9%" title="Select/Deselect All"><input type='checkbox' name='chk1Main' onClick="selectAll()"></Th>
		      <Th width="69%" class="labelcell" >Authorizations</Th>
		    	</Tr>
			</Table>
				</div>


		 		<DIV id="InnerBox1Div">

				<Table id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%
					for ( int i = 0 ; i < sysRows; i++ )
						{
%>
						<input type="hidden" name="SysNum" value=<%=(retbpsys.getFieldValue(i,BPP_KEY_VALUE))%> >
				    	<Tr>
    	  				<Td align="left" valign="top" width="31%">
<%
					sysNum = (String)(retbpsys.getFieldValue(i,BPP_KEY_VALUE));
					EzcSysConfigParams sysparams = new EzcSysConfigParams();
					EzcSysConfigNKParams sysnkparams = new EzcSysConfigNKParams();
					sysnkparams.setLanguage("EN");
					sysnkparams.setSystemNumber(sysNum);
					sysparams.setObject(sysnkparams);
					Session.prepareParams(sysparams);

					retauth = (ReturnObjFromRetrieve)sysManager.getSystemAuth(sysparams);
					retauth.check();

					for(int k=retauth.getRowCount()-1;k>=0;k--)
					{
						if ( showRoles && !retRoles.find("ROLE_NR",retauth.getFieldValueString(k,SYSAUTH_KEY).trim()) )
						{
							retauth.deleteRow(k);
						}
					}
					authRows = retauth.getRowCount();

					String[] sortArrBySysKey = { "EUAD_AUTH_DESC" };
					retauth.sort( sortArrBySysKey, true );

	 				EzcBussPartnerParams bparams3 = new EzcBussPartnerParams();
					bparams3.setBussPartner(Bus_Partner);
					EzcBussPartnerNKParams bnkparams3 = new EzcBussPartnerNKParams();
					bnkparams3.setLanguage("EN");
		    	    		bnkparams3.setSys_no(sysNum);
					bparams3.setObject(bnkparams3);
					Session.prepareParams(bparams3);

					retbpauth = (ReturnObjFromRetrieve)BPManager.getBussPartnerAuth(bparams3);
					retbpauth.check();
%>
<%
					/**************vv***********************/
					if ( authRows > 0 )
						{
						showFlag = true;
						out.println(sysNum);
						}
					else
						{
%>
						</Td></Tr>
<%
						continue;
						}
%>
		    	  		</Td>
    	  				<Td width="69%">
    	  			    	    	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="100%">
<%
						if ( authRows > 0 )
							{
							for ( int j = 0 ; j < authRows ; j++ )
								{
%>
    	      							<Tr align="center" >
								<label for = "cb_<%=j%>">
    	      	  						<Td align="center" >
<%
								if (retbpauth != null  && retbpauth.find(BP_AUTH_KEY, retauth.getFieldValue(j,SYSAUTH_KEY)))
								{
%>
		      							<input type="checkbox" width="5%" name="chk<%=(retbpsys.getFieldValue(i,BPP_KEY_VALUE))%>" id= "cb_<%=j%>" value="<%=(retauth.getFieldValue(j,SYSAUTH_KEY))%>#<%=(retauth.getFieldValue(j,"EUAD_AUTH_DESC"))%>" checked>
		      							<input type="hidden" name="AuthKey<%=(retbpsys.getFieldValue(i,BPP_KEY_VALUE))%>" value="<%=(retauth.getFieldValue(j,SYSAUTH_KEY))%>#<%=(retauth.getFieldValue(j,"EUAD_AUTH_DESC"))%>">
<%
								}
								else
								{
%>
		      							<input type="checkbox"  name="chk<%=(retbpsys.getFieldValue(i,BPP_KEY_VALUE))%>" id= "cb_<%=j%>" value="<%=(retauth.getFieldValue(j,SYSAUTH_KEY))%>#<%=(retauth.getFieldValue(j,"EUAD_AUTH_DESC"))%>" unchecked>
<%
								}
%>
								</Td>
    	              						<Td align="left" > <span >
		      						<%=retauth.getFieldValue(j,"EUAD_AUTH_DESC")%>


					    	                 </span></Td>
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
						</label>
						</Tr>
<%
						}//End for
%>
<%
					}//End If
				if ( showFlag )
					{
%>
  					</Table>


  					</div>


				  	<div id="ButtonDiv" align = "center" style="position:absolute;top:90%;width:100%">


					      <input type="image" src="../../Images/Buttons/<%= ButtonDir%>/update.gif" value="Update" style="cursor:hand">

				  	    <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

				  	</div>

<%
					}
				else
					{
%>
					</Table>
					</div>
					</div>
					<br><br><br>
					<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="90%">
						<Tr>
						<Td align="center" class = "labelcell">
						<b>No System Dependant Authorizations Available</b>
						</Td>
						</Tr>
					</Table>
					<br>
					<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>
<%
					}
	String saved = request.getParameter("saved");
	if ( saved != null && saved.equals("Y") )
		{
%>
		<script language="JavaScript">
			alert('Partner Authorization(s) updated successfully');
			history.go(-2);
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
