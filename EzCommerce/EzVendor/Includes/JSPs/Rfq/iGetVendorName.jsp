<%!
	public String getCustomerName(String soldTo,String sysKey,ezc.session.EzSession Session)
	{
		try
		{
			String companyName = "";
			ezc.client.EzcPurchaseUtilManager ezUtil = new ezc.client.EzcPurchaseUtilManager(Session);
			ezUtil.setDefPayTo(soldTo);
			ezUtil.setDefOrdAddr(soldTo);
			String defPayTo = ezUtil.getUserDefPayTo();
			ezUtil.setPurAreaAndVendor(sysKey,soldTo); 
			ezc.ezparam.ReturnObjFromRetrieve listOfPayTos = (ezc.ezparam.ReturnObjFromRetrieve)ezUtil.getListOfPayTos(sysKey);
			
			if ( listOfPayTos != null && listOfPayTos.find("EC_PARTNER_NO",soldTo))
			{
				int rId = listOfPayTos.getRowId("EC_PARTNER_NO",soldTo);
				companyName = listOfPayTos.getFieldValueString(rId,"ECA_COMPANY_NAME").trim();
			}
			if("".equals(companyName) || "null".equals(companyName))
				return soldTo;
			else
				return companyName;
		}
		catch(Exception e)
		{
			return soldTo;
		}
	}	
	
%>



