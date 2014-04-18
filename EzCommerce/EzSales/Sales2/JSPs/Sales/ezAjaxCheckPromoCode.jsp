<%@ page import="java.util.*,ezc.ezparam.*,ezc.ezdiscount.params.*"%>
<%@ page import="ezc.ezcnetconnector.params.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<jsp:useBean id="CnetManager" class="ezc.ezcnetconnector.client.EzCnetConnectorManager"/>
<%!
	public String checkNULL(String str)
	{
		if(str==null || "null".equals(str) || "".equals(str))
			str = "N/A";
		else
		{
			str = str.replaceAll("\"","`");
			str = str.trim();
		}	
			
		return str;	
	}
%>
<%
	String promoCode = request.getParameter("promoCode");
	
	ezc.ezcommon.EzLog4j.log("promoCode::::"+promoCode,"D");
	
	ezc.ezdiscount.client.EzDiscountManager ezDiscountManager = new ezc.ezdiscount.client.EzDiscountManager();
	
	EziDiscountParams ezDiscParams = new EziDiscountParams();
	EzcParams discMainParams = new EzcParams(true);
	
	ezDiscParams.setType("GET_ALL_PROMO_CODES");
	ezDiscParams.setExt1("WHERE EPC_CODE='"+promoCode+"' AND EPC_STATUS='Y' AND GETDATE() BETWEEN EPC_VALID_FROM AND EPC_VALID_TO");

	discMainParams.setObject(ezDiscParams);
	discMainParams.setLocalStore("Y");
	Session.prepareParams(discMainParams);

	ReturnObjFromRetrieve retPromoCodes = null;
	int retPromoCodesCount = 0;
	
	try
	{
		retPromoCodes = (ReturnObjFromRetrieve)ezDiscountManager.ezGetPromotion(discMainParams);
	}
	catch(Exception e){}
	
	if(retPromoCodes!=null && retPromoCodes.getRowCount()>0)
	{
		String promoType = checkNULL(retPromoCodes.getFieldValueString(0,"EPC_PROMO_TYPE"));
		String offerDiscount = checkNULL(retPromoCodes.getFieldValueString(0,"EPC_DISCOUNT"));
		String manfId = checkNULL(retPromoCodes.getFieldValueString(0,"EPC_MFR_ID"));
		String itemCat = checkNULL(retPromoCodes.getFieldValueString(0,"EPC_PROD_CAT"));
		
		if("PCORD".equals(promoType))
		{
			manfId = "All";
			itemCat = "All";
		}
		else if("PCMFR".equals(promoType))
		{
			itemCat = "All";
		}
		
		out.print("VALIDPROMOCODE#"+promoType+"#"+manfId+"#"+itemCat+"#"+offerDiscount);
	}
%>