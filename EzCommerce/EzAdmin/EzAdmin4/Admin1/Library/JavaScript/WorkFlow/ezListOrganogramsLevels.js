 function funSubmit()
 {
 	//document.myForm.searchcriteria.value="A*";
 	document.myForm.action = "ezListOrganogramsLevels.jsp"
 	document.myForm.submit();
 }
 
 function ezAlphabet(alphabet)
 {
 	var level=document.myForm.level[document.myForm.level.selectedIndex].value
 	searchstring=alphabet+"*";
 	if(searchstring=="All*")
 		document.myForm.searchcriteria.value="";
 	else
 		document.myForm.searchcriteria.value=searchstring;
 	if(searchstring!=null)
 	{
 		if(searchstring.length!=0)
 		{
			if(document.myForm.level.selectedIndex != 0)
			{
 			 	document.myForm.action="ezListOrganogramsLevels.jsp";
 				document.myForm.submit();
			}
			else
			{
				alert("Please Select Level.")
			}
 		}
 	}
}
