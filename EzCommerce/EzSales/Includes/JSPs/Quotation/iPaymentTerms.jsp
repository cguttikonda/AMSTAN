<%@ page import="java.util.*"%>
<%
	Hashtable ezPaymentTerms = new Hashtable();
	
	ezPaymentTerms.put("PEND","Subject to Credit Approval");
	ezPaymentTerms.put("PYPL","PayPal  Electronic payment");
	ezPaymentTerms.put("Z000","Net due upon receipt");
	ezPaymentTerms.put("Z005","Net 5");
	ezPaymentTerms.put("Z010","Net 10");
	ezPaymentTerms.put("Z015","Net 15");
	ezPaymentTerms.put("Z020","Net 20");
	ezPaymentTerms.put("Z025","Net 25");
	ezPaymentTerms.put("Z030","Net 30");
	ezPaymentTerms.put("Z045","Net 45 days");
	ezPaymentTerms.put("Z050","Net 50 days");
	ezPaymentTerms.put("Z055","Net 55");
	ezPaymentTerms.put("Z060","Net 60");
	ezPaymentTerms.put("Z075","Net 75 days");
	ezPaymentTerms.put("Z090","Net 90 days");
	ezPaymentTerms.put("Z105","1 %, Net 5");
	ezPaymentTerms.put("Z110","1 %, Net 10 days");
	ezPaymentTerms.put("Z115","1 %, Net 15 days");
	ezPaymentTerms.put("Z120","1 %, Net 20 days");
	ezPaymentTerms.put("Z125","1 %, Net 25 days");
	ezPaymentTerms.put("Z130","1 %, Net 30 days");
	ezPaymentTerms.put("Z150","Net 150 days");
	ezPaymentTerms.put("Z210","2 %, Net 10 days");
	ezPaymentTerms.put("Z25X","1/4 %, N10/Net 30");
	ezPaymentTerms.put("Z505","1/2 %, Net 5");
	ezPaymentTerms.put("Z510","1/2 %, Net 10 days");
	ezPaymentTerms.put("Z515","1/2 %, Net 15 days");
	ezPaymentTerms.put("Z520","1/2 %, Net 20");
	ezPaymentTerms.put("Z525","1/2 %, Net 25 days");
	ezPaymentTerms.put("Z530","1/2 %, Net 30 days");
	ezPaymentTerms.put("Z545","1/2% discount in 5/Net due 45 days");
	ezPaymentTerms.put("ZAMX","American Express");
	ezPaymentTerms.put("ZCCA","Company Check in Advance");
	ezPaymentTerms.put("ZCCT","Customized Contractual Terms");
	ezPaymentTerms.put("ZCIA","Cash in Advance");
	ezPaymentTerms.put("ZCOC","COD Certified");
	ezPaymentTerms.put("ZCOD","COD");
	ezPaymentTerms.put("ZDIS","Discover");
	ezPaymentTerms.put("ZMAC","Master Card");
	ezPaymentTerms.put("ZN20","Net 120");
	ezPaymentTerms.put("ZN45","1% discount in 5/Net due 45 days");
	ezPaymentTerms.put("ZPPD","Advanced Payment Received");
	ezPaymentTerms.put("ZTPL","Third Party Lease");
	ezPaymentTerms.put("ZVIS","Visa");
%>