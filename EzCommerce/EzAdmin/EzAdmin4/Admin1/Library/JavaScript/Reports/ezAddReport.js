function chkVal()
{
	var FieldNames=new Array;
	var CheckType=new Array;
	var Messages=new Array;

	FieldNames[0]="RepName";
	CheckType[0]="MNull";
	Messages[0]="Please enter Report Name";

	FieldNames[1]="RepDesc";
	CheckType[1]="MNull";
	Messages[1]="Please enter Description";
		
	if(document.myForm.SysNum.selectedIndex==0)
	{
		alert("Please select System");
		document.myForm.SysNum.focus()
		return false
	}

       	if(funCheckFormFields(document.myForm,FieldNames,CheckType,Messages))
       		{
       		document.myForm.action = "ezAddReportNext.jsp";
		document.myForm.submit();		
		}
	else
		return false;
}
