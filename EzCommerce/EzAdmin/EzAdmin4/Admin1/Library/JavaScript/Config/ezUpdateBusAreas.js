

function init()
 {
      
 	var InnerdivId1=document.getElementById("InnerBox1Div")
 	//var OuterdivId1=document.getElementById("OuterBox1Div")
 	if(InnerdivId1!=null)
 	{
		myInit(2)
		if(getposition())
		{
			ScrollBox.show()
		}
	}
 
}


function trim( inputStringTrim) {
fixedTrim = "";
lastCh = " ";
for( x=0;x < inputStringTrim.length; x++)
{
   ch = inputStringTrim.charAt(x);
 if ((ch != " ") || (lastCh != " ")) { fixedTrim += ch; }
lastCh = ch;
}
if (fixedTrim.charAt(fixedTrim.length - 1) == " ") {
fixedTrim = fixedTrim.substring(0, fixedTrim.length - 1); }
return fixedTrim
}


function funCheckBoxModify()
{
	var len=document.myForm.chk1.length;
	var bool=false;
	var chk=0;
	if(isNaN(len))
	{
		if(document.myForm.chk1.checked==true)
		{
			//var desc=trim(document.myForm.SysKeyDesc.value)
			var FieldNames=new Array;
			var CheckType=new Array;
			var Messages=new Array;
			FieldNames[0]="SysKeyDesc";
			CheckType[0]="MNull";
			Messages[0]="Please Enter the Description";
			if(!funCheckFormFields(document.myForm,FieldNames,CheckType,Messages))
			{
				
				document.myForm.SysKeyDesc.focus()
				document.returnValue=false;	
			}
			else
			{
				document.myForm.chk1.value=document.myForm.chk1.value+"#"+document.myForm.SysKeyDesc.value;
				document.returnValue=true;
			}
		}
		else
		{
			alert("Please Select One Area To Modify");
			document.returnValue=false
		}
	}
	else
	{
		for(var i=0;i<len;i++)
		{
			if(document.myForm.chk1[i].checked==true)
			{
				chk++;
					
					//var desc=trim(document.myForm.SysKeyDesc[i].value)
					var FieldNames=new Array;
					var CheckType=new Array;
					var Messages=new Array;
					FieldNames[0]="SysKeyDesc";
					CheckType[0]="MNull";
					Messages[0]="Please Enter the Description";
					if(!funCheckFormFields(document.myForm,FieldNames,CheckType,Messages))
					{						
						bool=false
						document.returnValue=false;
						return false;
					}
					else
					{
						document.returnValue=true;
						bool=true;
					}
			}
			else
			{
				if(document.myForm.chk1[i].checked==false)
				{
					var desc=trim(document.myForm.SysKeyDesc[i].value)
					if(desc=="")
					{
					
						document.myForm.SysKeyDesc[i].focus()
						alert("Please  Check the checkbox and Enter the Description ");
						bool=false
						document.returnValue=false;
						return false;
						break;
					}
				
												
						
				}
			}

			
		}
	
	
		if(bool)
		{
		    for(var k=0;k<len;k++)
		    {
			if(document.myForm.chk1[k].checked==true)
			{					
				document.myForm.chk1[k].value=document.myForm.chk1[k].value+"#"+document.myForm.SysKeyDesc[k].value;
				
			}
		    }
			
		    document.returnValue=true;		
		}
		else
		{	
			if(chk==0)	
				alert("Please Select Areas To Modify");	
			document.returnValue=false;
		}
	}
}

	function selectAll()
	  {
	  	
	  len=document.myForm.elements.length
	    if(isNaN(len))
	    {
		if(document.myForm.chk1Main.checked)
		{
			document.myForm.elements.checked=true
		}else{
			document.myForm.elements.checked=false
		}
	    }
	   else
	   {	
		for(i=0;i<len;i++)
		{	
		  if(document.myForm.chk1Main.checked)
		  document.myForm.elements[i].checked=true
		  else
		  document.myForm.elements[i].checked=false
		}
	   }
	  }
