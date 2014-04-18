<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%
	String vendorCode=request.getParameter("VendorCode");
	String vendorName=request.getParameter("VendorName");
	String chkdVendrs=request.getParameter("ChkdVendors");
	String quantity=request.getParameter("quantity");
	
	
	Vector vc = new Vector();
	
	if(chkdVendrs != null)
	{
		if(chkdVendrs.indexOf("¥") != -1)
		{
			StringTokenizer stoken = new StringTokenizer(chkdVendrs,"¥");
			while(stoken.hasMoreElements())
			{
				vc.addElement(stoken.nextToken());
			}
			
		}	
		else
		{
			vc.addElement(chkdVendrs);
		}
	}	
	
	
	ezc.ezparam.ReturnObjFromRetrieve retSAPVendorList = null;
	int retSAPVendorCount=0;
	
	if(vendorCode != null || vendorName != null)
	{
		ezc.ezpreprocurement.client.EzPreProcurementManager prepromgranager=new ezc.ezpreprocurement.client.EzPreProcurementManager();
		ezc.ezpreprocurement.params.EziSAPVendorParams param=new ezc.ezpreprocurement.params.EziSAPVendorParams();
		param.setVendorCode(vendorCode);
		param.setVendorName(vendorName);
		
		ezc.ezparam.EzcParams mainParams=new ezc.ezparam.EzcParams(false);
		mainParams.setLocalStore("Y");
		mainParams.setObject(param);
		Session.prepareParams(mainParams);
		retSAPVendorList=(ezc.ezparam.ReturnObjFromRetrieve)prepromgranager.getSAPVendorList(mainParams);
		if(retSAPVendorList!=null)
			retSAPVendorCount=retSAPVendorList.getRowCount();
	}	
	
	
%>
