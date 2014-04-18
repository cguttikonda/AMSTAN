  <%@ page import="java.util.*"%>
  <%@ include file="../../../Includes/Lib/ezShoppingCartBean.jsp"%>
  <jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
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
  <ul class="menu" >
    <li>
      <a href="../DrillDownCatalog/ezDrillDownVendorCatalog.jsp" onclick="alertall('1');chCartCol('7','#88BE5B')" onmouseover="chSpanCol('1','#0B305F')" onmouseout="chSpanCol('1','#88BE5B')">
        <b><span id="mspan1">
        <input type="hidden" name="clicked1" value"N">
        &nbsp;&nbsp;&nbsp;
        Find Product
        &nbsp;&nbsp;&nbsp;
        </span></b><em></em>
      </a>
    </li>
    <li>
      <a href="../Sales/ezManageOrdersFrameSet.jsp" onclick="alertall('2');chCartCol('7','#88BE5B')" onmouseover="chSpanCol('2','#0B305F')" onmouseout="chSpanCol('2','#88BE5B')">
        <b><span id="mspan2">
        <input type="hidden" name="clicked2" value"N">
        &nbsp;&nbsp;&nbsp;
        Manage Orders
        &nbsp;&nbsp;&nbsp;
        </span></b><em></em>
      </a>
    </li>
    <li>
      <a href="../Quotation/ezManageQuotesFrameSet.jsp" onclick="alertall('3');chCartCol('7','#88BE5B')" onmouseover="chSpanCol('3','#0B305F')" onmouseout="chSpanCol('3','#88BE5B')">
        <b><span id="mspan3">
        <input type="hidden" name="clicked3" value"N">
        &nbsp;&nbsp;&nbsp;
        Manage Quotes
        &nbsp;&nbsp;&nbsp;
        </span></b><em></em>
      </a>
    </li>
    <li>
      <a href="../SelfService/ezInvoicesFrameSet.jsp" onclick="alertall('4');chCartCol('7','#88BE5B')" onmouseover="chSpanCol('4','#0B305F')" onmouseout="chSpanCol('4','#88BE5B')">
        <b><span id="mspan4">
        <input type="hidden" name="clicked4" value"N">
        &nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Invoices&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;
        </span></b><em></em>
      </a>
    </li>
    <li>
      <a href="../SelfService/ezQuickSearch.jsp" onclick="alertall('5');chCartCol('7','#88BE5B')" onmouseover="chSpanCol('5','#0B305F')" onmouseout="chSpanCol('5','#88BE5B')">
        <b><span id="mspan5">
        <input type="hidden" name="clicked5" value"N">
        &nbsp;&nbsp;&nbsp;
        Order Search
        &nbsp;&nbsp;&nbsp;
        </span></b><em></em>
      </a>
    </li>
    <li>
      <a href="../SelfService/ezSelfServicesFrameSet.jsp" onclick="alertall('6');chCartCol('7','#88BE5B')" onmouseover="chSpanCol('6','#0B305F')" onmouseout="chSpanCol('6','#88BE5B')">
        <b><span id="mspan6">
        <input type="hidden" name="clicked6" value"N">
        &nbsp;&nbsp;&nbsp;
        Self Services
        &nbsp;&nbsp;&nbsp;
        </span></b><em></em>
      </a>
    </li>
    <li>
      <a href="../ShoppingCart/ezViewCart.jsp?fromMenu=Y" onclick="alertall('7');chCartCol('7','#0B305F')" onmouseover="chSpanCol('7','#0B305F');chCartCol('7','#0B305F')" onmouseout="chSpanCol('7','#88BE5B');chCartCol('7','#88BE5B')">
        <b><span id="mspan7">
        <input type="hidden" name="clicked7" value"N">
        &nbsp;
        Cart Items&nbsp;:&nbsp;
        <input type='text' id='cartHolder7' name='cartHolder' style='background-color:#88BE5B;color:white;font-size:9px;font-weight:bold;text-align:left' size=4 value='<%=cartItems%>' class= 'tx' readOnly>
        </span></b><em></em>
      </a>
    </li>
  </ul>
