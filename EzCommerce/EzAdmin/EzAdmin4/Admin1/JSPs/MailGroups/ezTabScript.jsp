	<script>
		function tabfun(tNo,totTabs,parForm)
		 {
			//var parForm="document.myForm";
		  	var id1="tab"+tNo+"_1";
		 	var id2=eval(parForm+".tab"+tNo+"_2");
		 	var id3=eval(parForm+".tab"+tNo+"_3");
	
		 	if(tNo==1){
		 	
		 		eval(parForm+".startBack").src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_front_left.gif"
		 		document.getElementById(id1).style.backgroundImage="url('../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_fill_front.gif')"
		 		id2.src='../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_front_right.gif'
		 		id3.src='../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back1_left.gif'
		 		for(i=2;i<=totTabs;i++)
		 		{
		 			id1="tab"+i+"_1";
				 	id2=eval(parForm+".tab"+i+"_2");
				 	id3=eval(parForm+".tab"+i+"_3");
			 		document.getElementById(id1).style.backgroundImage="url('../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_fill_back.gif')"
					id2.src='../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back_right.gif'
					if(i==totTabs)
					{
						id3.src='../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back_end.gif'
					}else{
						id3.src='../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back2_left.gif';
					}
		
		 		}
		 	}else{
		 		eval(parForm+".startBack").src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back_start.gif"
		 		if(tNo==totTabs){
		 			document.getElementById(id1).style.backgroundImage="url('../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_fill_front.gif')";
					id2.src='../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_front_right.gif';
					id3.src='../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_front_end.gif';
					for(i=1;i<totTabs;i++)
					{
						id1="tab"+i+"_1";
						id2=eval(parForm+".tab"+i+"_2");
						id3=eval(parForm+".tab"+i+"_3");
						
						document.getElementById(id1).style.backgroundImage="url('../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_fill_back.gif')"
						id2.src='../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back_right.gif'
						if(i==(parseInt(totTabs)-1))
						{
							id3.src='../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_front_left.gif'
						}else{
							id3.src='../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back2_left.gif';
						}
						
					}	 		
				
		 		}else{
		 			for(i=1;i<=totTabs;i++)
					{
						id1="tab"+i+"_1";
						id2=eval(parForm+".tab"+i+"_2");
						id3=eval(parForm+".tab"+i+"_3");
	
						if(i==tNo)
						{
							document.getElementById(id1).style.backgroundImage="url('../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_fill_front.gif')"
							id2.src='../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_front_right.gif'
							id3.src='../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back1_left.gif'
						}else{
							document.getElementById(id1).style.backgroundImage="url('../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_fill_back.gif')"
							id2.src='../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back_right.gif'
							if(i==(parseInt(tNo)-parseInt(1)))
								id3.src='../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_front_left.gif'
							else
								if(i==totTabs)
									id3.src='../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back_end.gif'
								else
									id3.src='../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back2_left.gif'
								
						}
					}
					
				}
	 	}
	 }
</script>
