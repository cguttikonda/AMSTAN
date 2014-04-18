	var ar = new Array();
	ar[0] = "EzCommerce Suite 3.0";
	ar[1] = "Enabling Extended Enterprise";
	ar[2] = "List of User Roles";
	ar[3] = "Click on any User Role Number to get details";
	ar[4] = "To add new User Role click 'Add Role Definition'";
	ar[5] = "To edit a Role check the corresponding check box and click 'Edit Role Definition'";
	ar[6] = "To copy a Role check the corresponding check box and click 'Copy Roles'";
	ar[7] = "To re-set Role check the corresponding check box and click 'Re-Set Roles'"

			
	
	 var tabHeadWidth=80	
	 
	var optType=null
	function checkFun(obj)
	{
		optType=obj
	}
	function chkForSubmit()
	{
		var len = document.myForm.RoleNr.length

		if(optType == 'Edit')
		{
			if(isNaN(len))
			{
				if(document.myForm.RoleNr.checked)
				{
					document.myForm.action="ezEditRoleDefinition.jsp"
					return true
				}
				else
				{
					alert("Please select role to edit");
					return false
				}
			}
			else
			{
				var ctr=0
				for(i=0;i<len;i++)
				{
					if(document.myForm.RoleNr[i].checked)
						ctr++;
				}
				if(ctr==0)
				{
					alert("Please select role to edit")
					return false
				}
				else if(ctr > 1)
				{
					alert("Please select only one role to edit")
					return false
				}
				document.myForm.action="ezEditRoleDefinition.jsp"
				return true
			}
		}
		else
		{
			if(isNaN(len))
			{
				if(document.myForm.RoleNr.checked)
				{
					document.myForm.action="ezDelURoles.jsp"
					return true
				}
				alert("Please select role to delete")
				return false	
			}
			else
			{
				var ctr=0;
				for(i=0;i<len;i++)
				{
					if(document.myForm.RoleNr[i].checked)
						ctr++;
				}
				if(ctr == 0)
				{
					alert("Please select roles to delete")
					return false
				}
				document.myForm.action="ezDelURoles.jsp"
				return true	
			}
		}
	}

	function chkEditAndDelete()
	{
		
	}
	  
	function checkAll()
	{
		var form = document.forms[0];
		selCnt = 0;
	
		for ( i =0; i < form.elements.length; i++ )
		{
			if ( form.elements[i].type == "checkbox" && form.elements[i].checked )
			{
				selCnt = selCnt + 1;
				document.myForm.RoleNr.value = form.elements[i].value;
			}
		}

		if ( selCnt == 0 )
		{
			alert( 'Select one user role to edit' );
			document.returnValue = false;
			return;
		}
		if ( selCnt > 1 )
		{
			alert( 'Select only one user role to edit' );
			document.returnValue = false;
			return;
		}

		if ( selCnt == 1 )
		{
			document.returnValue = true;
			return;
		}
	}
	  
