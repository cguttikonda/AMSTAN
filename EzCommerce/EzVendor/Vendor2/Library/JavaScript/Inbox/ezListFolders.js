function CheckSelect() {
	var pCount=0;
	var selCount=0;
	pCount = document.myForm.CheckBox.length;
	var i = 0;

	if(isNaN(pCount))
	{
		if(document.myForm.CheckBox.checked)
                {
                	if(confirm(ruSureDelFol_L))
                	{
				return true;
                	}
			else
			{
				return false;
			}
               }
		else
		{
			alert(plzSelFolDel_L);
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
			alert(plzSelFolDel_L);
			return false;
		}else{
                	if(confirm(ruSureDelFol_L))
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
		setMessageVisible();
		document.location.href = "ezAddFolder.jsp"
	}
function goInbox()
{
    document.myForm.action="ezListPersMsgs.jsp";
    document.myForm.submit();
}
