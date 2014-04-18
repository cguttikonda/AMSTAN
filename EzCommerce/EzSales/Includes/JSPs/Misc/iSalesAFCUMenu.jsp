<%@ page import="java.util.*"%>
<%@ include file="../../../Includes/Lib/ezShoppingCartBean.jsp"%>
<%
  	int cartCount =0;
  	try{
		EzShoppingCart Cart = null;
		EzcShoppingCartParams params = new EzcShoppingCartParams();
		EziShoppingCartParams subparams = new EziShoppingCartParams();
		subparams.setLanguage("EN");
		params.setObject(subparams);
		Session.prepareParams(params);
		Cart = (EzShoppingCart)SCManager.getSavedCart(params);
		cartCount =Cart.getRowCount();
		
        }catch(Exception err){}

%>
<div id=ezDiv1  onMouseOver="ezMouseOver1('ezDiv1',0);" style="Position:absolute;top:2;left:0%;width:15%" >
<TABLE class=menutext width="100%" align=right  border=0 cellPadding=2 cellSpacing=0 bgcolor='#3398CC'>
<Tr>
    <Th class=menutext align="center" height = 30  valign="center">
	<a  style="text-decoration:none"  class=menuclass href="../DrillDownCatalog/ezDrillDownVendorCatalog.jsp"  target='display'  onMouseover="window.status=' '; return true" onMouseout="window.status=' '; return true">
	Find Product
	</a>
    </th>
</Tr>
</Table>
</div>
<div id="ezDiv2"  onMouseOver="ezMouseOver1('ezDiv2',14);"  style="Position:absolute;top:2;left:14%;width:14%">
<TABLE class=menutext width="100%" align=right  border=0 cellPadding=2 cellSpacing=0 bgcolor='#3398CC'>
<Tr>
    <Th class=menutext align="center" height = 30  valign="center" nowrap>

	<a  style="text-decoration:none"  class=menuclass href="../Sales/ezManageOrdersFrameSet.jsp"  target='display'  onMouseover="window.status=' '; return true" onMouseout="window.status=' '; return true">
	Manage Orders
	</a>
    </th>
</Tr> 
</Table>
</div>

<div id="ezDiv3"  onMouseOver="ezMouseOver1('ezDiv8',28);"  style="Position:absolute;top:2;left:27%;width:15%">
<TABLE class=menutext width="100%" align=right  border=0 cellPadding=2 cellSpacing=0 bgcolor='#3398CC'>
<Tr>
    <Th class=menutext align="center" height = 30  valign="center" nowrap>

	<a  style="text-decoration:none"  class=menuclass href="../Sales/ezShippingAndDeliveryFrameSet.jsp"  target='display'  onMouseover="window.status=' '; return true" onMouseout="window.status=' '; return true">
	Shipping & Delivery
	</a>
    </th>
</Tr>
</Table>
</div>

<div id="ezDiv4" onMouseOver="ezMouseOver1('ezDiv3',42);" style="Position:absolute;top:2;left:42%;width:15%">
<TABLE class=menutext width="100%" align=right  border=0 cellPadding=2 cellSpacing=0 bgcolor='#3398CC'>
<Tr>
    <Th class=menutext align="center" height = 30  valign="center">

	<a  style="text-decoration:none" class=menuclass href="../SelfService/ezQuickSearch.jsp" target="display"  onMouseover="window.status=' '; return true" onMouseout="window.status=' '; return true">
	Web Search
	</a>
    </th>
</Tr>
</Table>
</div>
<div id="ezDiv5"  onMouseOver="ezMouseOver1('ezDiv4',56);"  style="Position:absolute;top:2;left:56%;width:14%">
<TABLE class=menutext width="100%" align=right  border=0 cellPadding=2 cellSpacing=0 bgcolor='#3398CC'>
<Tr>
    <Th class=menutext align="center" height = 30  valign="center" nowrap>

	<a  style="text-decoration:none"  class=menuclass href="../FAQs/ezFaqs.jsp"  target='display'  onMouseover="window.status=' '; return true" onMouseout="window.status=' '; return true">
	FAQs
	</a>
    </th>
</Tr>
</Table>
</div>

<div id="ezDiv6"  onMouseOver="ezMouseOver1('ezDiv7');"  style="Position:absolute;top:2;left:70%;width:14%">
<TABLE class=menutext width="100%" align=right  border=0 cellPadding=2 cellSpacing=0 bgcolor='#3398CC'>
<Tr>
    <Th class=menutext align="center" height = 30  valign="center" nowrap>

	<a  style="text-decoration:none" class=menuclass href="../Misc/ezContactInfo.jsp" target="display"  onMouseover="window.status=' '; return true" onMouseout="window.status=' '; return true">
		Contact US
	</a>
    </th>
</Tr>
</Table>
</div>

<div id="ezDiv7"  onMouseOver="ezMouseOver1('ezDiv5',84);"  style="Position:absolute;top:2;left:84%;width:16%">
<TABLE class=menutext width="100%" align=right  border=0 cellPadding=2 cellSpacing=0 bgcolor='red'>
<Tr>
    <Th class=menutext align="left" height = 30  valign="center" >

	<a  style="text-decoration:none"  class=menuclass href="../ShoppingCart/ezViewCart.jsp?fromMenu=Y"  target='display'  onMouseover="window.status=' '; return true" onMouseout="window.status=' '; return true">
	<img src="../../../../EzCommon/Images/Common/shop_cart.GIF" border=0 align=middle>
	Cart:<input type='text' name='cartHolder' style='background-color:red;color:white;font-size:12px;font-weight:bold;text-align:right' size=2 value='<%=cartCount%>' class= 'tx' readOnly>Items
	</a>
    </th>
</Tr>
</Table> 
</div>