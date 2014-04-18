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
	   	 parent.document.getElementById("subDisplay").src="../SelfService/ezGridOpenInvoices.jsp?&FromForm=OpenInvoiceList";
	   else if(obj=='2')
	  	 parent.document.getElementById("subDisplay").src="../SelfService/ezGridClosedInvoices.jsp?DatesFlag=DATES";
	   else if(obj=='3')
	   	 parent.document.getElementById("subDisplay").src="../SelfService/ezInvoicesAging.jsp";	   	 
	   else if(obj=='4')
		 parent.document.getElementById("subDisplay").src="../SelfService/ezAcCopy.jsp";
		 

	 }
	 function hideStatus()
	 {
	 	window.status="";
	 	return true;
	 }
	 
</script> 
<Style>
	
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

<h3 class="headerbar">Invoices</h3>
<ul>
<li><a href="javascript:funclick('1')" onMouseOver="return hideStatus()">Open Invoices</a></li>
<li><a href="javascript:funclick('2')" onMouseOver="return hideStatus()">Closed Invoices</a></li>
<li><a href="javascript:funclick('3')" onMouseOver="return hideStatus()">Aging</a></li>
<li><a href="javascript:funclick('4')" onMouseOver="return hideStatus()">Account Statement</a></li>
</ul>

</div>

</form>
<Div id="MenuSol"></Div> 
</Body>
</Html>

  