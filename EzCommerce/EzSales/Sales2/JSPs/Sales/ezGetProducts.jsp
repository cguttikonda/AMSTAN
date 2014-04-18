<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezShoppingCartBean.jsp"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%
      EzShoppingCart 		Cart 	  = null;
      EzcShoppingCartParams 	params 	  = new EzcShoppingCartParams();
      EziShoppingCartParams 	subparams = new EziShoppingCartParams();
      subparams.setLanguage("EN");
      params.setObject(subparams);
      Session.prepareParams(params);
      Cart = (EzShoppingCart)SCManager.getSavedCart(params);
      
      ezc.client.EzcUtilManager UtilManager = new ezc.client.EzcUtilManager(Session);
      String defSoldTo 	= UtilManager.getUserDefErpSoldTo();
      String SoldTo	= request.getParameter("soldTo");
      	
      // this part of code is to delete the products from cart in any
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
      
      String proCode 	    	 = request.getParameter("prodCode");
      log4j.log("proCodeproCodeproCodeproCodeproCodeproCodeproCodeproCodeproCodeproCode"+proCode,"W");
      StringTokenizer proCode_St = new StringTokenizer(proCode,",");
      int proCode_St_Count 	 = proCode_St.countTokens();      
      String[] pCode 	    	 = new String[proCode_St_Count];
      
      for(int d=0;d<proCode_St_Count;d++)
      {
		pCode[d] = proCode_St.nextToken();
      }	

      String[] oldProdCode  = request.getParameterValues("oldprodCode");      
      String[] pQty 	    = request.getParameterValues("prodQty");
      	
      String[] prodCode = new String[pCode.length];
      String[] prodDate = new String[pCode.length];
      String[] prodQty  = new String[pCode.length];      
      
      for(int i=0;i<pCode.length;i++)
      {
      	     prodCode[i] = pCode[i];			//.substring(0,pCode[i].indexOf(",")); 
      	     prodDate[i] ="1.11.1000"; 			// what ever format it is pls don't delete it,as it reflects in more than one place            
      	     if(pQty != null && oldProdCode != null) 	// if old prodcode and old prod qty that comes on clicking back != null
      	     {
      		     for(int j=0;j<oldProdCode.length;j++)
      		     {	
      			    if(prodCode[i].equals(oldProdCode[j]))
      			    {
      				     prodQty[i] =pQty[j];
      			    }
      		     }
      		     if(prodQty[i]==null || "null".equals(prodQty[i]) || prodQty[i].trim().length() ==0)
      				prodQty[i] ="0";
      	     }
      	     else
      		    prodQty[i] ="0";	      			
      }
       
      params 	= new EzcShoppingCartParams();
      subparams = new EziShoppingCartParams();
      reqparams = new EziReqParams();
      
      reqparams.setProducts(prodCode);
      reqparams.setReqDate(prodDate);
      reqparams.setReqQty(prodQty);      
      subparams.setEziReqParams(reqparams);
      params.setObject(subparams);
      Session.prepareParams(params);
      try{
      		SCManager.saveCart(params);
      }catch(Exception e){
      }
      
      params 	  = new EzcShoppingCartParams();
      subparams   = new EziShoppingCartParams();
      subparams.setLanguage("EN");
      params.setObject(subparams);
      Session.prepareParams(params);
      Cart = (EzShoppingCart)SCManager.getSavedCart(params); 
%>