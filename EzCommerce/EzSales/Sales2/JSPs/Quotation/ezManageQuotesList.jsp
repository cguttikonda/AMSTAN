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
	   if(obj=='9')
	   	 parent.document.getElementById("subDisplay").src="../Quotation/ezSubmittedQuotesList.jsp?orderStatus='APPROVED'";
	   else if(obj=='10')
	   	 parent.document.getElementById("subDisplay").src="../Quotation/ezSubmittedQuotesList.jsp?orderStatus='REJECTED'";
	   else if(obj=='11')
	   	 parent.document.getElementById("subDisplay").src="../Quotation/ezSubmittedQuotesList.jsp?orderStatus='SUBMITTED'";
	   else if(obj=='12')
	   	 parent.document.getElementById("subDisplay").src="../Quotation/ezSubmittedQuotesList.jsp?orderStatus='SUBMITTED'&toAct=Y";
	   	 
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
	<li><a href="javascript:funclick('12')" onMouseOver="return hideStatus()">Quotes Pending</a></li>
<%
	}
%>
</ul>

</div>
</form>
<Div id="MenuSol"></Div>
</Body>
</Html>

  