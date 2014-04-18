
var FieldNames=new Array;
var CheckType=new Array;
var Messages=new Array;



function VerifyEmptyFields()
{
   if (document.myForm.ForumName.value == "" )
   {
     FieldNames[0]="ForumName";
     CheckType[0]="Mnull";
     Messages[0]="Please Enter Forum Name";
   }
   else
   {
     FieldNames[0]="ForumName";
     CheckType[0]="Mnospecialchar";
     Messages[0]="Please Enter Valid Forum Name";
   } 
   
  
   if(funCheckFormFields(document.myForm,FieldNames,CheckType,Messages))
   {
  
     if(document.myForm.User.selectedIndex==0)
      {
   	alert("Please Select Forum Coordinator");
   	document.myForm.User.focus();
   	return false;
      }
   
       document.myForm.action="ezSaveForumName.jsp"
       return true  
   }
   else
    return false
   
}


