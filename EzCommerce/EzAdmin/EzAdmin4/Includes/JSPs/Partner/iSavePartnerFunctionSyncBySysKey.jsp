<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<%@ include file="../../../Includes/Lib/BussPartnerBean.jsp"%>
<%
String BusPartner = null;
String SysNum = null;
String SysKey = null;

BusPartner = request.getParameter("BusPartner");
SysNum = request.getParameter("SysNum");
SysKey = request.getParameter("SysKey");
String Area=request.getParameter("Area");

String FUNCTION = request.getParameter("FUNCTION");
if ( FUNCTION == null ) FUNCTION = "AG";



EzCustomerStructure custin = new EzCustomerStructure();
EzCustomerAddrStructure in = new EzCustomerAddrStructure();
String ERP_SoldTo =request.getParameter("ERP_SoldTo");
//String CheckBox[] =request.getParameterValues("CheckBox");
String PartnerFunction[] =request.getParameterValues("PartnerFunction");
String PartNum[] = request.getParameterValues("PartNum");
String PartFunc[] =request.getParameterValues("PartFunc");
String CustName[] =request.getParameterValues("CustName");
String Addr1[]=request.getParameterValues("Addr1");
String City[]=request.getParameterValues("City");
String State[]=request.getParameterValues("State");
String Zip[] =request.getParameterValues("Zip");
String Country[]=request.getParameterValues("Country");


if(PartNum!=null)
{
	for(int i=0;i<PartNum.length;i++)
	{
		boolean isNewEzc = false;

		if ( PartnerFunction[i].equals("C") )
		{
			isNewEzc = true;
		}

		if ( isNewEzc )
		{
			custin.setCustomerNo(null);
		}
		else
		{
			custin.setCustomerNo(PartnerFunction[i]);
		}
		custin.setSysKey(SysKey);
		custin.setPartnerFunc(PartFunc[i]);
		custin.setPartnerNo(PartNum[i]);
		custin.setErpSoldTo(ERP_SoldTo);
		custin.setBussPartner(BusPartner);
		custin.setDelFlag("N");

		if ( isNewEzc )
		{
			in.setLanguage("EN");
			in.setRefNo(10);
			in.setCompanyName(CustName[i]);
			in.setName(CustName[i]);
			in.setAddr1(Addr1[i]);
			in.setCity(City[i]);
			in.setState(State[i]);
			in.setPin(Zip[i]);
			in.setIsBussPartner("N");
			in.setPhone(" ");
			in.setWebAddr(" ");
			in.setEmail(" ");
			in.setAddr2(" ");
			in.setCountry(Country[i]);
			in.setShipAddr1(Addr1[i]);
			in.setShipAddr2(" ");
			in.setShipCity(City[i]);
			in.setShipState(State[i]);
			in.setShipCountry(" ");
			in.setShipPin(Zip[i]);
			in.setDelFlag(" ");
		}

			if ( FUNCTION.equals("AG") )
			{
				EzcCustomerParams cparams = new EzcCustomerParams();
				EzCustomerParams  cnkparams = new EzCustomerParams();
				cnkparams.setLanguage("EN");
				cnkparams.setEzCustomerStructure(custin);
				cnkparams.setEzCustomerAddrStructure(in);
				cparams.setObject(cnkparams);
				Session.prepareParams(cparams);
				ReturnObjFromRetrieve retSBPSave = (ReturnObjFromRetrieve) CustomerManager.createCustomer(cparams);
			}
			else
			{

				EzcVendorParams vparams = new EzcVendorParams();
				EzVendorParams  vnkparams = new EzVendorParams();
				vnkparams.setLanguage("EN");
				vnkparams.setEzCustomerStructure(custin);
				vnkparams.setEzCustomerAddrStructure(in);
				vparams.setObject(vnkparams);
				Session.prepareParams(vparams);
				ReturnObjFromRetrieve retSBPSave = (ReturnObjFromRetrieve) VendorManager.createVendor(vparams);
			}

	}
}

%>