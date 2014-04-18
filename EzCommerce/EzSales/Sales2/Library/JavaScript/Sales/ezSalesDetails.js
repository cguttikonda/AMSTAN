
	function man(obj,obj1)
	{		
		if( eval("document.generalForm."+obj+"_"+obj1+".value")=="")
		{
			alert(pleaseenter +obj);
			eval("document.generalForm."+obj+"_"+obj1+".focus()")
			return false;
		}
	}
	
	function formSubmit(obj1,obj2)
	{
				
		buttonsSpan=document.getElementById("EzButtonsSpan");
		buttonsMsgSpan=document.getElementById("EzButtonsMsgSpan");
		
                if(buttonsSpan!=null)
		{
			//buttonsSpan.style.display="none"
			//buttonsMsgSpan.style.display="block"
		}
		var y="true"
		if(obj2 != "NO")
		{
		
			document.generalForm.statusDate.value="1";
			document.generalForm.status.value=obj2;
		}else
		{
			
			document.generalForm.statusDate.value=StatusDate;
			document.generalForm.status.value=statusOrder;
			
		}
				
		if( obj1 == "ezDeleteSales.jsp") 
		{ 
			y= chkDelSumbit();
			if(eval(y))
			{
			 	 y=confirm(permenantlydelete)
			}
		}
		
		if(eval(y))
		{	
			if( (obj1 != "ezDeleteSales.jsp") && (obj2 !="REJECTED") && (obj2 != "CANCELED") )
			{
				
				y=chk();
			}
		}
		
		if(eval(y))
		{

			 if( (document.generalForm.chkprice.value==0)  &&(obj1=="ezEditSaveSales.jsp"))
			{
				document.getElementById("button").style.display="block";
				alert("Please click on getPrices as you have changed quantities");
				showTab("1");
				y="false";
			}
			else if( (document.generalForm.chkprice.value!=0)  &&(obj1=="ezEditSaveSales.jsp"))
			{
				
				if(statusOrder == "NEW")
				{
					if(obj2=="TRANSFERED")
					{
						y=confirm("Do you want to submit the order?")
					}
					else
						y=confirm(SavetheOrderforMod)
				}
				else 
				{
					if(UserRole == "CM")
					{
						y=confirm(SavetheOrder)

					}
					else
					{
						y=confirm(AccepttheOrder)						
					}
				}
			}
			else if(obj2=="SUBMITTED")
			{
				if(document.generalForm.chkprice.value==0)
				{
					document.getElementById("button").style.display="block";
					alert("Please click on getPrices as you have changed quantities");
					showTab("1");
					y="false";
				}else
				{
					y=confirm(Submittheorder)
				}
				
			}
			 else if(obj2=="APPROVED")
			{
				if(document.generalForm.chkprice.value==0)
				{
					document.getElementById("button").style.display="block";
					alert("Please click on getPrices as you have changed quantities");
					showTab("1");
					y=false;
				}else
				{
				       y=confirm(Approvetheorder)
				}
			}
			else if(obj2=="CANCELED")
			{
				y=confirm(Deletetheorder)
			}
			else if( obj2=="REJECTED" )
			{
				y=confirm(Rejecttheorder)
				if(eval(y))
				{
					displayWindow("document.generalForm.reasonForRejection");
				}
			}
			else if( (obj2=="RETURNEDBYCM") ||(obj2=="RETURNEDBYLF") || (obj2 == "SUBMITTEDTOBP"))
			{
				    if( (UserRole=="LF") && (obj2 != "RETURNEDBYLF" ) )
			    	    {
					y=chkchange()
				
				     }else
				     {
					y="true";
			     	      }
				
					
				if(eval(y))
				{
					if(obj2 == "SUBMITTEDTOBP")
					{
						y=confirm(Submittheorder)
					}else
					{
						y=confirm(Returntheorder)
					}
					if(eval(y))
					displayWindow("document.generalForm.reasonForRejection");
				}
			}
			else if(obj2=="TRANSFERED")
			{
			     if(UserRole=="LF")
			    {
			   	y=chkchange()
				
				
			     }else
			     {
				y="true";
			     }
			     if(eval(y))
			     {
				  if(UserRole=="LF")
				    	  y=confirm(Posttheorder)
				  else
					  y=confirm("DO you want to Submit the Order to SAP?")
			     }
			    
			}
			
			
		}
		if(eval(y)) 
		{	
			if(statusOrder == "APPROVED")
			{
				/*x=confirm("Do you want to Block the Delivery");
				if(!x)
				{	
					document.generalForm.delBlock.value="Y"
						
				}*/
			}
				document.body.style.cursor="wait"
				document.generalForm.action=obj1;
								
				if( (obj2 != "REJECTED" ) && (obj2 != "RETURNEDBYCM" ) && (obj2 !="RETURNEDBYLF") &&(obj2 != "SUBMITTEDTOBP"))
				{
					document.generalForm.submit();
				}
			
		}
		else
		{	
			if(buttonsSpan!=null)
			{	
		    	    buttonsSpan.style.display="block"
			    buttonsMsgSpan.style.display="none"
			}
		}
		
		
			
	}
	
	
	function checkprice(obj,obj1)
	{
		if(document.generalForm.chkprice.value==0)
		{
			x=confirm(Changingthequantitywillgetprices);
			if(x)
			{	
				formSubmit("../../../Includes/jsps/Sales/iGetPrices.jsp","NO")
			}
			else
			   obj.value=obj1;
		}
	}

	function openNew(theName)
	{
		open(theName);
	}
	
	function showTab(tabToShow)
	{
		
		if(tabToShow==1)
		{
			if(document.getElementById("div1")!=null)
				document.getElementById("div1").style.visibility="visible"
			if(document.getElementById("div3")!=null)
				document.getElementById("div3").style.visibility="visible"
			if(document.getElementById("div4")!=null)
				document.getElementById("div4").style.visibility="visible"
			if(document.getElementById("div5")!=null)
				document.getElementById("div5").style.visibility="visible"
			if(document.getElementById("div2")!=null)
				document.getElementById("div2").style.visibility="hidden"
			if(document.getElementById("div6")!=null)
				document.getElementById("div6").style.visibility="hidden"
			if(document.getElementById("div7")!=null)
				document.getElementById("div7").style.visibility="hidden"
		}
		else if(tabToShow==2)
		{
			document.getElementById("div1").style.visibility="hidden"
			document.getElementById("div2").style.visibility="visible"
			document.getElementById("div6").style.visibility="visible"
			document.getElementById("div7").style.visibility="visible"
			document.getElementById("div3").style.visibility="hidden"
			document.getElementById("div4").style.visibility="hidden"
			document.getElementById("div5").style.visibility="hidden"
		}
		

	}
//to select values of select boxes on Load
function selselect(j)
{
	var one=j.split(",");	
	Length=eval("document.generalForm."+one[0]+".options.length");
	for(var k=0;k<Length;k++)
	{
		if(eval("document.generalForm."+one[0]+".options[k].value")==one[1])
		{			
			eval("document.generalForm."+one[0]+".options[k].selected=true")
			 break;
		}
	}
}

function setchkPrice() 
{
	document.generalForm.chkprice.value="0";
}

function test()
{
	y="true";
	y= chkcompqty()
		
	if(!eval(y))
	{
		document.getElementById("button").style.display="block";
		alert("Please click on getPrices as you have changed quantities");
		showTab("1");

				
	}else
	{
		
		res = chkCompDates()
		
		if(!eval(res))
			return false
		
		showTab("2");
	}
}
