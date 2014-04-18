<Table  width="90%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center">
	<Th width="25%" class="labelcell">
        <div align="right">Select&nbsp;<%=areaLabel.substring(0,areaLabel.length()-1)%>&nbsp;:
        </div>
      	</Th>
	<Td width="25%" class="blankcell">
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
		<%=wsk%>
	</Td>
	<Th width="25%" class="labelcell">
        <div align="right">Business Partner:</div>
      	</Th>
      	<Td width="30%" class="blankcell">
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
		<%=buspar%>
     	</Td>
    	</Tr>
</Table>
<br>
<%
		if(ret1.getRowCount()==0 )
		{
%>
			<input type="hidden" name="Area" value="<%=areaFlag%>">
			<input type ="hidden" name="flag" value="1">
			<br><br>
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
	if ( sysRows <= 0 )
	{
		return;
	}
	out.println(sysRows);
	
	if(showRoles)
	{
	
	int rolesCount=0;
	
	if(retRoles!=null && ((rolesCount=retRoles.getRowCount())>0))
	{
%>
		<div id="theads">
		<Table  width="90%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
			<Tr align="left">
			<Th width="31%" class="labelcell" >System</Th>
			<Th width="69%" class="labelcell" >Authorizations</Th>
			</Tr>
		</Table>
		</div>
		
		<DIV id="OuterBox1Div" style="position:absolute" >
		<DIV id="InnerBox1Div" >
		<Table  width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		
<%
		for ( int i = 0 ; i < sysRows; i++ )
		{
			
			sysNum = (String)(retbpsys.getFieldValue(i,BPP_KEY_VALUE));
		
			EzcBussPartnerParams bparams3 = new EzcBussPartnerParams();
			bparams3.setBussPartner(Bus_Partner);
			EzcBussPartnerNKParams bnkparams3 = new EzcBussPartnerNKParams();
			bnkparams3.setLanguage("EN");
			bnkparams3.setSys_no(sysNum);
			bparams3.setObject(bnkparams3);
			Session.prepareParams(bparams3);

			retbpauth = (ReturnObjFromRetrieve)BPManager.getBussPartnerAuth(bparams3);
			retbpauth.check();
			showFlag = true;	
					
%>
			<Tr>
			<Td align="left" valign="top" width="31%">
			<input type="hidden" name="SysNum" value=<%=sysNum%> >
			<%=sysNum%>
			</Td>
			<Td width="69%">
    	  	    	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="100%">
<%
			String roleNumber=null;
			String roleDesc=null;
			
			for ( int j = 0 ; j < rolesCount ; j++ )
			{
				roleNumber=retRoles.getFieldValueString(j,"ROLE_NR");
				roleDesc=retRoles.getFieldValueString(j,"ROLE_NR");
				
				
				
%>
    	      		<Tr align="center" >
    	      	 	<Td align="center" >
<%			if (retbpauth != null  && retbpauth.find(BP_AUTH_KEY,roleNumber))
			{
%>				<input type="checkbox" name="chk<%=sysNum%>" value="<%=roleNumber%>#<%=roleDesc%>" checked>
					
<%			}
			else
			{
%>				
				<input type="checkbox" name="chk<%=sysNum%>" value="<%=roleNumber%>#<%=roleDesc%>" unchecked>
<%
			}
%>
			</Td>
              		<Td align="left" >
	      			<%=roleDesc%>
		        </Td>
    	      		</Tr>
<%
			}//End for
							
%>
    	    		</Table>
			</Td>
			</Tr>
<%
		}
%>
		</Table>
		</Div>
		</Div>
		<div id="ScrollBoxDiv" style="position:absolute;top:87%;left:87%;visibility:hidden">
			<A HREF="javascript:void(0)" onmouseOver="scrolling=1;UpDn='dn'; javascript:scrollMessage(); return false;" onmouseOut="scrolling=0;clearTimeout(timerID)" onClick="javascript:pageUpDnMessage(); return false;">
			<img name="scrollDn" src="../../Images/Buttons/<%= ButtonDir%>/down.gif" border="0" alt="Scroll Down"></a>
			<A HREF="javascript:void(0)" onmouseOver="scrolling=1;UpDn='up'; javascript:scrollMessage(); return false;" onmouseOut="scrolling=0;clearTimeout(timerID)" onClick="javascript:pageUpDnMessage(); return false;">
			<img name="scrollUp" src="../../Images/Buttons/<%= ButtonDir%>/up.gif" border="0" alt="Scroll Up"></a>
  		</div>
  		<div align = "center" style="position:absolute;top:88%;width:100%">
			<img src="../../Images/Buttons/<%= ButtonDir%>/selectall.gif" value="Select All" onClick=setChecked(1) style="cursor:hand">
			<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/save.gif" value="Update" style="cursor:hand">
			<img src="../../Images/Buttons/<%= ButtonDir%>/clearall.gif" name="Reset" value="Clear All" onClick=setChecked(0) style="cursor:hand">
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

		</div>

<%
	}
   }
   

%>

