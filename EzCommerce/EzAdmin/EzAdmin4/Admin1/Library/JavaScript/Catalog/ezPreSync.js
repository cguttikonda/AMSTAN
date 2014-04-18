
var userOption=0

function setOption(opt)
{
  userOption=opt
}


function submitForm()
{
    
        if(userOption==1)
        {
	 document.myForm.action="ezPreSync.jsp";
	 document.myForm.submit()
	 return true
	}
	else
	if(userOption=2)
	{
	 document.myForm.action="ezGetSapCatalog.jsp";
	 return true
	
	}
	
}

function funSubmit()
{
	userOption=1
	submitForm()
}
