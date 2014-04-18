
function funsubmit()
{
	//document.UserAuth.BusUser.options[0].selected=true;
	document.myForm.action="ezResetPasswordBySysKey.jsp";
	document.myForm.submit();
}


function funsubmit1(area)
{
	if(document.myForm.WebSysKey.options[document.myForm.WebSysKey.selectedIndex].value=="sel" && document.myForm.BusUser.options[document.myForm.BusUser.selectedIndex].value=="sel")
	{
		alert("Please Select "+area);
		return;
	}

	if(document.myForm.BusUser.options[document.myForm.BusUser.selectedIndex].value=="sel")
	{
		alert("Please select User");
	}
	else
	{
		document.myForm.action="ezResetPasswordBySysKey.jsp";
		document.myForm.submit();
	}
}


var FieldNames=new Array;
var CheckType=new Array;
var Messages=new Array;

function VerifyEmptyFields()
{
 /*if(document.myForm.BusUser.selectedIndex==0)
{
	alert("Please Select The User");
	document.returnValue=false
}
else
{*/
  if(document.myForm.password1.value=="")
    {
        FieldNames[0]="password1";
        CheckType[0]="Mnull";
         Messages[0]="Please enter new password";
    }
    else
     {
         FieldNames[0]="password1";
         CheckType[0]="Mnospecialchar";
         Messages[0]="Invaild new password(it can not contain special chars)";
     }
    if(document.myForm.password2.value=="")
    {
        FieldNames[1]="password2";
        CheckType[1]="Mnull";
         Messages[1]="Please enter confirm password";
    }
    else
     {
         FieldNames[1]="password2";
         CheckType[1]="Mnospecialchar";
         Messages[1]="Invaild confirm password(it can not contain special chars)";
     } 
    if(funCheckFormFields(document.myForm,FieldNames,CheckType,Messages))
     {
       
       if(document.myForm.password1.value!=document.myForm.password2.value)
         {
           alert("New and confirm passwords are not same")
           document.myForm.password1.focus()
           document.returnValue=false
         }
         else
          document.returnValue=true
     }
     else
      document.returnValue=false
//}      
}
