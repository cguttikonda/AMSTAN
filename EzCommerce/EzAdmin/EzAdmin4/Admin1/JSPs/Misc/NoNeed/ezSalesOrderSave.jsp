<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import = "ezc.ezsap.*"%>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ page import = "ezc.xml.ezbusinessobject.*"%>
<%@ page import = "ezc.ezsem.*"%>
<%@ page import = "ezc.ezsem.ezsales.*"%>


<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>

<jsp:useBean id="SBObject" class="ezc.ezcsm.ezsales.SalesBusObject" scope="session">
<jsp:setProperty name="SBObject" property="*"/>
</jsp:useBean>


<%	

	ServletContext salescontext = getServletConfig().getServletContext();
	EzsSalesBusServlet SOservlet = null;

	SOservlet = (EzsSalesBusServlet) salescontext.getServlet("ezc.ezsem.ezsales.EzsSalesBusServlet");
	


	BapisdheadStructure orderHeader = null;
	BapipartnrTable orderPartners =  null;
	BapipartnrTableRow aRow = null;
	BapiiteminTable iteminTable = null;
	BapisoldtoStructure soldtoStruct = null;
	BapiitemexTable  itemoutTable = null;
	BapiitemexTableRow oItemRow = null;  
	SalesOrderCreatefromdataParams ioParams = null;
	String sDocNumber = null; // Previous Document Number
	Object DocTree = null;
	boolean returnresult = false;
	EzValidateXMLParams validateXMLParams= null;

//INPUT PARAMETERS
	String UserID = request.getParameter("UserID");
	String TransactionID = request.getParameter("TransactionID");
	String CatalogArea = request.getParameter("CatalogArea");
	String urlstring = request.getParameter("UrlString");
//INPUT PARAMETERS

	//com.ibm.record.util.OrderedDictionary user_defaults;
	//user_defaults = AdminObject.getEzUser ().getUserDefaults ();//get this from the admin  bean

// Date Format Object
	FormatDate formatDate = new FormatDate();

try{
		
	
	// Call BAPI to create a new sales order 
	//if (servlet != null) {
//		DocTree = AdminObject.validateXMLDocument(servlet, UrlString, UserID, CatalogArea, TransactionID); 
		validateXMLParams = AdminObject.validateXMLDocument(servlet, "..\\3A4PurchaseOrderRequestMessage.xml", "JOHN", "400SAPFUR", "SO_CREATE"); 

		returnresult = AdminObject.processMessage(SOservlet,validateXMLParams);

	//}

	if (!returnresult)
	{

	}
}catch(Exception e){
	//e.printStackTrace(out);
	response.sendRedirect("../../Htmls/Error.htm");
}
%>