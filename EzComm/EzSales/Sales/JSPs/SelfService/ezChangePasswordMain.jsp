<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"/>
<%
String sessPass=(String)session.getValue("userPass");
String uId = (String)Session.getUserId();

%>
<head>
<Script src="../../Library/Script/popup.js"></Script> 
<script type="text/javascript" src="../../Library/Script/complete.min.js"></script>

<link rel="stylesheet" type="text/css" href="../../Library/Styles/formalize.css">
<script type="text/javascript" src="../../Library/Script/jquery.formalize.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery.validate.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery-ui-1.8.21.all.min.js"></script>

<script type="text/javascript">
function validPwd()
{
	var oldPwd	= $("#oldPassword").val();
	var oldCom	= '<%=sessPass%>';
	var newPwd	= $("#newPassword").val();
	var newCompPwd	= $("#confPassword").val();

	if((newPwd.length || newCompPwd.length)<6)
	{
		$( "#dialog-length" ).dialog('open');	
		return;
	}
	if(oldPwd != oldCom)
	{
		$( "#dialog-Oldpwd" ).dialog('open');	
		return ;
	}
	else if(newPwd != newCompPwd)
	{
		$( "#dialog-Match" ).dialog('open');	
		return ;
	}
	Popup.showModal('modal1');
	document.myForm.action="ezSavePassword.jsp"
	document.myForm.submit();
}

function alpha(e)
{
	var keycode;
	keycode=event.keyCode?event.keyCode:event.which;
	if ((keycode >= 48 && keycode <= 57) || (keycode >= 65 && keycode <= 90) || (keycode >= 97 && keycode <= 122)) {
		return true;
	}
	else {
		$( "#dialog-valid" ).dialog('open');
		return false;
	}
	return true;
}


$(function() {

 	$( "#dialog-valid" ).dialog({
		autoOpen: false,
		resizable: true,
		height:150,
		width:400,
		modal: true,
		buttons: {
			"Ok": function() {
				$( this ).dialog( "close" ); 
			}
		}
	});
 	$( "#dialog-length" ).dialog({
		autoOpen: false,
		resizable: true,
		height:150,
		width:400,
		modal: true,
		buttons: {
			"Ok": function() {
				$( this ).dialog( "close" ); 
			}
		}
	});
 	$( "#dialog-Oldpwd" ).dialog({
		autoOpen: false,
		resizable: true,
		height:150,
		width:400,
		modal: true,
		buttons: {
			"Ok": function() {
				$( this ).dialog( "close" ); 
			}
		}
	});
 	$( "#dialog-Match" ).dialog({
		autoOpen: false,
		resizable: true,
		height:150,
		width:400,
		modal: true,
		buttons: {
			"Ok": function() {
				$( this ).dialog( "close" ); 
			}
		}
	});

} );

</script>

<!-- form validations end-->

<head>

<div class="main-container col2-left-layout middle account-pages">
<div class="main">
<div class="col-main roundedCorners containerds">
<div class="block">
<div class="block-title">
	<strong>
		<span>Change Your Password</span>
	</strong>
</div>
</div>

<div class="col1-set">
<div class="info-box">
<body >
<form name="myForm"  id="ezForm" method="post">	

    <div class="fieldset">
        <p>Please enter your new password.</p>
        <br>
        <ul class="form-list">
        	<li>
                <div class="input-box" style="visibility:hidden">
            			<input type="test" name="userPass" id="userPass" value="<%=sessPass%>" />
				    <input type="test" name="userid" id="userid" value="<%=uId%>" />
		</li>
            <li>
                <label for="oldpass" class="required">Old Password<em>*</em></label>
                <div class="input-box">
                    <input type="password" name="oldPassword" id="oldPassword" value="" />
                </div>
            </li>
            <li>
                <label for="newpass" class="required">New Password<em>*</em></label>
		                <div class="input-box">
		                    <input type="password" name="newPassword" id="newPassword" onkeypress="return alpha(event)" />
                </div>
            </li>
            <li>
                <label for="confpass" class="required">Confirm Password<em>*</em></label>
		                <div class="input-box">
		                    <input type="password" name="confPassword" id="confPassword" value="" />
                </div>
            </li>
        </ul>
    </div>
	 <p class="required">* Required Fields</p>    
    <div class="buttons-set form-buttons">
        <p class="back-link"><a href="../Misc/ezDashBoard.jsp"><small>&laquo; </small>Go back</a></p>
        <button type="button" class="button" onClick="validPwd()" ><span><span>Save</span></span></button>
    </div>

<div id="dialog-valid" title="Alert" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span><p>Sorry You can not insert Special Characters like</p><p>! @ # $ % ^ & * ( ) - _ + ' " ; : / ? < ></p></p>
</div>
<div id="dialog-length" title="Alert" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Password must contain at least 6 characters.</p>
</div>
<div id="dialog-Oldpwd" title="Alert" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Please re-enter old password.</p>
</div>
<div id="dialog-Match" title="Alert" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Your password entries did not match.Please try again.</p>
</div>
</form>
</body>
	
</div> <!-- Info box -->
</div> <!-- col1-set -->
</div> <!-- col-main -->
<div class="col-left sidebar roundedCorners">
	<div class="block block-account">
		<div class="block-title">
			<strong><span>My Account</span></strong>
		</div>
		<div class="block-content">
			<ul>
			<li><a href="../SelfService/ezChangeAcctInfo.jsp">Account Profile</a></li>
			<div style="color:#50B4B6;">
					<strong><span>Change Password</span></strong>
			</div>						
			<!--<li ><a href="../SelfService/ezChangePassword.jsp">Change Password</a></li>-->
<%
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
<div id="modal1" style="width: 500px; height:180px; display: none; ">
<div align=center  style="padding-top:10px;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>
</div>

</div> <!--main -->
</div> <!-- main-container col1-layout -->