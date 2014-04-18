  <%@ page import="java.util.*"%>
  <%@ include file="../../../Includes/Lib/ezShoppingCartBean.jsp"%>
  <%
    	int cartCount =0;
    	int cartItems =0;
    	
    	try{
  		EzShoppingCart Cart = null;
  		EzcShoppingCartParams params = new EzcShoppingCartParams();
  		EziShoppingCartParams subparams = new EziShoppingCartParams();
  		subparams.setLanguage("EN");
  		params.setObject(subparams);
  		Session.prepareParams(params);
  		Cart = (EzShoppingCart)SCManager.getSavedCart(params);
  		cartCount =Cart.getRowCount();
  		
  		if(Cart!=null && cartCount>0){
  			for(int i=0;i<cartCount;i++){
  			    try{
  				 cartItems+=Double.parseDouble(Cart.getOrderQty(i));
  			    }catch(Exception e){
  			    }
  			} 
  		}
  		
  		
  		
          }catch(Exception err){}
  
  %>
  
  <ul class="menu">
    <li style="width:30%">
      <a style="width:100%" href="../DrillDownCatalog/ezDrillDownVendorCatalog.jsp" onclick="alertall('1');chCartCol('2','#88BE5B')" onmouseover="chSpanCol('1','#0B305F')" onmouseout="chSpanCol('1','#88BE5B')">
        <b><span id="mspan1" style="width:100%">
        <input type="hidden" name="clicked1" value"N">
        &nbsp;&nbsp;&nbsp;
        Find Product
        &nbsp;&nbsp;&nbsp;
        </span></b><em></em>
      </a>
    </li>
    <li style="width:30%">
      <a style="width:100%" href="../ShoppingCart/ezViewCart.jsp?fromMenu=Y" onclick="alertall('2');chCartCol('2','#0B305F')" onmouseover="chSpanCol('2','#0B305F');chCartCol('2','#0B305F')" onmouseout="chSpanCol('2','#88BE5B');chCartCol('2','#88BE5B')">
        <b><span id="mspan2" style="width:100%">
        <input type="hidden" name="clicked2" value"N">
        &nbsp;
        View Cart&nbsp;&nbsp;
        <input type='text' id='cartHolder2' name='cartHolder' style='background-color:#88BE5B;color:white;font-size:9px;font-weight:bold;text-align:left' size=4 value='' class= 'tx' readOnly>
        </span></b><em></em>
      </a>
    </li>
  </ul>
