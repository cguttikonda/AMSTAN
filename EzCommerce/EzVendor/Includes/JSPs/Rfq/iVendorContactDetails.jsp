<%@ include file="../../Lib/PurchaseBean.jsp"%>
<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" scope="session" />
<jsp:useBean id="UploadManager" class="ezc.ezupload.client.EzUploadManager" scope="session" />
<%@page import="java.util.*" %>
<%
	String companyName = "";

	String sysKey = request.getParameter("SysKey");
	String soldTo = request.getParameter("SoldTo");

	String contactPerson = "";
	String designation = "";
	String email = "";
	String address1 = "";
	String address2 = "";
	String city = "";
	String state = "";
	String country = "";
	String zipcode = "";
	String phone1 = "";
	String phone2 = "";
	String fax = "";
	
	
	Hashtable ht = new Hashtable();
	ResourceBundle CntryNames = ResourceBundle.getBundle("COUNTRIES");
	/*Enumeration CntryEnu =CntryNames.getKeys();
	while(CntryEnu.hasMoreElements())
	{
		String s2=(String)CntryEnu.nextElement();
		ht.put(s2, CntryNames.getString(s2));
	}*/

	ezc.client.EzcPurchaseUtilManager ezUtil = new ezc.client.EzcPurchaseUtilManager(Session);
	ezUtil.setDefPayTo(soldTo);
	ezUtil.setDefOrdAddr(soldTo);

	String defPayTo = ezUtil.getUserDefPayTo();
	
	ezUtil.setPurAreaAndVendor(sysKey,soldTo); 
	
	

	ReturnObjFromRetrieve listOfPayTos = (ReturnObjFromRetrieve)ezUtil.getListOfPayTos(sysKey);
	
	int listOfPayTosCnt = 0;
	
	if(listOfPayTos!=null)
		listOfPayTosCnt  =  listOfPayTos.getRowCount();
	
	
	if ( listOfPayTos != null && listOfPayTos.find("EC_PARTNER_NO",soldTo))
	{
		int rId = listOfPayTos.getRowId("EC_PARTNER_NO",soldTo);

		companyName = listOfPayTos.getFieldValueString(rId,"ECA_COMPANY_NAME").trim();
		
		address1 = listOfPayTos.getFieldValueString(rId,"ECA_ADDR_1").trim();
		address1 = address1.equals("null") ? "":address1;

		address2 = listOfPayTos.getFieldValueString(rId,"ECA_ADDR_2").trim();
		address2 = address2.equals("null") ? "":address2;

		city = listOfPayTos.getFieldValueString(rId,"ECA_CITY").trim();
		city = city.equals("null") ? "":city;

		state  = listOfPayTos.getFieldValueString(rId,"ECA_STATE").trim();
		state = state.equals("null") ? "":state;

		zipcode = listOfPayTos.getFieldValueString(rId,"ECA_PIN").trim();
		zipcode = zipcode.equals("null") ? "":zipcode;

		country = listOfPayTos.getFieldValueString(rId,"ECA_COUNTRY").toUpperCase().trim();
		country = country.equals("null") ? "":country;
	}
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(true);
   	ezc.ezvendorapp.params.EzVendorProfileStructure struct =  new ezc.ezvendorapp.params.EzVendorProfileStructure();
	struct.setSysKey(sysKey);
	struct.setSoldTo(soldTo);
	mainParams.setObject(struct);
	mainParams.setLocalStore("Y");
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve ret = (ezc.ezparam.ReturnObjFromRetrieve)AppManager.ezGetVendorProfile(mainParams);
	
	int count = 0;
	if(ret!=null)
		count = ret.getRowCount();
		
	if(count>0)
	{
		contactPerson = ret.getFieldValueString(0,"CONTACTPERSON");
		contactPerson = contactPerson.equals("null") ? "":contactPerson;

		designation = ret.getFieldValueString(0,"DESIGNATION");
		designation = designation.equals("null") ? "":designation;

		email = ret.getFieldValueString(0,"EMAIL");
		email = email.equals("null") ? "":email;

		phone1 = ret.getFieldValueString(0,"PHONE1");
		phone1 =phone1.equals("null") ? "":phone1;

		phone2 = ret.getFieldValueString(0,"PHONE2");
		phone2 = phone2.equals("null") ? "":phone2;

		fax = ret.getFieldValueString(0,"FAX");
		fax = fax.equals("null") ? "":fax;
	}
	ezUtil.setPurAreaAndVendor(sysKey,(String)session.getValue("SOLDTO")); 
%>
