//var tabHeadWidth=80
function init()
 	{
 	var InnerdivId1=document.getElementById("InnerBox1Div")
 //	var OuterdivId1=document.getElementById("OuterBox1Div")
 	if(InnerdivId1!=null)
 		{
		myInit(2)
		if(getposition())
			{
			ScrollBox.show()
			}
		}
	}


function synch()
{
   var len=document.myForm.chk1.length;
   var count=0;
     
        if(document.myForm.chk1.checked)
        {
            count++;
        }
   for(i=0;i<len;i++)
   {
        if(document.myForm.chk1.checked)
        {
            count++;
        }
   }
   if(count==0)
   {
       alert("pls select atleast one checkbox to synchronize");
       return false;
   }
   else
   {
         return true;
   }
}