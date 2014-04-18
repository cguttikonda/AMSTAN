function CheckSelect() {
	var pCount=0;
	var selCount=0;
	pCount = document.myForm.CheckBox.length;
	var i = 0;
	
	if(isNaN(pCount))
	{
		if(document.myForm.CheckBox.checked)
                { 
                	if(confirm("Are you confirmed about deletion of Folders and its Content"))
                	  {
				return true;
                	  }
               }
		else
		{
			alert("Select Folder(s) Before Deleting From Folders");
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
			alert("Select Folder(s) to delete");
			return false;
		}else{
                	if(confirm("Are you confirmed about deletion of Folders and its Content"))
                	  {
				return true;
                	  }
                	  else
                	  {
                	  	return false;
                	  }
		
	
			
		}
	}
}	
function funAdd()
	{
		document.location.href = "ezAddFolder.jsp"
	}
function goInbox()
{
    document.myForm.action="ezListPersMsgs.jsp";
    document.myForm.submit();
}
