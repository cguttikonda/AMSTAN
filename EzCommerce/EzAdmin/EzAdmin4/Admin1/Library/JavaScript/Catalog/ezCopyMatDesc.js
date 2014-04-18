function chkLang()
{
	var srcLang = document.forms[0].SourceLang.value;
	var dstLang = document.forms[0].DestLang.value;
	//check whether user selected valid option or not
	if(srcLang=="sel")
	{
	  alert("Please Select Source Language")
	  document.forms[0].SourceLang.focus()
	  return  false
	}
	if(dstLang=="sel")
	{
		  alert("Please Select Destination Language")
		  document.forms[0].DestLang.focus()
		  return  false
	}
	
	if (srcLang == dstLang && srcLang!="sel") 
	{
		alert ("The Destination Language must be different from Source Language");
		document.forms[0].SourceLang.focus()
		return  false
	} else 
	{
		return  true
	}
}
