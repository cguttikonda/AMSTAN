function selselect(j)
{
	one=j.split(",")
	obj=eval("document.addForm."+one[0]);

	if(obj.selectedIndex==0)
	{
		alert(one[1])	
		obj.focus();
	 	return false;
	}
	else{
		return true;
	}
}
