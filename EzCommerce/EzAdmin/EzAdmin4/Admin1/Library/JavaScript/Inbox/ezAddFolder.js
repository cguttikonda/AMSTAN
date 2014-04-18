function isValidChar (c)
{   return ( ((c >= "A") && (c <= "Z")) || ((c >= "a") && (c <= "z")) || ((c >= "0") && (c <= "9")) ||(c==" "))
}

function checkFolder(s)
{
    var i;
    // Search through string's characters one by one
    // until we find a non-numeric character.
    // When we do, return false; if we don't, return true.

    for (i = 0; i < s.length; i++)
    {   
        // Check that current character is number.
        var c = s.charAt(i);
        if (!isValidChar(c)) return false;
    }

    	// All characters are numbers or alphabets.
    	return true;

}

function chkFolder()
{
	var val=document.myForm.FolderName.value

	if(val=="")
	{
		alert("Please enter Folder Description");
		document.myForm.FolderName.focus()
		return false
	}
	for(var i=0;i<folderNames.length;i++)
	{
		if(val == folderNames[i])
		{
			alert("Folder Description with this name is already exist. Try with different Description")
			document.myForm.FolderName.focus()
			return false
		}
	}
	document.myForm.action="ezSaveFolderName.jsp"
	return true
}

function VerifyEmptyFields()
{
	if (document.forms[0].FolderName.value == "" )
	{
		alert("Please enter the Folder Name");
		document.myForm.FolderName.focus();
		document.returnValue = false;
	}else{
		document.returnValue = true;
	}
	
	if ( document.returnValue )
	{
		if ( !checkFolder(document.myForm.FolderName.value) )
		{
			alert('Folder Name can be alphabets and numbers only');
			document.returnValue = false;
			document.myForm.FolderName.focus();
		}
		else
		{	
			document.returnValue = true;
		}
	}
}
