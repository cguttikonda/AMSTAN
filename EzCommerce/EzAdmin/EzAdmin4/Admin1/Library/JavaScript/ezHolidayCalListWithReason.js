function save()
{
	if(document.myForm.hldDate.value=="")
	{
		alert("Please select the date");
		return;
	}
	else
	if(document.myForm.reason.value=="")
	{
		alert("Please enter reason for selected date");
		document.myForm.reason.focus();
		return;
	}
	else
	{
		var date=document.myForm.hldDate.value;

		var dat   = date.substring(0,2);
		var date1 = parseInt(dat,10);
		
		var mon = date.substring(3,5);
		var month = parseInt(mon,10);
		

		var year  = date.substring(6,10);
		var id    = date1+""+month+""+year;
		
		
		if(document.myForm.chk1 != null)
		{
			var len = document.myForm.chk1.length;
			if(isNaN(len))
			{
				if(document.myForm.chk1.value==id)
				{
					alert("The date you selected is already in the list.Please select another date");
					document.myForm.hldDate.focus();
					return;
				}
			}
			else
			{
				for(var i=0;i<len;i++)
				{
					if(document.myForm.chk1[i].value==id)
					{
						alert("The date you selected is already in the list.Please select another date");
						document.myForm.hldDate.focus();
						return;
					}
				}
			}
		}	
	}	
	
	document.myForm.action="ezAddSaveDatesWithReason.jsp";
	document.myForm.submit();
}
function addDates()
{
	document.myForm.action="ezHoliDayCalAdd.jsp";
	document.myForm.submit();		
}

function editDates()
{
	if(chkEdit(myForm))
 	{
		document.myForm.action="ezEditHolidayCal.jsp";
		document.myForm.submit();
	}	
}
function deleteDates()
{
	if(chkDel(myForm))
 	{
		document.myForm.action="ezDeleteDatesWithReason.jsp";
		document.myForm.submit();
	}	
}
