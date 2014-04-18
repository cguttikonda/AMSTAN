
 var FieldNames=new Array;
 var CheckType=new Array;
 var Messages=new Array;
 
  function submitForm()
  {
	if(document.myForm.oldpassword.value=="")
        {
	      FieldNames[0]="oldpassword";
	      CheckType[0]="Mnull";
	      Messages[0]="Please enter your old password";
        }
        else
        {
	      FieldNames[0]="oldpassword";
	      CheckType[0]="Mnospecialchar";
	      Messages[0]="Invaild old password(it can not contain special chars)";
        }
      
        if(document.myForm.newpassword.value=="")
        {
	      FieldNames[1]="newpassword";
              CheckType[1]="Mnull";
              Messages[1]="Please enter your new password";
        }
        else
        {
              FieldNames[1]="newpassword";
              CheckType[1]="Mnospecialchar";
              Messages[1]="Invaild new password(it can not contain special chars)";
        }
        if(document.myForm.confirmpassword.value=="")
        {
              FieldNames[2]="confirmpassword";
              CheckType[2]="Mnull";
              Messages[2]="Please enter your new password";
        }
        else
        {
  	      FieldNames[2]="confirmpassword";
	      CheckType[2]="Mnospecialchar";
	      Messages[2]="Invaild confirm password(it can not contain special chars)";
        } 
       
        if(funCheckFormFields(document.myForm,FieldNames,CheckType,Messages))
        {
            if(document.myForm.newpassword.value.length<6 || document.myForm.confirmpassword.value.length<6 || document.myForm.oldpassword.value.length<6)
            {
                alert("Your password must have atleast six characters")
                return false
            }
            if(document.myForm.newpassword.value!=document.myForm.confirmpassword.value)
            {
                document.myForm.newpassword.focus()
                alert("Your new and confirm password are not same")
                return false
            }
                document.myForm.action="ezSavePassword.jsp"
                return true
        }
        else
          return false
   }    