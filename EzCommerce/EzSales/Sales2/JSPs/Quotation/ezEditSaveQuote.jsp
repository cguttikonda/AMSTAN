<%@ page import = "ezc.ezparam.*,ezc.ezbasicutil.*,ezc.ezutil.FormatDate,java.util.*,ezc.ezsalesquote.params.*" %>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezSalesBean.jsp" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp" %>
<jsp:useBean id= "editSalVal" class="ezc.sales.params.EzSalesSetPropParams"/>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<jsp:setProperty name="editSalVal" property="*"/>
<%
	log4j.log("in EditSaveQuote in EditSaveQuote in EditSaveQuote in EditSaveQuote in EditSaveQuote1","W");

	String quoteNo = request.getParameter("quoteNo");
	String soNum = request.getParameter("soNum");
	String status = request.getParameter("status");
	String paymentTerm = request.getParameter("paymentTerm");
	String createdBy = request.getParameter("createdBy");

	String[] prodCode_1 	= request.getParameterValues("product");
	String[] listPrice_1	= request.getParameterValues("ListPrice");	//Internal user price
	String[] reqQty_1 = request.getParameterValues("Reqqty");
	String[] requiredPrice_1 = request.getParameterValues("requiredPrice");	//customer neg. price
	String[] soLineNo_1 = request.getParameterValues("soLineNo");	//Line Items
	String[] prevSapPrice_1 = request.getParameterValues("itemSAPPrice");	//prev sap price
	
	String prevPayTerm = request.getParameter("selPayTerm");	//prev pay term
	
	
	
	String UserRole = (String)session.getValue("UserRole");
	String salesAreaCode = (String)session.getValue("SalesAreaCode");

	int prodCodeLength = prodCode_1.length;
	
	String carrierName  	= request.getParameter("shippingTypeVal");

	String msg = null;
	String user = Session.getUserId();
	user=user.trim();
	
	boolean SAPnumber = true;

	ReturnObjFromRetrieve orderError = null;
	String ErrorType = "";
	String ErrorMessage = "";
   	String sDocNumber = null;
%>
<Html>
<Body>
<Form target=main>   
<%
	try
	{
%>		
		<%@ include file="../../../Includes/JSPs/Quotation/iEditSaveQuote.jsp"%>
<%
		//** file attachment **//

		String attachString = request.getParameter("attachString");

		if(attachString != null)
		{
			if(!"".equals(attachString))
			{
				String objNo 		= soNum;
				String documentType 	= "SQ";
%>
				<%@ include file="../UploadFiles/ezSaveAttachFiles.jsp" %>
<%
			}
		}

		//** file attachment **//
	}
	catch(Exception e)
	{
		System.out.println("Error in iEditSaveQuote.jsp");
	}
%>
</Form>
<Div id="MenuSol"></Div>
</Body>
</Html>
<jsp:forward page="../Misc/ezOutMsg.jsp"></jsp:forward>