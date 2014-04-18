function submitForm()
		{


				if(document.InvListForm.totInv.value!=0)
				{
					//alert("Entered If 1");
					if(document.InvListForm.totInv.value == 1)
					{
						if(document.InvListForm.InvDtls.checked == true)
						{
							//alert("Entered If 2");

							document.InvListForm.action="ezInvPaymentDetails.jsp";
							document.InvListForm.submit();
						}
						else
						{
							//alert("Entered Else 1");

							alert(invpay_A);
						}
					}
					else if(document.InvListForm.totInv.value > 1)
					{
						var chk=0;
						for(i=0;i<document.InvListForm.totInv.value;i++)
						{
							if(document.InvListForm.InvDtls[i].checked == true)
							{
								chk += 1;
							}
						}
						//alert("CHK is : "+chk);
						if(chk != 1)
						{
							//alert("Entered If 3");
							if(chk > 1)
								alert(invsel_A);
							else if(chk == 0)
								alert(selinv_A);
						}
						else
						{
							hideButton();
							document.InvListForm.action="ezInvPaymentDetails.jsp";
							document.InvListForm.submit();
						}
					}
				}
				else if(document.InvListForm.totInv.value == 0)
				{
					alert(showdet_A);
				}
			}