	
	var FieldName=new Array();
	var CheckType=new Array();
	var Messages=new Array();

	FieldName[0] = "roleNr";
	CheckType[0] = "Mnull";
	Messages[0] = "Please enter Role Number";

	FieldName[1] = "roleType";
	CheckType[1] = "Mnull";
	Messages[1] = "Please enter Role Type";

	FieldName[2] = "language";
	CheckType[2] = "Mnull";
	Messages[2] = "Please Choose Required Language";

	FieldName[3] = "roleDesc";
	CheckType[3] = "Mnull";
	Messages[3] = "Please Enter Role Description";
	

		function chk()
		{
			var s= funCheckFormFields(document.myForm,FieldName,CheckType,Messages);
			return s;
		}
		
		var ar = new Array();
		ar[0] = "EzCommorce Suite 2.1";
		ar[1] = "Enabling Extended Enterprise";
		ar[2] = "Edit Priority";
		ar[3] = "Click SAVE button to save the given information for future reference";
		ar[4] = "Click CLEAR button to undo the changes made";
	ar[5] = "Click CANCEL button to leave the current page";