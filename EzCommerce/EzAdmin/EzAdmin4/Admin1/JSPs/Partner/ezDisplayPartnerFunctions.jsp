<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%
	String sysKey[] = {aSysKey.trim()};
	String[] pf = new String[3];
	if ( FUNCTION.equals( "AG" ) )
	{
		pf[0]="RE";
		pf[1]="WE";
		pf[2]="AF";
	}
	else
	{
		pf[0] = "OA";
		pf[1] = "PI";
	}
	EzcBussPartnerParams bparamsPF = new EzcBussPartnerParams();
	EzcBussPartnerNKParams bnkparamsPF = new EzcBussPartnerNKParams();
	bparamsPF.setBussPartner(Bus_Partner.trim());
	bnkparamsPF.setLanguage("EN");
	bnkparamsPF.setPartnerFunctions(pf);
	bnkparamsPF.setErp_customer(aErpNo.trim());
	bnkparamsPF.setSysKeys(sysKey);
	bparamsPF.setObject(bnkparamsPF);
	Session.prepareParams(bparamsPF);

	ReturnObjFromRetrieve retBpPF = (ReturnObjFromRetrieve)BPManager.getBussPartnerPartnerFunctions(bparamsPF);
	retBpPF.check();
	int pfRows = 0;
	pfRows = retBpPF.getRowCount();
	for( int w=0; w < pfRows; w++)
	{
		String pfSysKey = retBpPF.getFieldValueString(w,"EC_SYS_KEY");
		String pfErpNo = retBpPF.getFieldValueString(w,"EC_PARTNER_NO");
		String pfEzErpNo = retBpPF.getFieldValueString(w,"EC_ERP_CUST_NO");
		String pfEzcNo = retBpPF.getFieldValueString(w,"EC_NO");
		String pFuncId = retBpPF.getFieldValueString(w,"EC_PARTNER_FUNCTION");
		pFuncId = pFuncId.trim();
		String pFuncDesc = "";

		if ( pFuncId.equals("RE") )
		{
			pFuncDesc = "Bill To";
		}
		else if ( pFuncId.equals("WE") )
		{
			pFuncDesc = "Ship To";
		}
		else if ( pFuncId.equals("AF") )
		{
			pFuncDesc = "Sales Office/Employee";
		}	
		else if ( pFuncId.equals("OA") )
		{
			pFuncDesc = "Ordering Address";
		}
		else if ( pFuncId.equals("PI") )
		{
			pFuncDesc = "Invoice Presented By";
		}
%>
	    	<Tr>
		<label for="cb_<%=l%>">
		    	<Td>&nbsp</Td>
		    	<Td>&nbsp;</Td>
	    		<Td>
	      			<input type="checkbox" id="cb_<%=l%>" name="CheckBox" value="<%=pFuncId%>###<%=pfErpNo.trim()%>###<%=pfEzErpNo%>###<%=aSysKey%>"><b><%=pFuncDesc%></b>
	    		</Td>
	    		<Td>
				<%=pfErpNo.trim()%>
	      			<input type="hidden" name="ERPCUST"  value="<%=pfErpNo.trim()%>">
				<input type="hidden" name="EzcCustomer" value="<%=pfEzErpNo%>">
				<input type="hidden" name="AREA" value="<%=aSysKey%>">
		    	</Td>
	    	</label>
	    	</Tr>
<%
		l++;
	}
%>