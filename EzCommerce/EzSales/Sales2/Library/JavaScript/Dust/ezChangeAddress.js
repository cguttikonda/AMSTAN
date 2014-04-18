	function changeShip()
	{
		pp1 = document.generalForm.shipTo.options[document.generalForm.shipTo.selectedIndex].value;
		
		for(i=0;i<ship.length;i++)
		{
			 one=ship[i].split("^^");
			if(pp1==one[0])
			{
			document.generalForm.shipToAddress1.value=one[1];
			document.generalForm.shipToAddress2.value=one[2];
			document.generalForm.shipToAddress3.value=one[3];
			document.generalForm.shipToState.value=one[4];
			document.generalForm.shipToZipcode.value=one[5];
			document.generalForm.shipToCountry.value=one[6];
			break;
			}
			
		}
	}
	
	function changeSold()
	{
		pp1 = document.generalForm.soldTo.options[document.generalForm.soldTo.selectedIndex].value;
		for(i=0;i<sold.length;i++)
		{
			 one=sold[i].split("^^");
			if(pp1==one[0])
			{
			document.generalForm.soldToAddress1.value=one[1];
			document.generalForm.soldToAddress2.value=one[2];
			document.generalForm.soldToAddress3.value=one[3];
			document.generalForm.soldToState.value=one[4];
			document.generalForm.soldToZipcode.value=one[5];
			document.generalForm.soldToCountry.value=one[6];
			break;
			}
		}
		
	}

	function changeAgent()
	{
		pp1 = document.generalForm.agent.options[document.generalForm.agent.selectedIndex].value;
		for(i=0;i<sold.length;i++)
		{
			 one=sold[i].split("^^");
			if(pp1==one[0])
			{
				document.generalForm.agentAddress1.value=one[1];
				document.generalForm.agentAddress2.value=one[2];
				document.generalForm.agentAddress3.value=one[3];
				document.generalForm.agentState.value=one[4];
				document.generalForm.agentZipcode.value=one[5];
				document.generalForm.agentCountry.value=one[6];
				break;
			}
			
		}
					
	} 


  function setShipToName()
  {
	document.generalForm.shipToName.value = document.generalForm.shipTo.options[document.generalForm.shipTo.selectedIndex].text;
	
   }
