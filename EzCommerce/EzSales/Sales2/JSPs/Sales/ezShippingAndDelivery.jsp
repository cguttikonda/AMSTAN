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
	   	 parent.document.getElementById("subDisplay").src="../DeliverySchedules/ezGetDeliveryNos.jsp";
	   else if(obj=='2')
	  	 parent.document.getElementById("subDisplay").src="../DeliverySchedules/ezViewDispatchLocal.jsp?Stat=R&qFlag=ALL";
	   else if(obj=='3')
	  	  	 parent.document.getElementById("subDisplay").src="../DeliverySchedules/ezViewDispatchLocal.jsp?Stat=D&qFlag=ALL";
	   else if(obj=='4')
	  	 parent.document.getElementById("subDisplay").src="../DeliverySchedules/ezViewDispatchLocal.jsp?Stat=R&qFlag=ALL";

	   
	   	 
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

<h3 class="headerbar">Shipping & Delivery</h3>
<ul>
<%	if("CM".equals((String)session.getValue("UserRole")))
	{
%>
	<li><a href="javascript:funclick('1')">Create Shipment</a></li>
	<li><a href="javascript:funclick('2')">Acknowledged</a></li>
<%
	}
	else
	{
%>
	<li><a href="javascript:funclick('3')">To Be Acknowledged</a></li>
	<li><a href="javascript:funclick('4')">Acknowledged</a></li>
<%
	}
%>
</ul>

</div>


</form>
<Div id="MenuSol"></Div>
</Body>
</Html>

  