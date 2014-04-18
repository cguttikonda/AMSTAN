	var ar = new Array();
	ar[0] = "EzCommerce Suite 3.0";
	ar[1] = "Enabling Extended Enterprise";
	ar[2] = "List of Addresses";
	ar[3] = "Click on any User Address Number to get details";
	ar[4] = "To add new User Address click 'Add Address'";
	ar[5] = "To edit a Address check the corresponding check box and click 'Edit Address'";
	
	
	 var tabHeadWidth=80	
	 
	var optType=null
	function checkFun(obj)
	{
		optType=obj
	}
	function chkForSubmit()
	{
		var len = document.myForm.chk1.length

		if(optType == 'Edit')
		{
			if(isNaN(len))
			{
				if(document.myForm.chk1.checked)
				{
					document.myForm.action="ezEditAddress.jsp"
					document.myForm.submit();
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
					if(document.myForm.chk1[i].checked)
						ctr++;
				}
				if(ctr==0)
				{
					alert("Please select Address to edit")
					return false
				}
				else if(ctr > 1)
				{
					alert("Please select only one Addrress to edit")
					return false
				}
				document.myForm.action="ezEditAddress.jsp"
				document.myForm.submit();
				return true
			}
		}
		else
		{
			if(isNaN(len))
			{
				if(document.myForm.chk1.checked)
				{
					if(chkDel(document.myForm))
					{
						document.myForm.action="ezDeleteAddress.jsp"
						document.myForm.submit();
						return true
					}
					else
						return false
				}
				alert("Please select Address to delete")
				return false	
			}
			else
			{
				var ctr=0;
				for(i=0;i<len;i++)
				{
					if(document.myForm.chk1[i].checked)
						ctr++;
				}
				if(ctr == 0)
				{
					alert("Please select Address to delete")
					return false
				}
				if(chkDel(document.myForm))
				{
					document.myForm.action="ezDeleteAddress.jsp"
					document.myForm.submit();
					return true
				}
				else
				{
					return false;
				}
			}
		}
	}
	
