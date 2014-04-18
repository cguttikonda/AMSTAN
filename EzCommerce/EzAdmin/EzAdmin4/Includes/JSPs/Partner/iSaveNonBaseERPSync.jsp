<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<%@ include file="../../../Includes/Lib/BussPartnerBean.jsp"%>

<%
String BusPartner = null;
String SysNum = null;
String SysKey = null;
String genEzc = "";
BusPartner = request.getParameter("BusPartner");
SysNum = request.getParameter("SysNum");
SysKey = request.getParameter("SysKey");

EzCustomerStructure custin = new EzCustomerStructure();


EzCustomerAddrStructure in = new EzCustomerAddrStructure();

String Ezc_SoldTo[] =request.getParameterValues("Ezc_SoldTo");
String ERPSoldTo[]=request.getParameterValues("ERPSoldTo");
String PartNum[]=request.getParameterValues("PartNum");
String PartFun[]=request.getParameterValues("PartFun");

if(PartNum!=null)
{
	for(int i=0;i<PartNum.length;i++)
	{
			custin.setCustomerNo(Ezc_SoldTo[i]);
			custin.setSysKey(SysKey);
			custin.setPartnerFunc(PartFun[i]);
			custin.setPartnerNo(PartNum[i]);
			custin.setErpSoldTo(ERPSoldTo[i]);
			custin.setBussPartner(BusPartner);
			custin.setDelFlag("N");

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
		 	genEzc = retSBPSave.getFieldValueString(0,"EZC_NUMBER");

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
			genEzc = retSBPSave.getFieldValueString(0,"EZC_NUMBER");
		}

		genEzc = Ezc_SoldTo[i];

	}
}

%>