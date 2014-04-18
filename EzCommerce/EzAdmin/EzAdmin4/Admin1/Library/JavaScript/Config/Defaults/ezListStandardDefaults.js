function checkAll(dRows)
{
	var selBox = 0;
	for( i = 0; i < dRows; i++)
	{
		if ( document.forms[0].elements['CheckBox'].checked )
		{
			selBox = 1;
			break;
		}
	}
	if ( selBox == 0 )
	{
		alert('Select atleast one default to update');
		document.returnValue = false;
	}
	else
	{
		document.returnValue = true;
	}
}
