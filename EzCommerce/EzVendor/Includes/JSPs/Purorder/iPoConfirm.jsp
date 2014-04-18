<%@ page import = "ezc.ezsap.*"%>
<%@ page import = "java.math.*"%>
<%@ page import = "ezc.ezpurchase.params.*"%>
<%@ page import = "ezc.ezutil.FormatDate"%>

<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<%--  @ include file="../../../Includes/Lib/SessionBean.jsp" --%>

<%@ include file="../../../Includes/Lib/ShoppingCartBeanPO.jsp"%>

<% ezc.ezutil.EzSystem.out.println("In ISOCONFIRM --------Session"+Session);%>

<%@ include file="../../../Includes/Lib/DateFunctions.jsp"%>

<%--  @ include file="../../../Includes/Lib/ServerFunctions.jsp" --%>
<jsp:useBean id="PoManager" class="ezc.client.EzPurchaseManager" scope="page">
</jsp:useBean>


<%!
// Start Declarations

String carrId = null;

public String getCarrierDescription(String carrID)
{
	if(carrID.compareTo("AB") == 0)
	{
		return "Airborne";
	}
	else
	{
		if(carrID.compareTo("DH") == 0)
		{
			return "DHL";
		}
		else
		{
			if(carrID.compareTo("FX") == 0)
			{
				return "Federal Express";
			}
			else
			{
				if(carrID.compareTo("UP") == 0 )
				{
					return "UPS";
				}
				else
				{
					return "Special Courier";
				}
			}	
		}
	}
}

// CheckString for the Date 
public java.lang.String checkString(java.lang.String instr) 
{
	java.lang.String month = null;
	java.lang.String rest = null;
	java.lang.String year = null;
	java.lang.String date  = null;
	if (instr.length() < 10) 
	{
		month = instr.substring(0, instr.indexOf("/") + 1);
		rest = instr.substring(instr.indexOf("/") + 1, instr.length());
		date = rest.substring(0, rest.indexOf("/") + 1);
		year = rest.substring(rest.indexOf("/") + 1, rest.length());
		if (date.length() < 3)
			date = "0" + date;
		if (year.length() < 3) 
		{
		    if (year.charAt(0) > '6')
			year = "19" + year;
		     else
			year = "20" + year;
		}
		if (month.length() < 3)
			month = "0" + month;
		if (rest.length() < 7)
			rest = "0" + rest;
		return month + date + year;	
	}
	return instr;
}

final String CURRENCY_KEY = "ECD_CURR_KEY";
final String CURRENCY_LANG = "ECD_LANG";
final String CURRENCY_LONG_DESC = "ECD_LONG_DESC";
final String CURRENCY_SHORT_DESC= "ECD_SHORT_DESC";

final String CURR_KEY = "EC_CURR_KEY";
final String CURRENCY_ISO_KEY = "EC_ISO_CURR_KEY";
final String CURRENCY_ALT_KEY = "EC_ALTERNATE_KEY";
final String CURRENCY_VALID_DATE = "EC_VALID_TO_DATE";

//End Declarations
%>

<%
// Get Preferred Currency
String prefCurrency =(String) Session.getUserPreference("CURRENCY");

if(prefCurrency == null )
{
	prefCurrency = "USD";
}
//ezc.ezutil.EzSystem.out.println("Preferred Currency: "+ prefCurrency);

// constants for the Date Array
final int DATE = 1; 
final int MONTH = 0 ; 
final int YEAR = 2;


//------ changes end here --------------------------------



// Date Format Object
FormatDate formatDate = new FormatDate();

java.util.GregorianCalendar fromDate = null ; 
java.util.GregorianCalendar deliveryDate = null ;
java.util.GregorianCalendar reqDate = null ;
java.util.GregorianCalendar reqDateH = null ; // Header Required

fromDate = (java.util.GregorianCalendar)java.util.GregorianCalendar.getInstance();	
 
String constBatch = "Batch";

// for Looping thru the selection	
String strMaterialField = "MATERIAL_";
String strOrderField = "ORDER_";
String strDateField = "DATE_";

// Required Date for the Header
String headerReqDate = "REQDATE";
int[] dateArray = null;

dateArray = formatDate.getMMDDYYYY(checkString( request.getParameter(headerReqDate) ) , true);
reqDateH = new java.util.GregorianCalendar(dateArray[YEAR] ,dateArray[MONTH]-1,dateArray[DATE]);


EzcPurchaseParams purContainer = new EzcPurchaseParams();

EziPurchaseOrderCreateParams ioparams = new EziPurchaseOrderCreateParams ();
EzBapiekpocTable itemTable = new EzBapiekpocTable();
EzBapiekpocTableRow aItemRow = null;
EzBapieketTable schedTable=new EzBapieketTable();
EzBapieketTableRow schedRow=null;
String PartnNum = request.getParameter("CustomerNum");


String DateReq=null;
int j = 0;
dateArray = null;

// Get the Number Of Rows for the Sales Order
String Count = request.getParameter("TotalCount");
int TotalCount = new Integer(Count).intValue();

String OrderQuantity = null ;
java.math.BigDecimal bOrderQty = null;
//vvif ( iteminTable.getRowCount() == 0 ) 
//vv{
String strPriceField;
System.out.println (" <<< JSP >>> Total Count is -> " + TotalCount);

	while ( j < TotalCount) 
	{

		strMaterialField = "MATERIAL_" + j;
  		strOrderField = "ORDER_" + j;
  		strDateField ="DATE_" + j;
  		strPriceField = "Price_"+j;
  		DateReq=request.getParameter(strDateField);
  		

		OrderQuantity = request.getParameter(strOrderField);
		System.out.println (" <<< JSP >>> OrderQuantity -> " + OrderQuantity);
		if (!OrderQuantity.equals(""))
		{
			bOrderQty  = new java.math.BigDecimal(OrderQuantity);
			String fmDate = request.getParameter(strDateField);
			fmDate = fmDate.trim();
			dateArray = formatDate.getMMDDYYYY(checkString(fmDate ), true);

			reqDate = new java.util.GregorianCalendar(dateArray[YEAR],dateArray[MONTH]-1,dateArray[DATE]);
			
			aItemRow = new EzBapiekpocTableRow();
			aItemRow.setMaterial(request.getParameter(strMaterialField)); 
			aItemRow.setPurMat(request.getParameter(strMaterialField)); 
			aItemRow.setPlant("US21");
			aItemRow.setDispQuan(bOrderQty); 
			//java.math.BigDecimal pr = new BigDecimal("1212");
			//aItemRow.setNetPrice(new java.math.BigDecimal(request.getParameter(strPriceField)));			
			itemTable.appendRow(aItemRow); 

			schedRow = new EzBapieketTableRow();
			System.out.println ( " <<< JSP >>> Date  -> " + reqDate.getTime() );
			schedRow.setDelivDate(reqDate.getTime());
			schedRow.setQuantity(bOrderQty);
			schedTable.appendRow(schedRow);
	 		
		}// End If
		
		bOrderQty = null;
		dateArray = null;
		reqDate = null;
		OrderQuantity = null;
		j++;
	} // While Close		
//vv} // End If for Row Count 
EzPSIInputParameters iparams = new EzPSIInputParameters();
EzBapiekkocStructure poHeader=new EzBapiekkocStructure();
poHeader.setDocDate(reqDateH.getTime());

ioparams.setPoItems(itemTable);
ioparams.setPoItemSchedules(schedTable);
ioparams.setPoHeader(poHeader);

purContainer.setObject(ioparams);
purContainer.setObject(iparams);
Session.prepareParams(purContainer);
System.out.println(">>>> iPoConfirm.jsp - ezCreatePurchaseOrder Before calling create po");
System.out.println(">>>> iPoConfirm.jsp - ezCreatePurchaseOrder Before calling create po");
EzoPurchaseOrderCreate purObj=(EzoPurchaseOrderCreate)PoManager.ezCreatePurchaseOrder(purContainer);
System.out.println(">>>> iPoConfirm.jsp - ezCreatePurchaseOrder After calling create po"+purObj);



ReturnObjFromRetrieve itemoutTable = (ReturnObjFromRetrieve)purObj.getPoItems();
ReturnObjFromRetrieve orderHeader = (ReturnObjFromRetrieve)purObj.getPoHeader();

/**VV
if(returnStruct.getRowCount()> 0)
{
	if ((returnStruct.getFieldValue(0,"Type")).equals("E")) 
	{
	    	out.println("<BR> Unable to Create the Sales Order. <BR>");
		out.println(" the follwing error occurred " + returnStruct.getFieldValue(0,"Message"));
	}
}
**/
ezc.ezutil.EzSystem.out.println("Inside isoConfirm ==========>>>>>>>>>>>>>-----------END");		
%>