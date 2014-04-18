var FieldNames=new Array;
var CheckType=new Array;
var Messages=new Array;

FieldNames[0]="msgSubject";
CheckType[0]="Mnull";
Messages[0]="Please Enter Message Subject";

function VerifyEmptyFields() 
{
   if(funCheckFormFields(document.myForm,FieldNames,CheckType,Messages))
   document.returnValue=true
   else
   document.returnValue=false
   
}
