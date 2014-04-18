		function funUserId()
		{
			var payTo = document.myForm.payTo.value;
			if(payTo!=null)
			{
					document.myForm.userId.value = payTo;
			}
	
		}
		function chkAll()
		{
			var count = 0;
			var len = document.myForm.syskey.length
			if(isNaN(len))
			{
				if(document.myForm.syskey.checked)
				{
					count++;
				}
			}
			else
			{
				for(var i=0;i<len;i++)
				{
					if(document.myForm.syskey[i].checked)
					{
						count++
					}
				}
			}
			
			var FieldNames=new Array();
			var CheckType=new Array();
			var Messages=new Array();
						
			FieldNames[0]="userId";
			CheckType[0]="MNULL";
			Messages[0]="Please enter User Id.";

			
			FieldNames[1]="userName";
			CheckType[1]="MNULL";
			Messages[1]="Please enter User Name.";

			FieldNames[2]="role";
			CheckType[2]="MNULL";
			Messages[2]="Please Select Role.";
			
			FieldNames[3]="busspartner";
			CheckType[3]="MNULL";
			Messages[3]="Please Select Business Partner.";
			
			FieldNames[4]="email";
			CheckType[4]="MEMAIL";
			Messages[4]="Please Enter Email Address.";			
			

			if(! funCheckFormFields(document.myForm,FieldNames,CheckType,Messages))
					return false;
				
			if(count==0)
			{
				alert("Please Select atleast one  Purchase Area")
				return false;
			}	
			return true;
		}
		function chkUserExists()
		{
			if(chkAll())
			{
				userId = document.myForm.userId.value;
				userId = userId.toUpperCase();
				for (var i=0;i<userArray.length;i++)
				{
					if (userId==userArray[i])
					{
						alert("User already Exists with "+userId+", Please Choose another one.");
						document.forms[0].userId.focus();
						return false;
					}
				}
				return true;
			}
			return false;
		}	
		function funFocus()
		{
			//if(document.myForm.userId!=null)
			//	document.myForm.userId.focus();
		}
		function selectAll()
		{

			len=document.myForm.syskey.length
			if(isNaN(len))
			{
				if(document.myForm.chk1Main.checked)
				{
					document.myForm.syskey.checked=true
				}else{
					document.myForm.syskey.checked=false
				}
			}
			else
			{	
				for(i=0;i<len;i++)
				{	if(document.myForm.chk1Main.checked)
					document.myForm.syskey[i].checked=true
					else
					document.myForm.syskey[i].checked=false
				}
			}
		}
		
