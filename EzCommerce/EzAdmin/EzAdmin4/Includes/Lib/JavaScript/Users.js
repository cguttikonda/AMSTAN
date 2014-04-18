//Created by Venkat on 5/1/2001 - Used by all JSPs in Users folder

function checkBusUser(formName)
{
    var i;
    var newValue='';
    var bPNum = document.forms[formName].BusPartner.value;
    // Search through string's characters one by one
    // until we find a non-numeric character.
    // When we do, return false; if we don't, return true.
    var bFlag = '';
    for (i = 0; i < bPNum.length; i++)
    {
        // Check that current character is number.
        var c = bPNum.charAt(i);
        if ( i == ( bPNum.length - 1 ) )
        {
             bFlag = c;
        }

        if (c == 'Y' && document.forms[formName].UserType.value == '3')
        {
            alert('Cannot have Business Users for this Partner');
            document.forms[formName].UserType.value = '2';
            document.forms[formName].Admin.disabled = false;
            document.forms[formName].UserType.focus();
            document.returnValue = true;
            break;
        }

        if (c == 'N' && document.forms[formName].UserType.value == '2')
        {
            alert('Cannot have Intranet Users for this Partner');
            document.forms[formName].UserType.value = '3';
            document.forms[formName].Admin.disabled = true;
            document.forms[formName].UserType.focus();
            document.returnValue = false;
            break;
        }

        document.returnValue = true;

    } //end for

    if ( bFlag == 'Y' && document.returnValue)
    {
        document.forms[formName].action = "ezAddIntranetUser.jsp";
    }

}

function validateEmail(eMailstr) {
	if (eMailstr.length == 0) {
		alert("Please enter your E-mail address");return false;
	}
	if (eMailstr.indexOf("@") < 0) {
		alert("Invalid E-mail, Please enter a valid email"); return false;
      }
	if (eMailstr.indexOf(".") < 0) {
		alert("Invalid E-mail, Please enter a valid email"); return false;
      }
	if (eMailstr.indexOf("'") >= 0) {
		alert("Invalid E-mail, Please enter a valid email"); return false; }
	if (eMailstr.indexOf(" ") >= 0) {
		alert("Invalid E-mail, Please enter a valid email"); return false; }
	if (eMailstr.indexOf("@") == 0) {
		alert("Invalid E-mail, Please enter a valid email"); return false; }
	if (eMailstr.indexOf(".") == 0) {
		alert("Invalid E-mail, Please enter a valid email"); return false;}
	if (eMailstr.charAt(eMailstr.length - 1) == ("@")) {
		alert("Invalid E-mail, Please enter a valid email");return false; }
	if (eMailstr.charAt(eMailstr.length - 1) == (".")) {
		alert("Invalid E-mail, Please enter a valid email"); return false;}
	if (eMailstr.indexOf("@", (eMailstr.indexOf("@") + 1)) >= 0) {
		alert("Invalid E-mail, Please enter a valid email"); return false;}
	if (eMailstr.indexOf(",") >= 0) {
		alert("Invalid E-mail, Please enter a valid email"); return false;}
	if (eMailstr.indexOf(":") >= 0) {
		alert("Invalid E-mail, Please enter a valid email"); return false;}
	if (eMailstr.indexOf("chr(62)") >= 0) {
		alert("Invalid E-mail, Please enter a valid email"); return false;}
	if (eMailstr.indexOf("chr(60)") >= 0) {
		alert("Invalid E-mail, Please enter a valid email"); return false;}
	if (eMailstr.indexOf("chr(34)") >= 0) {
		alert("Invalid E-mail, Please enter a valid email"); return false;}
	if (eMailstr.indexOf("(") >= 0) {
		alert("Invalid E-mail, Please enter a valid email"); return false;}
	if (eMailstr.indexOf(")") >= 0) {
		alert("Invalid E-mail, Please enter a valid email"); return false;}
	if (eMailstr.indexOf("*") >= 0) {
		alert("Invalid E-mail, Please enter a valid email"); return false;}
	if (eMailstr.indexOf(";") >= 0) {
		alert("Invalid E-mail, Please enter a valid email"); return false;}
	if (eMailstr.indexOf("..") >= 0) {
		alert("Invalid E-mail, Please enter a valid email"); return false;}
	if (eMailstr.indexOf("@.") >= 0) {
	      alert("Invalid E-mail, Please enter a valid email"); return false;}
	if (eMailstr.indexOf(".@") >= 0) {
		alert("Invalid E-mail, Please enter a valid email");return false;}
	if (eMailstr.indexOf(".", (eMailstr.indexOf("@") + 2)) < 0) {
		alert("Invalid E-mail, Please enter a valid email");return false;}
	return true; }

function chkDupUser(allUsers)	//recent method
{
	var user = document.myForm.UserID.value
	user = user.toUpperCase()
	if(user != "")
	{
		if(checkUser(user))
		{
			if(allUsers.indexOf("F"+user+"L") >= 0)
			{
				alert('UserID: '+user+' is already assigned. Try a different one' );
				document.myForm.UserID.focus()
			}
		}
		else
		{
			alert('UserID can have only alphabets and numbers');
			document.myForm.UserID.focus()
		}
	}
}

function CheckDuplicate(formName)
{

	var user = document.forms[formName].UserID.value

     if ( checkUser(user) )
     {
         document.forms[formName].action="ezAddUserData.jsp?UserID="+user;
         document.forms[formName].submit();
     }
     else
     {
          alert('UserID can have only alphabets and numbers');
          document.forms[formName].UserID.focus();
          document.returnValue = false;
      }
}

function isValidChar (c)
{   return ( ((c >= "A") && (c <= "Z")) || ((c >= "a") && (c <= "z")) || ((c >= "0") && (c <= "9")))
}

function checkUser(s)
{
    var i;

    for (i = 0; i < s.length; i++)
    {
        var c = s.charAt(i);

        if (!isValidChar(c)) return false;
    }


    return true;

}

function checkSpecialUser(s,formName, fieldName)
{
	s=trim(s);
    var i;
    var newChar = '';

    for (i = 0; i < s.length; i++)
    {
          var c = s.charAt(i);
	  newChar += c;
	  if ( fieldName == 'FirstName' || fieldName == 'LastName' )
	  {
		if ( c == '&' || c == ',' || c == '"' || c == ' ' || c == '.')
		{
			continue;
		}
		if ( c == '\'' )
		{
			newChar += '\'';
			continue;
		}
	  }
        if (!isValidChar(c)) return false;
    }

    document.forms[formName].elements[fieldName].value = newChar;
    return true;

}


function checkAdmin(formName)
{
    //0-BusinessUser, 1-IntranetUser
    if ( document.forms[formName].UserType.value == "3" )
    {
      document.forms[formName].Admin.checked=false;
      document.forms[formName].Admin.disabled=true;
    }
    else
    {
      document.forms[formName].Admin.disabled=false;
      document.forms[formName].Admin.focus();
    }
}
function checkAll(formName,formType)
{
	var form = document.forms[formName];
	for (i = 0; i < form.elements.length; i++)
	{
		var name = form.elements[i].name;

		if (form.elements[i].type == "text" && trim(form.elements[i].value) == "" && form.elements[i].name != "MidInit" && form.elements[i].name != "LastName" )
		{
			alert("Please fill out all the fields.")
			form.elements[i].focus();
			document.returnValue = false;
			//break;
			return;
		}
		else
		{
			if (
				form.elements[i].name == "InitialPassword" ||
				form.elements[i].name == "ConfirmPassword"
			   )
			{


		if ( !checkUser( form.elements[i].value ) )
				{
					alert(form.elements[i].name+' can have only alphabets and numbers');
 					form.elements[i].focus();
					document.returnValue = false;
					//break;
					return;
				}
			}
			if (
				form.elements[i].name == "FirstName" ||
				form.elements[i].name == "LastName" ||
				form.elements[i].name == "MidInit"
			   )
			{
				if ( !checkSpecialUser( form.elements[i].value,  formName, form.elements[i].name) )
				{
					var fieldN=form.elements[i].name
					if(fieldN=="MidInit")
						fieldN="Middle Initial";
					alert(fieldN+' can have only alphabets and numbers');
 					form.elements[i].focus();
					document.returnValue = false;
					//break;
					return;
				}
			}

			if ( formType != 'ChangeUser' && formType != 'ChangeIntranetUser' )
			{
				passwd1 = document.forms[formName].InitialPassword.value;
				passwd2 = document.forms[formName].ConfirmPassword.value;

				usertype = document.forms[formName].UserType.value;
				if(formType!='ConfirmCopyUser' || formType!='ChangeUser')
				buspartner = document.forms[formName].BusPartner.value;

				if (passwd1 == "")
				{
					alert("Password is empty. Please enter the password");
					document.forms[formName].InitialPassword.focus();
					document.returnValue = false;
					//break;
					return;
				}
				else
				{
					document.returnValue = true;
				}

		// check for the password length
				if(passwd1.length<6){
				alert("Please make sure that password length is more than 6 characters");
				document.forms[formName].InitialPassword.focus();
                document.returnValue = false;
				return;
				}


				if (passwd1 != passwd2)
				{
					alert("Password and Confirm Password are not same. Please re-enter the password");
					document.forms[formName].InitialPassword.focus();
					document.returnValue = false;
					//break;
					return;
				}
				else
				{
					document.returnValue = true;
				}
			} //end formName != ChangeUser

		} //end if type=text
	} //end for

	if(formType!='ConfirmCopyUser' && formType!='ChangeUser')
	{
		if(document.forms[formName].BusPartner.selectedIndex==0)
		{
			alert("Please Select Bussiness Partner");
			document.returnValue=false;
			return;
		}
	}
	if ( formType != 'ChangeUser' && formType != 'ChangeIntranetUser' )
	{
	      var uid = document.forms[formName].UserID.value;
	      if ( !checkUser( uid ) )
	      {
	           alert('Userid can have only alphabets and numbers');
	           document.returnValue = false;
	           document.forms[formName].UserID.focus();
	           return;
	      }
	}
	
	
      var eid = document.forms[formName].Email.value;
      if ( !validateEmail(eid) )
      {
           document.returnValue = false;
           document.forms[formName].Email.focus();
           return;
      }

      if ( document.returnValue && formType == 'AddUser' )
      {
	      checkBusUser(formName);
      }


	if ( formType == 'ConfirmCopyUser' )
	{
	      var tc=document.forms[formName].CheckBox.length
	      if(isNaN(tc))
	      {
	      	if(document.forms[formName].CheckBox.checked)
	      	{
	      		document.returnValue = true;
	        }
	        else
	        {
	        	alert('Select atleast on Customer');
			document.returnValue = false;
	           	return;
	        }
	      }
	      else
	      {
	      	var ctr=0;
	      	for(i=0;i<tc;i++)
	      	{
	      		if(document.forms[formName].CheckBox[i].checked)
	      		{
	      			ctr++;
	      		}
	      	}
	      	if(ctr==0)
	      	{
	      		alert('Select atleast on Customer');
			document.returnValue = false;
	           	return;
	      	}
	      	else
	      	{
	      		document.returnValue = true;
	      	}
	      }
	}
	else
	{
		//alert("in else");
		document.returnValue=true;
	}
	
      
}


function setAction(formName)
{
	if ( formName == 'password' )
	{
		document.forms[formName].action = "../User/ezPassword.jsp";
	}
	else
	{
		document.forms[formName].action = "/Admin/JSPs/ezAddUserDataFinal.jsp";
	}
	document.forms[formName].submit();

}

function CheckSelect(formName) {
	var pCount=0;
	var selCount=0;
	//pCount = document.forms[formName].TotalCount.value;
	pCount=document.forms[formName].CheckBox.length;
	if(isNaN(pCount))
	{
		if(document.forms[formName].CheckBox.checked)
			selCount=1
	}
	else
	{
		for(i=0;i<pCount;i++)
		{
			if(document.forms[formName].CheckBox[i].checked)
				selCount=selCount+1;
		}
	}

	if(selCount<1){
		if ( formName == 'AddUser')
		{
			alert("Select ERP Customer(s) to Continue...");
		}
		if ( formName == 'AddIntranetUser')
		{
			alert("Select Non-Sync Area(s) to Continue...");
		}
		document.returnValue = false;
	}else{
		document.returnValue = true;
	}
}


function myalert(formName)
{
	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
	if ( formName == 'ChgPassword' )
	{
		mUrl2 = "BusUser=" + document.forms[formName].BusUser.value;
	}
	else
	{
		mUrl2 = "BusinessUser=" + document.forms[formName].BusUser.value;
	}
	mUrl =  mUrl1 + mUrl2;
	location.href= mUrl;
}

function checkDelRows(dRows,formName)
{
	var selBox = 0;
	for( i = 0; i < dRows; i++)
	{
		if ( document.forms[formName].elements['CheckBox_'+i].checked)
		{
			selBox = 1;
			break
		}
	}
	if ( selBox == 0 )
	{
		alert('Select atleast one user to delete');
		document.returnValue = false;
	}
	else
	{
		document.returnValue = true;
	}
}

function trim ( inputStringTrim ) 
{
	fixedTrim = "";
	lastCh = " ";
	for (x=0; x < inputStringTrim.length; x++) 
	{
	  ch = inputStringTrim.charAt(x);
	  if ((ch != " ") || (lastCh != " ")) 
	  { fixedTrim += ch; }
	  lastCh = ch;
	}
	if (fixedTrim.charAt(fixedTrim.length - 1) == " ") 
	{
	   fixedTrim = fixedTrim.substring(0, fixedTrim.length - 1); 
	}
   	return fixedTrim;
}

function checkCopyAll(formName) 
{
      var form = document.forms[formName]
      var nuser = document.forms[formName].NewUser.value;
      nuser = nuser.toUpperCase();
      nuser = trim(nuser);
      document.forms[formName].NewUser.value = nuser;

	for (i = 0; i < form.elements.length; i++) 
	{	
		if (form.elements[i].type == "text" && form.elements[i].value == "")
		{
			alert("Please enter the New UserID.")
			form.elements[i].focus();
			document.returnValue = false;
			return;
		}
		if (form.elements[i].type == "text" && form.elements[i].value != "")
		{
		
		   if(!checkUser( form.elements[i].value ))
		   {
		   	alert('Userid can have only alphabets and numbers');
		   	document.returnValue=false;
		   	return;
		   }
		   else
		   {
		   	document.returnValue = true;
		   }
		   
		}
		else
		{
			document.returnValue = true;
		}		
	}
	
	if(document.forms[formName].BusUser.selectedIndex==0)
	{
		alert("Please Select Source User");
		document.returnValue=false;
		return;
	}
	
      /** Checking for duplicate userids **/
      if ( document.returnValue ) 
	{
		for (i = 0; i < document.forms[formName].BusUser.length; i++) 
		{
			var bUser = document.forms[formName].BusUser[i].value;
			bUser = bUser.substring(2);
			if (bUser == nuser)
			{
				alert("UserId already exists")
				document.forms[formName].NewUser.focus();
				document.returnValue = false;
				break;
			}
			else
			{
			
				document.returnValue = true;
			} //end if
		} //end for
      } //end if
}


function VerifyEmptyFields(formName) 
{
	if ( formName == 'ChgPassword' )
	{
		if (	document.forms[formName].password1.value == "" || 
			document.forms[formName].password2.value == "" )
		{
			alert("Please enter the New and Confirm Passwords");
			document.returnValue = false;
		}
		else
		{
			document.returnValue = true;
		} //end if
	}
	else
	{
		if (  document.forms[formName].oldpasswd.value == "" || 
			document.forms[formName].password1.value == "" || 
			document.forms[formName].password2.value == "" )
		{
			alert("Please enter the Old and New Passwords");
			document.returnValue = false;
		}
		else
		{
			document.returnValue = true;
		} //end if
	} //end if

      if ( document.returnValue )
	{
		var form = document.forms[formName];
		for ( i = 0; i < form.elements.length; i++)
		{
			if ( form.elements[i].type=='password' && !checkUser( form.elements[i].value ) )
			{
				alert( form.elements[i].name +' can have only alphabets and numbers');
				form.elements[i].focus();
				document.returnValue = false;
				break;
			}
		} //end for
	} //end if
	if( document.forms[formName].BusUser.selectedIndex==0)
	{
		alert("Please Select The User");
		document.returnValue=false;
	}
}

function confirmNewpasswdChange(fromName)
{
var returnflag = confirmNewpasswd(fromName);
if(returnflag==true){
VerifyEmptyFields(fromName);
}
else{
document.returnValue = false;
return;
}
document.returnValue = true;
return;

}
function confirmNewpasswd(formName) 
{
	passwd1 = document.forms[formName].elements['password1'].value;
	passwd2 = document.forms[formName].elements['password2'].value;
	if(passwd1.length<6){
	 alert("Please make sure that password length is atleast 6 characters");
	 document.forms[formName].elements['password1'].focus();
	 //document.returnValue = false;
	 return false;
	}

	if (passwd1 != passwd2) 
	{
		alert("New Password and Old Password are not same. Please re-enter the new password");
	    document.forms[formName].elements['password1'].focus();
		//document.returnValue = false;
		return false;
	}
	return true;
}


function setChangeFlag1(i)
{

	if(!isNaN(document.myForm.ChangeFlag.length))
	{
		myFlag = document.myForm.ChangeFlag[i].value;
		if(myFlag == 'N')
		{
			document.myForm.ChangeFlag[i].value = 'Y';
			document.returnValue = true;
		}
		else
		{
			document.returnValue = true;
		}
	}
	else
	{
		myFlag = document.myForm.ChangeFlag.value;
		if(myFlag == 'N')
		{
			document.myForm.ChangeFlag.value = 'Y';
			document.returnValue = true;
		}
		else
		{
			document.returnValue = true;
		}


	}
}

