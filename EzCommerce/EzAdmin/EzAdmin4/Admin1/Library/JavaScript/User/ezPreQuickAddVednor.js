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
						

			FieldNames[0]="payTo";
			CheckType[0]="MNULL";
			Messages[0]="Please enter Pay To.";

			FieldNames[1]="userId";
			CheckType[1]="MNULL";
			Messages[1]="Please enter User Id.";


			FieldNames[2]="userName";
			CheckType[2]="MNULL";
			Messages[2]="Please enter Partner / User Name.";


			

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
						document.forms[0].payTo.focus();
						return false;
					}
				}
				return true;
			}
			return false;
		}	
		function funFocus()
		{
			if(document.myForm.userName!=null)
				document.myForm.userName.focus();
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
		