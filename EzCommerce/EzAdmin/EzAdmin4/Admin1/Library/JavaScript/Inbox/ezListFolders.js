function CheckSelect() 
{
	var pCount=0;
	var selCount=0;
	pCount = document.myForm.CheckBox.length;
	var i = 0;
	if(isNaN(pCount))
	{
		if(document.myForm.CheckBox.checked)
                {  if(confirm("Are you confirmed about deletion of Folders and its Content"))
                  {
			return true;
                  }
               }
		else
		{
			alert("Please select atleast one folder to delete");
			return false;
		}	
	}
	else
	{
		for ( i = 0 ; i < pCount; i++ ) {
			if(document.myForm.CheckBox[i].checked){
				selCount = selCount + 1;
			}
		}
		if(selCount<1){
			alert("Please select atleast one folder to delete");
			return false;
		}else{
	
			return true;
		}
	}
}	
function funAdd(msgFlag)
{
		document.location.href = "ezAddFolder.jsp?msgFlag="+msgFlag;
}
function goInbox()
{
    document.myForm.action="ezListPersMsgs.jsp";
    document.myForm.submit();
}
