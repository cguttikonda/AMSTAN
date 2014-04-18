<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezShoppingCartBean.jsp"%>
<%@ page import="ezc.ezprojections.params.*" %>
<jsp:useBean id="ProjManager" class="ezc.ezprojections.client.EzProjectionsManager" />
<%
    
     
	EzShoppingCart Cart = null;
	EzcShoppingCartParams params = new EzcShoppingCartParams();
	EziShoppingCartParams subparams = new EziShoppingCartParams();
	subparams.setLanguage("EN");
	params.setObject(subparams);
	Session.prepareParams(params);
	Cart = (EzShoppingCart)SCManager.getSavedCart(params);
	int cartcount= 0;
	int cartItems= 0;
	cartcount= Cart.getRowCount();
	
	for(int i=0;i<cartcount;i++){
		try{
		     cartItems+=Double.parseDouble(Cart.getOrderQty(i));
		}catch(Exception e){
		}
	}
	
	
	String[] upcNo=new String[cartcount];
	if(session.getAttribute("getprices")==null)
	{

		/*
		ReturnObjFromRetrieve retpro=null;
		String skey=(String) session.getValue("SalesAreaCode");

		EzcParams ezcpparams = new EzcParams(true);
		EziProjectionHeaderParams inparamsProj=new EziProjectionHeaderParams();
		inparamsProj.setSystemKey(skey);
		inparamsProj.setUserCatalog((String) session.getValue("CatalogCode"));
		ezcpparams.setObject(inparamsProj);
		ezcpparams.setLocalStore("Y");
		Session.prepareParams(ezcpparams);
		retpro = (ReturnObjFromRetrieve)ProjManager.ezGetMaterialsByCountry(ezcpparams);
	
	        log4j.log("retproretpro::::::::"+retpro.toEzcString(),"W");
	        
		Hashtable selMet= new Hashtable();
		if(cartcount > 0)
		{
		    int tMetCount=retpro.getRowCount();
		    for(int i=0;i<cartcount;i++)
		    {
			System.out.println(Cart.getMaterialNumber(i));
			for(int m=0;m<tMetCount;m++)
			{
				if((Cart.getMaterialNumber(i)).equals(retpro.getFieldValueString(m,"MATNO")))
				{
					selMet.put(retpro.getFieldValueString(m,"MATNO"),retpro.getFieldValueString(m,"GROUP_ID")+","+retpro.getFieldValueString(m,"UPC_NO"));
					upcNo[i]=retpro.getFieldValueString(m,"UPC_NO");
				}
			}
		    }
		}
		*/
		
		Hashtable selMet= new Hashtable();
		if(cartcount > 0)
		{
		  
		    for(int i=0;i<cartcount;i++)
		    {
			System.out.println(Cart.getMaterialNumber(i));
			
			selMet.put(Cart.getMaterialNumber(i),""+","+"1");
			upcNo[i]="1";
			
		    }
		}
		
		
		session.putValue("SELECTEDMET",selMet);
	}

	String inco1 = request.getParameter("inco1");
	String inco2 = request.getParameter("inco2");
	String Payterms = request.getParameter("payterms");
	String generalNotes = request.getParameter("generalNotes");

	Hashtable getFOC = new Hashtable();

	String SCDocNr = request.getParameter("scDocNr");

	String shop = request.getParameter("shop");
	Hashtable getprices = new Hashtable();
	//ezc.ezbasicutil.EzCurrencyFormat myFormat = new	ezc.ezbasicutil.EzCurrencyFormat("Rs",false,false);
	String from = request.getParameter("from");
	//String inco1 = request.getParameter()
	if(from != null)
	{
		session.removeAttribute("getprices");
		session.removeAttribute("getFOC");
	}

	if(session.getAttribute("getprices")!=null)
	{
	  getprices =(Hashtable)session.getAttribute("getprices");
	  getFOC =(Hashtable)session.getAttribute("getFOC");
	}
	
	/*	
		ReturnObjFromRetrieve retpro=null;
		String skey=(String) session.getValue("SalesAreaCode");
	
		EzcParams ezcpparams = new EzcParams(true);
		EziProjectionHeaderParams inparamsProj=new EziProjectionHeaderParams();
		inparamsProj.setSystemKey(skey);
		inparamsProj.setUserCatalog((String) session.getValue("CatalogCode"));
		ezcpparams.setObject(inparamsProj);
		ezcpparams.setLocalStore("Y");
		Session.prepareParams(ezcpparams);
		retpro = (ReturnObjFromRetrieve)ProjManager.ezGetMaterialsByCountry(ezcpparams);
                
	
	Hashtable selMet= new Hashtable();
	int tMetCount=retpro.getRowCount();
	for(int m=0;m<tMetCount;m++)
	{
		selMet.put(retpro.getFieldValueString(m,"MATNO"),(retpro.getFieldValueString(m,"UPC_NO")).trim());
	}
	*/
	
	Hashtable selMet= new Hashtable();
		
	if(cartcount > 0)
	{

	    for(int i=0;i<cartcount;i++)
	    {
		System.out.println(Cart.getMaterialNumber(i));

		selMet.put(Cart.getMaterialNumber(i),"1");
				
	    }
	}
	if(session.getAttribute("getprices") != null)
	{
		session.removeAttribute("getprices");
	}
%>