<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>
<%@ include file="../../../Includes/JSPs/Sales/iGetShoppingCart.jsp"%>

<%
	String product[]=request.getParameterValues("product");
	String productDesc[]=request.getParameterValues("productDesc");
	String uom[]=request.getParameterValues("uom");
	String qty[]=request.getParameterValues("qty");
	String caseLot[]=request.getParameterValues("caseLot");
	String vendCatalogs[]=request.getParameterValues("VendCatalog");
	String reqDates[]=null;
	String flgBack 	= request.getParameter("bkpflg");
	
	
	/*
	for(int i=0;i<product.length;i++)
	{
		try{
		 		
		 		String productNoTemp=""+Integer.parseInt(product[i]);
		 		productNoTemp="000000000000000000"+productNoTemp;
		 		product[i]=productNoTemp.substring(productNoTemp.length()-18,productNoTemp.length());
		 		
 		}catch(Exception err){}
	}
	*/
	
	java.util.Vector prodFinCode=new java.util.Vector();
	java.util.Vector productDescFin=new java.util.Vector();
	java.util.Vector uomFin=new java.util.Vector();
	java.util.Vector qtyFin=new java.util.Vector();
	java.util.Vector catalgFin=new java.util.Vector();
	
	java.util.Hashtable mySelProd=new java.util.Hashtable();
	int noOfProds=0;
	if(product!=null)
	noOfProds=product.length;
	if(noOfProds>0){
		String prodCodeTemp="";
		for(int i=0;i<noOfProds;i++){
			prodCodeTemp=product[i];
			if(prodCodeTemp!=null && !"null".equals(prodCodeTemp) && !"".equals(prodCodeTemp.trim())){
				prodFinCode.add((product[i]).toLowerCase());
				productDescFin.add(productDesc[i]);
				uomFin.add(uom[i]);
				qtyFin.add(qty[i]);
				catalgFin.add(vendCatalogs[i]);
				mySelProd.put((product[i]).toLowerCase(),caseLot[i]);
			}
			
		}
		
		
	}
	
	session.putValue("MYSELPRODS",mySelProd);
	
	params 		= new EzcShoppingCartParams();
	subparams 	= new EziShoppingCartParams();
	EziReqParams reqparams= new EziReqParams();
	if(Cart!=null)
	{
		String [] dproducts = new String[Cart.getRowCount()];
		String [] dreqQtys  = new String[Cart.getRowCount()];
		String [] dreqDates = new String[Cart.getRowCount()];
		for(int i=0;i<Cart.getRowCount();i++)
		{
			dproducts[i]	=Cart.getMaterialNumber(i);
			dreqQtys[i]	=Cart.getOrderQty(i);
			dreqDates[i]	=Cart.getReqDate(i);
			
		}
		reqparams.setProducts(dproducts);
		reqparams.setReqDate(dreqDates);
		reqparams.setReqQty(dreqQtys);
		subparams.setLanguage("EN");
		subparams.setEziReqParams(reqparams);
		subparams.setObject(reqparams);
		params.setObject(subparams);
		Session.prepareParams(params);
		Object retObjDelete = SCManager.deleteCartElement(params); 
	}
	
	
	int finalCount=prodFinCode.size();
	if(finalCount>0){
		product=new String[finalCount];
		productDesc=new String[finalCount];
		uom=new String[finalCount];
		qty=new String[finalCount];
		reqDates=new String[finalCount];
		vendCatalogs=new String[finalCount];
		for(int i=0;i<finalCount;i++){
			product[i]=(String)prodFinCode.get(i);
			productDesc[i]=(String)productDescFin.get(i);
			uom[i]=(String)uomFin.get(i);
			qty[i]=(String)qtyFin.get(i);
			reqDates[i]="1.11.1000";
			vendCatalogs[i]=(String)catalgFin.get(i);
			
			
		}
		
		
		params 	  = new EzcShoppingCartParams();
		subparams = new EziShoppingCartParams();
		reqparams = new EziReqParams();

		reqparams.setProducts(product);
		reqparams.setReqDate(reqDates);
		reqparams.setReqQty(qty);
		reqparams.setVendorCatalogs(vendCatalogs);
		subparams.setType("AF");
                subparams.setLanguage("EN");
		subparams.setEziReqParams(reqparams);
		params.setObject(subparams);
		Session.prepareParams(params);
		try{
			SCManager.saveCart(params);
		}catch(Exception e){}
		
		
	}
	

	
if(!flgBack.equals("QuickOrdEntBk"))
{
%>
<jsp:forward page="ezAddSalesSh.jsp?RefDocType=P&shop=shop&bkpflg=Manual"/>

<%
}else{
%>
<jsp:forward page="ezAddSalesSh.jsp?RefDocType=P&shop=shop&bkpflg=QuickOrdEntBk"/>                

<%
}
   %>