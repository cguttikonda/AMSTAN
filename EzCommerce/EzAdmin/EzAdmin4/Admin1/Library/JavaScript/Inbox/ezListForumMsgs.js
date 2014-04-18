function CheckSelect() 
	{
	var pCount=0;
	var selCount=0;
	pCount = document.ListForumMsgs.CheckBox.length;
	var i = 0;
	if(isNaN(pCount))
		{
		if(document.ListForumMsgs.CheckBox.checked)
			selCount = selCount + 1;
		}
	else
		{
		for ( i = 0 ; i < pCount; i++ ) 
			{
			if(document.ListForumMsgs.CheckBox[i].checked)
				selCount = selCount + 1;
			}
		}
	if(selCount<1)
		{
		alert("Select Forum Message(s) Before Deleting");
		document.returnValue = false;
		}
	else
		{
		document.ListForumMsgs.DelFlag.value = 'Y';
		document.returnValue = true;
		}
}
