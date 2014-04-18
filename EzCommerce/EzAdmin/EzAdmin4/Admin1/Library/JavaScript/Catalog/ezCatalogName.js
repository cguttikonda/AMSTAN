
var FieldNames=new Array;
var CheckType=new Array;
var Messages=new Array;

FieldNames[0]="NewCatDesc";
CheckType[0]="MNull";
Messages[0]="Please enter new description";

function checkAll()
{
   if(document.myForm.CatalogNumber.value=="sel")
    {
	alert("Please Select Catalog");
	document.myForm.CatalogNumber.focus()
         return false;
     }
      if(funCheckFormFields(document.myForm,FieldNames,CheckType,Messages))
       return true
       else 
       return false
	
     	
}
function placeFocus(numCat)
{
     if(numCat > 0)
     document.myForm.CatalogNumber.focus()
    
}