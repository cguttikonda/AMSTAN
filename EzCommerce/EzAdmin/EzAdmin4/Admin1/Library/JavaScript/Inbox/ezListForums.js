
function CheckSelect() {
	var pCount=0;
	var selCount=0;
	pCount = document.ListForums.CheckBox.length;
	
	//if only one checkBox available
	if(isNaN(pCount) && document.ListForums.CheckBox.checked)
	  selCount++
	
	
	for ( i = 0 ; i < pCount; i++ ) {
		if(document.ListForums.CheckBox[i].checked){
			selCount = selCount + 1;
		}
	}
	if(selCount<1)
	{
		alert("Select  Forum(s) Before Submission");
		document.returnValue = false;
	}else{

		document.returnValue = true;
	}
}

