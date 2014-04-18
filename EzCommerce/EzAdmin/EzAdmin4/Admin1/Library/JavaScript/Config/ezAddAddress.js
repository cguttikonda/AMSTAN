function chk()
{
	
			var FieldName=new Array();
			var CheckType=new Array();
			var Messages=new Array();


			FieldName[0] = "companyName";
			CheckType[0] = "MNULL";
			Messages[0] = "Please enter Company Name";
			var cnt=1;
			if(document.myForm.email.value!="")
			{
				FieldName[cnt] = "email";
				CheckType[cnt] = "MEMAIL";
				Messages[cnt] = "Please enter Valid Email";
				cnt++;
			}
		
		         if(document.myForm.city.value!="")
			{
				FieldName[cnt] = "city";
				CheckType[cnt] = "MNAME";
				Messages[cnt] = "Please enter valid City";
				cnt++;
			}
			 if(document.myForm.state.value!="")
			{
				FieldName[cnt] = "state";
				CheckType[cnt] = "MNAME";
				Messages[cnt] = "Please enter valid State";
				cnt++;
			}

			if(document.myForm.zipcode.value!="")
			{
				FieldName[cnt] = "zipcode";
				CheckType[cnt] = "MZIP";
				Messages[cnt] = "Please enter valid Zip Code";
				cnt++;

			}
			 if(document.myForm.state.value!="")
			{
				FieldName[cnt] = "state";
				CheckType[cnt] = "MNAME";
				Messages[cnt] = "Please enter valid State";
				cnt++;
			}
		
			if(document.myForm.zipcode.value!="")
			{
				FieldName[cnt] = "zipcode";
				CheckType[cnt] = "MZIP";
				Messages[cnt] = "Please enter valid Zip Code";
				cnt++;
			
			}
			if(document.myForm.phone1.value!="")
			{
				FieldName[cnt] = "phone1";
				CheckType[cnt] = "MPHONE";
				Messages[cnt] = "Please enter valid phone number";
				cnt++;
						
			}	
			if(document.myForm.phone2.value!="")
			{
				FieldName[cnt] = "phone2";
				CheckType[cnt] = "MPHONE";
				Messages[cnt] = "Please enter valid phone number";
				cnt++;
			}
			var s= funCheckFormFields(document.myForm,FieldName,CheckType,Messages);
	return s;


}
