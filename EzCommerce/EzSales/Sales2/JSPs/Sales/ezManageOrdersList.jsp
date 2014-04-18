<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%
    String userRole = (String)session.getValue("UserRole");
%>

<HTML>
<HEAD>
<script>
	 function funclick(obj)
	 {
	 
	 	
	   if(obj=='1')
	   	 parent.document.getElementById("subDisplay").src="../Sales/ezProductEntry.jsp";
	   else if(obj=='2')
	  	 parent.document.getElementById("subDisplay").src="../Sales/ezCreateSalesOrder.jsp";
	   else if(obj=='3')
	   	 parent.document.getElementById("subDisplay").src="../Sales/ezCopySalesOrder.jsp";
	   else if(obj=='4')
	  	 top.document.getElementById("display").src="../ShoppingCart/ezViewCart.jsp?pageFlg=Y";
	   else if(obj=='5')
	   	 parent.document.getElementById("subDisplay").src="../Sales/ezBackEndSOList.jsp?RefDocType=P";
 	   else if(obj=='6')
	  	 parent.document.getElementById("subDisplay").src="../Sales/ezBackEndClosedSOList.jsp?RefDocType=P&DatesFlag=DATES";
	   else if(obj=='7')
	   	 parent.document.getElementById("subDisplay").src="../Sales/ezSubmittedOrdersList.jsp?orderStatus='TRANSFERED'&RefDocType=P";
	   else if(obj=='8')
	   	 parent.document.getElementById("subDisplay").src="../Sales/ezSavedOrdersList.jsp?orderStatus='NEW'&RefDocType=P";
	   else if(obj=='9')
	   	 parent.document.getElementById("subDisplay").src="../Quotation/ezSavedOrdersList.jsp?orderStatus='APPROVED'";
	   else if(obj=='10')
	   	 parent.document.getElementById("subDisplay").src="../Quotation/ezSubmittedQuotesList.jsp?orderStatus='REJECTED'";
	   else if(obj=='11')
	   	 parent.document.getElementById("subDisplay").src="../Quotation/ezSubmittedQuotesList.jsp?orderStatus='SUBMITTED'";
	   else if(obj=='12')
	   	 parent.document.getElementById("subDisplay").src="../Quotation/ezSubmittedQuotesList.jsp?orderStatus='SUBMITTED'&toAct=Y";
	   else if(obj=='13')
	   	 parent.document.getElementById("subDisplay").src="../Sales/ezSavedOrdersList.jsp?orderStatus='NEGOTIATED'&RefDocType=P";   	 
	   	 
	 }
	 
	 function hideStatus()
	 {
	 window.status="";
	 return true;
	 
	 }
	 
</script> 
<Style>
	
	
	/*
	a.subclass:active {color: white}
	a.subclass:hover {color: white}
	a.subclass:link {color: white}
	a.subclass:visited{color: white}
        */
	
	a{
	   color: #30366A;
	   text-decoration:none;
	}
	
	a:link{
	   color:#3398CC; 
	   text-decoration:none;
	   
	}
	
	a:hover{
	   color: #FF0000;
	   text-decoration:underline;
	   
	}
	a:visited{
	    color:#3398CC; 
	    text-decoration:none;
	}
	
	}
	
</Style>
</Head>

<Body scroll=NO bgcolor="#FFFFFF">
<Form name="myForm" method="post">
<BR>
<div class="urbangreymenu">

<h3 class="headerbar">Create Order</h3>
<ul>
<!--<li><a href="javascript:funclick('2')" onMouseOver="return hideStatus()">By Favorites</a></li>-->
<!--<li><a href="javascript:funclick('3')" onMouseOver="return hideStatus()">By Copy Order</a></li>-->
<li><a href="javascript:funclick('4')" onMouseOver="return hideStatus()">From Shopping Cart</a></li>
</ul>

<h3 class="headerbar">View Orders</h3>
<ul>
<%
	//if("CM".equals((String)session.getValue("UserRole")))
	//{
%>
	<li><a href="javascript:funclick('5')" onMouseOver="return hideStatus()">Open Orders</a></li>
	<li><a href="javascript:funclick('6')" onMouseOver="return hideStatus()">Closed Orders</a></li>
<%
	//}
	//else
	//{
%>
	<!--<li><a href="javascript:funclick('7')" onMouseOver="return hideStatus()">Submitted Orders</a></li>-->
<%
	//}

	if("CU".equals((String)session.getValue("UserRole")))
	{
%>
		<li><a href="javascript:funclick('8')" onMouseOver="return hideStatus()">Saved Orders</a></li>
<%
	}
%>
	<li><a href="javascript:funclick('13')" onMouseOver="return hideStatus()">In Review Orders</a></li>
	

</ul>
<!--
<h3 class="headerbar">Quotes</h3>
<ul>
<li><a href="javascript:funclick('9')" onMouseOver="return hideStatus()">Approved Quotes</a></li>
<li><a href="javascript:funclick('10')" onMouseOver="return hideStatus()">Rejected Quotes</a></li>
<%
	if("CM".equals((String)session.getValue("UserRole")))
	{
%>
	<li><a href="javascript:funclick('11')" onMouseOver="return hideStatus()">Submitted Quotes</a></li>
<%
	}
	else if("CU".equals((String)session.getValue("UserRole")))
	{
%>
	<li><a href="javascript:funclick('12')" onMouseOver="return hideStatus()">To Act Quotes</a></li>
<%
	}
%>
</ul>
-->
</div>




</form>
<Div id="MenuSol"></Div>
</Body>
</Html>

  