<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"/>
<%
	String userEmail = (String)session.getValue("USEREMAIL");
	String userFName = (String)session.getValue("FIRSTNAME");
	String userLName = (String)session.getValue("LASTNAME");
	String userLang  = (String)session.getValue("userLang");
	String imageAuth = (String)session.getValue("SHOWIMAGES"); 
	//out.println("userEmail::::::::::::::"+userEmail);
	String checked = "";
	if("Y".equals(imageAuth))
		checked = "checked";
%>

<!--form validations-->
<Script src="../../Library/Script/popup.js"></Script> 
<script type="text/javascript" src="../../Library/Script/complete.min.js"></script>

<link rel="stylesheet" type="text/css" href="../../Library/Styles/formalize.css">
<script type="text/javascript" src="../../Library/Script/jquery.formalize.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery.validate.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery-ui-1.8.21.all.min.js"></script>


<script type="text/javascript">
var userid = '<%=((String)Session.getUserId()).toUpperCase()%>'

try
{
	req = new ActiveXObject("Msxml2.XMLHTTP");
}
catch(e)
{
	try
	{
		req = new ActiveXObject("Microsoft.XMLHTTP");
	}
	catch(oc)
	{
		req = null;
	}
}
if(!req&&typeof XMLHttpRequest!="undefined")
{
	req = new XMLHttpRequest();
}

function changeAuth()
{
	var authChk = document.myForm.productsInfo.checked
	//alert("authChk:::::"+authChk)
	if(authChk)
		authVal = "Y";
	else
		authVal = "N";	
	//alert("authVal:::::"+authVal)
	
	var url="";
	url="../SelfService/ezChangeAuth.jsp?authVal="+authVal;
	
	req = new XMLHttpRequest();
	
	if(req!=null)
	{
		req.onreadystatechange = Process1;
		req.open("GET", url, true);
		req.send(null);
		
	}
}
function Process1() 
{
	if (req.readyState == 4)
	{
	 
		var resText     = req.responseText;	
		resText = resText.replace(/[\n\r\t]/g,'')		
		
		if (req.status == 200)
		{
			if(resText=='Y')
			{
				//alert("resText::::"+resText)
				//$( "#dialog-updated" ).dialog('open');
			}
			
		}
		else
		{
			if(req.status == 500)	 
			alert("Error");
		}
	}
}
</script>
<script type="text/javascript">
function funChkEmail()
{	
	var email = document.myForm.email.value
	
	var authChk = document.myForm.productsInfo.checked
	if(authChk)
		authVal = "Y";
	else
		authVal = "N";	


	if(email=='')
	{
		$( "#dialog-invalidEmail" ).dialog('open');
		return;				
	}	
	var url="";
	url="../SelfService/ezCheckEmail.jsp?entEmail="+email;
	
	Popup.showModal('modal1');
	if(req!=null)
	{
		req.onreadystatechange = Process;
		req.open("GET", url, true);
		req.send(null);
		
	}	
}
function Process() 
{
	var formFName = document.myForm.ufname.value
	var formLName = document.myForm.ulname.value	
	var email = document.myForm.email.value
	var userMail  = "<%=userEmail%>";
	if (req.readyState == 4)
	{
	 
		var resText     = req.responseText;	
		resText = resText.replace(/[\n\r\t]/g,'')		
		
		if (req.status == 200)
		{

			
			if(email!=userMail)
			{
				
				if(resText=='Y')
				{
					
					$( "#dialog-emailAlert" ).dialog('open');
					eval("document.getElementById('verifyImage')").src = '../../Images/wrong.png';
					document.myForm.email.value="";
					Popup.hide('modal1');
				}
				else
				{
					if(formFName=='')
					{
						$( "#dialog-fName" ).dialog('open');
						Popup.hide('modal1');
						return;
					}
					if(email!='' && echeck(email) && formFName!=='')
					{
						
						document.myForm.action = "ezSaveAccInfo.jsp?authVal="+authVal;
						document.myForm.submit()
					}	
					else
						return;				

					}
					
				//document.myForm.emailVal.value=resText;
			}
			else
			{
				if(formFName=='')
				{
					$( "#dialog-fName" ).dialog('open');
					Popup.hide('modal1');
					return;
				}
				if(email!='' && echeck(email) && formFName!=='')
				{
					
					document.myForm.action = "ezSaveAccInfo.jsp?authVal="+authVal;
					document.myForm.submit()
				}	
				else
					return;
					
			}		
		}
		else
		{
			if(req.status == 500)	 
			alert("Error");
		}
	}
}
</script>

<!--form validations-->

<script type="text/javascript" src="../../Library/Script/SelfService/ezChangeAcctInfo.js"></script>

<div class="main-container col2-left-layout middle account-pages">
<div class="main">
<div class="col-main roundedCorners containerds">
<div class="page-title">





<div class="block" style="padding-left:0px;width:100%">
<div class="block-title">
	<strong>
		<span>Accout Profile </span>
	</strong>
</div>
</div>
	

</div>

<div class="col1-set" >
<div class="info-box">
<body>
<form name="myForm" id="ezForm" method="post">	
<input type ="hidden" name ="emailVal">


    <div class="fieldset">
        <p>Please enter the values to change</p>
        <br>
        <ul class="form-list">
            <li>
                <label for="uname" class="required">First Name<em>*</em></label>
                <div class="input-box">
                    <input type="text" name="ufname" alt="Name" value="<%=userFName%>" class="required" size ="25"/>
                </div>
            </li>
            <li>
                <label for="ulname" >Last Name<em></em></label>
		<div class="input-box">
		    <input type="text" name="ulname" value="<%=userLName%>" alt="Last Name" class="required" size ="25"/>
                </div>
            </li>
            <li>
	       <label for="email" class="required">Email Address<em>*</em></label>
	       <div class="input-box">
		   <input name="uemail" value="<%=userEmail%>" id="email" type="text" alt="Email Address" class="required email" size ="25" />
		   <img id="verifyImage" src="../../Images/check.png" style="cursor:pointer"  Title ="Verified Mail id" border=no "> 
	       </div>
	    </li>
 		<li>
	       <label for="products" class="required">Show/Hide Product Image</label>
	       <div class="check-box">
		   <input type = "checkbox" name="productsInfo"  id="productsInfo"  alt="Products display" <%=checked%>/>
		   
	       </div>
	    </li>	    
	   
        </ul>
    </div>
	 <p class="required">* Required Fields</p>    
    <div class="buttons-set form-buttons">
        <p class="back-link"><a href="../Misc/ezDashBoard.jsp"><small>&laquo; </small>Go back</a></p>
        <button type="button" class="button" onClick="funChkEmail()"><span><span>Save</span></span></button>
    </div>
<div id="dialog-emailAlert" title="Email Alert" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>This email account is either used by another user or you have another user account created with the &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;same email account.<Br><Br>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Please contact portal administrator for further &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;assistance.</p>
</div>	
<div id="dialog-updated" title="Updated" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Updated Successfully</p>
</div>	
<div id="dialog-fName" title="First Name" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Please Enter First Name</p>
</div>	
<div id="dialog-lName" title="Last" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Please Enter Last Name</p>
</div>	
<div id="dialog-invalidEmail" title="Email Alert" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Invalid Email.</p>
</div>	
<div id="modal1" style="width: 500px; height:180px; display: none; ">
<div align=center  style="padding-top:10px;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>
</div>

	
</div> <!-- Info box -->
</div> <!-- col1-set -->
</div> <!-- col-main -->



<div class="col-left sidebar roundedCorners">
	<div class="block block-account">
		<div class="block-title">
			<strong><span>A/C INFORMATION</span></strong>
		</div>
		<div class="block-content">
			<ul>
			<div style="color:#50B4B6;">
					<strong><span>Account Profile</span></strong>
			</div>			
			<!--<li class="current"><a href="../SelfService/ezChangeAcctInfo.jsp">Account Profile</a></li>-->
<%
			if (!"CM".equals(userRole))
			{
%>			
				<li><a href="../SelfService/ezChangePassword.jsp">Change Password</a></li>
<%
			}	
			if (!"CM".equals(userRole) && "N".equals((String)session.getValue("IsSubUser")))
			{
%>			
			<li><a href="../SelfService/ezAddSubUser.jsp">Add Sub User</a></li>
			<li><a href="../SelfService/ezListSubUsers.jsp">List Sub Users</a></li>
<%
			}
%>			
			<!-- <li><a href="../News/ezListNewsDash.jsp?newsFilter=PA">Promotions</a></li> -->

			</ul>
		</div>
	</div>
</div>
</div>
</div>

</div> <!--main -->
</div> <!-- main-container col1-layout -->
</form>
</body>