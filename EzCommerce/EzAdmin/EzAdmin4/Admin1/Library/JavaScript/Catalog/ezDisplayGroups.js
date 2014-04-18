var tabHeadWidth=80
var usetOption=0

function setOption(opt)
{
 userOption=opt
}
function submitForm()
{
   /*if(document.myForm.SystemKey.value=="sel")
     {
       alert("Please select sales area")
       document.myForm.SystemKey.focus()
       return false
     }
     if(document.myForm.Language.value=="sel")
      {
           alert("Please select language")
           document.myForm.Language.focus()
           return false
      }
      */
   
      if(userOption==1)
       {
          document.myForm.action="ezDisplayGroups.jsp"
          document.myForm.submit()
          return true
       }
}

function funSubmit()
{
	if(document.myForm.SystemKey.selectedIndex != 0)
	{
		userOption=1
		submitForm()
	}
}