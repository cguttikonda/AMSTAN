function chkEdit(myForm)
{
             
		parForm=document.myForm
		chkLength=parForm.chk1.length
		if(!(isNaN(chkLength)))
		{
      			count=0;
			for(i=0;i<chkLength;i++)
			{
				if(parForm.chk1[i].checked)
				count=count+1
			}
			if(count !=1)
			{
				alert("Please check Only one checkbox which you want to Edit")
				return false;
			}

	   	 }
	    	else
	   	{
			if(!(parForm.chk1.checked))
			{
			alert("Please check Only one checkbox which you want to Edit")
			return false;
			}
	  	}
	
	return true;
}

function chkDel(myForm)
{	

	parForm=document.myForm

	chkLength=parForm.chk1.length
	if(!(isNaN(chkLength)))
	{
	      count=0;
		for(i=0;i<chkLength;i++)
		{
			if(parForm.chk1[i].checked)
			count=count+1
		}
		if(count ==0)
		{
			alert("Please check checkbox(s) which you want to Delete")
			return false;
		}
		else
		{
			a=confirm("You are about to Delete" + count + "   Record(s)\n Solution : Click OK to permanently delete these Records. You won't be able to undo this change")
			if(!a)
			return false;
		}
	}
	else
	{
		if(!(parForm.chk1.checked))
		{
			s="Please check one or more checkboxes which you want to Delete"
			alert(s)
			return false;
		}
		else
		{
			a=confirm("You are about to Delete 1    Record \n Solution : Click OK to permanently delete these Records. You won't be able to undo this change")
			if(!a)
			return false;
		}


	}
	return true;
}
