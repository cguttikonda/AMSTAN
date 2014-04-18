<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%
	String isSubUser = (String)session.getValue("IsSubUser");

	if(isSubUser==null || "null".equals(isSubUser.trim()) || "".equals(isSubUser.trim()))	isSubUser="N";

	String userRole = (String)session.getValue("UserRole");
	String userType = (String)session.getValue("UserType");
%>

<HTML>
<HEAD>
<script>
	 function funclick(obj)
	 {
	   if(obj=='1')
		 window.open('../SelfService/AF RGA FORM.pdf','RGAForm',"resizable=yes,left=280,top=120,height=400,width=600,status=no,toolbar=no,menubar=no,location=no");
	   else if(obj=='2')
	   	window.open('../SelfService/Credit Application Form/AF RGA FORM.pdf','RGAForm',"resizable=yes,left=280,top=120,height=400,width=600,status=no,toolbar=no,menubar=no,location=no");
	   else if(obj=='3')
	   	 parent.document.getElementById("display").src="../FAQs/ezFaqs.jsp";
	   else if(obj=='4')
	  	 parent.document.getElementById("display").src="../Misc/ezContactInfo.jsp";
	   else if(obj=='5')
	  	 parent.document.getElementById("display").src="../SelfService/ezPassword.jsp";
	   else if(obj=='6')
	  	 parent.document.getElementById("display").src="../Cnet/ezListCustomerCnetCat.jsp";
	   else if(obj=='7')
	     	 parent.document.getElementById("display").src="../Discounts/ezGetDiscounts.jsp";
	   else if(obj=='8')
	     	 parent.document.getElementById("display").src="../Discounts/ezCreateDiscount.jsp";
	   else if(obj=='9')
	     	 parent.document.getElementById("display").src=location.protocol+"//<%=request.getServerName()%>/CRIREP/ezCatUserLogin.jsp?USERNAME=catuser&PASSWORD=portal&HOOK_URL=http://www.answerthink.com";
	   else if(obj=='10')
	     	 parent.document.getElementById("display").src="../Analytics/mytestHTML-All.jsp";
	   else if(obj=='11')
	     	 parent.document.getElementById("display").src="../Misc/ezAddSubUser.jsp";
	   else if(obj=='12')
	     	 parent.document.getElementById("display").src="../Misc/ezListSubUsers.jsp";
	   else if(obj=='13')
	     	 parent.document.getElementById("display").src="../SelfService/ezCustomerList.jsp";
	   else if(obj=='14')
	     	 parent.document.getElementById("display").src="../SelfService/ezEmailNotification.jsp";
	   else if(obj=='20')
	     	 top.document.getElementById("display").src="../Cnet/ezCnetTest.jsp";

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

<h3 class="headerbar">Self Services</h3>
<ul>
<!--<li><a href="javascript:funclick('3')" onMouseOver="return hideStatus()">FAQs</a></li>-->
<li><a href="javascript:funclick('4')" onMouseOver="return hideStatus()">Contact US</a></li>
<%
	if("3".equals(userType))
	{
%>
		<li><a href="javascript:funclick('5')">Change Password</a></li>
<%
	}
	if("CM".equals(userRole))
	{
%>
		<li><a href="javascript:funclick('10')" onMouseOver="return hideStatus()">Analytics</a></li>
		<li><a href="javascript:funclick('6')" onMouseOver="return hideStatus()">Customer Categories</a></li>
		<li><a href="javascript:funclick('7')" onMouseOver="return hideStatus()">Discounts List</a></li>
		<li><a href="javascript:funclick('8')" onMouseOver="return hideStatus()">Create Discount</a></li>
		<li><a href="javascript:funclick('14')" onMouseOver="return hideStatus()">Email Notification</a></li>
		<li><a href="javascript:funclick('13')" onMouseOver="return hideStatus()">Reset Customer Password</a></li>
<%
	}
	//out.println("isSubUser::"+isSubUser+"**");
	if("CU".equals(userRole) && "N".equals(isSubUser))
	{
%>
		<li><a href="javascript:funclick('11')">Add Sub-User</a></li>
		<li><a href="javascript:funclick('12')">Sub-Users List</a></li>
<%
	}
%>
<!--<li><a href="javascript:funclick('9')" onMouseOver="return hideStatus()">OCI</a></li>-->
</ul>

</div>
<!--<a href="javascript:funclick('20')" onMouseOver="return hideStatus()">.</a>-->
</form>
<Div id="MenuSol"></Div> 
</Body>
</Html>

  