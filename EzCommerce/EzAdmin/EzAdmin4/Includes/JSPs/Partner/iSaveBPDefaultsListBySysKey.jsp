<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<%@ include file="../../../Includes/Lib/BussPartnerBean.jsp"%>

<%

	String FUNCTION = request.getParameter("FUNCTION");
	String SADesc = request.getParameter("SADesc");
	String BusPartner = null;
	String SysKey = null;
	String SoldTo = null;

	BusPartner = request.getParameter("BusinessPartner");
	SysKey = request.getParameter("SysKey");
	SoldTo = request.getParameter("SoldTo");

	String pDefKey[] = request.getParameterValues("DefaultsKey");
	String pDefValue[] = request.getParameterValues("DefaultsValue");

	java.util.Vector myVect=new java.util.Vector();
	String[] oldVals=request.getParameterValues("OldVals");

	if(oldVals != null)
	{
		for(int i=0;i<oldVals.length;i++)
			myVect.add(oldVals[i].substring(1));
	}

	boolean flag=false;
	if(pDefKey!=null)
	{
		for ( int j = 0  ; j < pDefKey.length; j++ )
		{
			flag=false;
			if(myVect.contains(j+""))
				flag=true;
			else if(!"".equals(pDefValue[j]))
				flag=true;

			if(flag)
			{
				EzKeyValueStructure in = new EzKeyValueStructure();
				in.setPKey(SoldTo);
				in.setKey(pDefKey[j].trim());
				in.setValue(pDefValue[j].trim());
				EzcBussPartnerParams bparams2 = new EzcBussPartnerParams();
				EzcBussPartnerNKParams bnkparams2 = new EzcBussPartnerNKParams();
				bnkparams2.setLanguage("EN");
				bnkparams2.setEzKeyValueStructure(in);
				bnkparams2.setSys_key(SysKey);
				bparams2.setObject(bnkparams2);
				Session.prepareParams(bparams2);
				BPManager.setCustomerDefaults(bparams2);
			}
		}
	}


	response.sendRedirect("ezBPDefaultsListBySysKey.jsp?saved=Y&BusinessPartner=" + BusPartner+"&area="+SysKey+"&SoldTo="+SoldTo+"&FUNCTION="+FUNCTION+"&SADesc="+SADesc);

%>
