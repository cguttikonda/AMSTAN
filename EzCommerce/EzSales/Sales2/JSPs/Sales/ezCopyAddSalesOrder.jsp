<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ page import="ezc.ezparam.*"%>
<%@ page import="ezc.client.*" %>
<%@ include file="../../../Includes/JSPs/Sales/iCopySalesDetails.jsp" %>
<%@ page import="ezc.shopping.cart.params.*" %>
<%@ page import="ezc.shopping.cart.client.*" %>
<%@ page import="ezc.shopping.cart.common.*" %>
<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>
<%

	EzShoppingCartManager SCManager = new EzShoppingCartManager( Session );
	EzcShoppingCartParams ezcShoppingCartParams =  new EzcShoppingCartParams();
	EziShoppingCartParams eziShoppingCartParams =  new EziShoppingCartParams();

	EziReqParams eziReqParams = new EziReqParams();
	FormatDate formatDate = new FormatDate();
	
	EzShoppingCart Cart = null;

	EzcShoppingCartParams paramsSh = new EzcShoppingCartParams();
        EziShoppingCartParams subparams = new EziShoppingCartParams();
             subparams.setLanguage("EN");
             paramsSh.setObject(subparams);
             Session.prepareParams(paramsSh);
	Cart = (EzShoppingCart)SCManager.getSavedCart(paramsSh);

	String [] dproducts = new String[Cart.getRowCount()];
	String [] dreqQtys  = new String[Cart.getRowCount()];
	String [] dreqDates = new String[Cart.getRowCount()];
	String [] dmatIDs   = new String[Cart.getRowCount()];
	
	 

        
	for(int i=0;i<Cart.getRowCount();i++)
	{
		dproducts[i]=Cart.getMaterialNumber(i); 
		dreqQtys[i] =Cart.getOrderQty(i);
		dreqDates[i]=Cart.getReqDate(i); 
		dmatIDs[i]  =Cart.getMatId(i);
	}
             EzcShoppingCartParams paramsCart = new EzcShoppingCartParams();
             EziReqParams reqparams = new EziReqParams();
             EziShoppingCartParams subparams1 = new EziShoppingCartParams();
             reqparams.setProducts(dproducts);
             reqparams.setMatId(dmatIDs);
             reqparams.setReqDate(dreqDates);
             reqparams.setReqQty(dreqQtys);
             subparams1.setLanguage("EN");
             subparams1.setEziReqParams(reqparams);
             subparams1.setObject(reqparams);
             paramsCart.setObject(subparams1);
             Session.prepareParams(paramsCart);
             Object retObjDelete = SCManager.deleteCartElement(paramsCart); 

	int len = myLineID.size();
	String[] amat = new String[len];
	String[] reqDates = new String[len];
	String[] reqQtys = new String[len];
	String[] vendCatalogs = new String[len];
	String[] matIds = new String[len];
	String tempProduct="";
	String custMat="";
	
	String soLine ="";
        int fIndex =0;
	
	
	String today =  FormatDate.getStringFromDate(new Date(),".",FormatDate.DDMMYYYY);
	
	out.println("=======>"+myLineID);
	for(int i=0;i<retLines.getRowCount();i++)
	{
		tempProduct=retLines.getFieldValueString(i,"PROD_CODE");
		custMat=retLines.getFieldValueString(i,"CUST_MAT");
		soLine=retLines.getFieldValueString(i,"SO_LINE_NO");
		
		if(myLineID.containsKey(soLine)){
				
			if(custMat!=null && !"null".equals(custMat))
				tempProduct = custMat;


			amat[fIndex]=tempProduct;

			reqDates[fIndex]=today;
			reqQtys[fIndex]=retLines.getFieldValueString(i,"DESIRED_QTY");
			vendCatalogs[fIndex]=retLines.getFieldValueString(i,"VENDOR_CATALOG");
			matIds[fIndex] = (String)myLineID.get(soLine);
			fIndex++;
		}
	}
	
	if ( ( amat  != null ))
	{
		 eziReqParams.setMatId(matIds);
		 eziReqParams.setProducts(amat);
           	 eziReqParams.setReqDate(reqDates);
		 eziReqParams.setReqQty(reqQtys);
		 eziReqParams.setVendorCatalogs(vendCatalogs);
		 
		 eziShoppingCartParams.setType("AF");
		 eziShoppingCartParams.setLanguage("EN");

		eziShoppingCartParams.setEziReqParams(eziReqParams);
		ezcShoppingCartParams.setObject(eziShoppingCartParams);
		Session.prepareParams(ezcShoppingCartParams);
		try{
		ReturnObjFromRetrieve ret = (ReturnObjFromRetrieve)SCManager.saveCart(ezcShoppingCartParams);
		}catch(Exception e){out.println(e); }
		
		amat = null;
		reqQtys  = null;
		reqQtys  = null;
	}
	String RefDocType=request.getParameter("RefDocType");


if(session.getAttribute("getprices")!=null)
{
	session.removeAttribute("getprices");
	session.removeAttribute("getValues");
}


String payterms="";
String genernotes = "";
String inco2 ="";
String inco1 ="";
String carrierName ="";

	payterms = sdHeader.getFieldValueString(0,"PAYMENT_TERMS");
	genernotes =  sdHeader.getFieldValueString(0,"TEXT1");
	inco2 = sdHeader.getFieldValueString(0,"INCO_TERMS2");
	inco1 = sdHeader.getFieldValueString(0,"INCO_TERMS1") ;
	carrierName = sdHeader.getFieldValueString(0,"REF1") ;
	
//log4j.log("sdHeadersdHeadersdHeadersdHeader::"+listShipTos.toEzcString(),"W");	
//sdHeader.toEzcString();
 
%>


<jsp:forward page="ezAddSalesSh.jsp"> 
	<jsp:param name="from" value="ezAddSales"/>
	<jsp:param name="reorder" value="reorder" />
	<jsp:param name="Payterms" value="<%= payterms %>" />
	<jsp:param name="generalNotes" value="<%= genernotes %>"/>
	<jsp:param name="inco2" value="<%= inco2 %>"/>
	<jsp:param name="carrierName" value="<%=carrierName%>"/>
	<jsp:param name="inco1" value="<%= inco1%>"/>
</jsp:forward> 
