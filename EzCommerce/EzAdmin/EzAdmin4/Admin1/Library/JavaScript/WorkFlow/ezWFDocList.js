function checkAll()
{
	var FieldNames=new Array;
	var CheckType=new Array;
	var Messages=new Array;
	var i=0;
	if(document.myForm.authKey.selectedIndex==0)
	{
		alert("Please select Auth Key");
		return false;
	}
	if(document.myForm.SysKey.value!="")
	{
		FieldNames[i]="SysKey";
		CheckType[i]="MNull";
		Messages[i]="Please enter SysKey";	
		i++;
	}
	if(document.myForm.Status.value!="")
	{
		FieldNames[i]="Status";
		CheckType[i]="MNull";
		Messages[i]="Please enter Status";	
		i++;			
	}
	if(document.myForm.Step.value!="")
	{
		FieldNames[i]="Step";
		CheckType[i]="MNumber";
		Messages[i]="Please enter Numeric Value";	
		i++;			
	}
	if(document.myForm.Participant.value!="")
	{
		FieldNames[i]="Participant";
		CheckType[i]="MNull";
		Messages[i]="Please enter Participant";	
		i++;			
	}
	if(document.myForm.ParticipantType.value!="")
	{
		FieldNames[i]="ParticipantType";
		CheckType[i]="MNull";
		Messages[i]="Please enter ParticipantType";	
		i++;					
	}
	if(document.myForm.DocId.value!="")
	{
		FieldNames[i]="DocId";
		CheckType[i]="MNull";
		Messages[i]="Please enter DocId";	
		i++;								
	}
	if(document.myForm.Ref1.value!="")
	{
		FieldNames[i]="Ref1";
		CheckType[i]="MNull";
		Messages[i]="Please enter Ref1";	
		i++;										
	}
	if(document.myForm.Ref2.value!="")
	{
		FieldNames[i]="Ref2";
		CheckType[i]="MNull";
		Messages[i]="Please enter Ref2";	
		i++;												
	}
	if(!funCheckFormFields(document.myForm,FieldNames,CheckType,Messages))
	{
		return false;
	}
	else
	{
		return true;
	}
	
}