function EzHelpKeywords(aKey,aText)
{
	this.helpKey=aKey;
	this.helpText=aText
}


var myKeys= new Array()

myKeys[0] = new EzHelpKeywords("ezHomePage","Use this feature to view List of Activities and List of Leads that were created new.");
	
		//end of home page
		
myKeys[1] = new EzHelpKeywords("ezListSalesAreas","Use this feature to view the list of Sales Areas.<br>Click on <b>'Add'</b> to add a new Sales Area.<br><b>To modify a Sales Area</b><li>Check the desired Sales Area and Click on <b>'Edit'</b></li><b>To delete a Sales Area,</b><li>Check the desired Sales Area and Click on <b>'Delete'</b></li><b>To go to the Home Page</b><br><li>Click on <b>'Cancel'</b></li>");
myKeys[2] = new EzHelpKeywords("ezAddSalesArea","Use this feature to add a new Sales Area.<br>Enter the details and click on <b>'Save'</b> to save new Sales Area.<br>Click on <b>'Reset'</b> to Undo the changes you have done.<br>Click on <b>'Back'</b> to go to the previous Page.");
	
myKeys[3] = new EzHelpKeywords("ezEditSalesArea","Use this feature to modify the existing Sales Area Information.<br>Make necessary changes and click on <b>'Save'</b> to save the modified Data.<br>Click on <b>'Reset'</b> to Undo the changes you have done.<br>Click on <b>'Back'</b> to go to the previous Page.");
myKeys[4] = new EzHelpKeywords("ezViewSalesArea","Use this feature to view the Sales Area Details.<br>Click on <b>'Back'</b> to go to the Previous Page.");
		
		//end of salesarea

myKeys[5] = new EzHelpKeywords("ezListEmployee","Use this feature to view the list of Employees.<br>Click on <b>'Add'</b> to add a new Employee.<br><b>Check the checkbox of the desired row and </b><li>Click on <b>'Edit'</b> to modify the existing Employee details.</li><li>Click on <b>'Delete'</b> to delete an Employee .</li>Click on <b>'Cancel'</b> to go to the Home Page.");
myKeys[6] = new EzHelpKeywords("ezAddEmpDirectAdmin","Use this feature to add a new Employee.<br>Enter the details and click on <b>'Save'</b> to add new Employee.<br>Click on <b>'Reset'</b> to undo the changes you have made.<br>Click on <b>'Cancel'</b> to go to the Home Page.");
myKeys[7] = new EzHelpKeywords("ezEditEmp","Use this feature to modify the existing Employee Information.<br>Make necessary changes and click on <b>'Save'</b> to save the modified Data.<br>Click on <b>'Reset'</b> to Undo the changes you have done.<br>Click on <b>'Back'</b> to go to the previous Page.");
myKeys[8] = new EzHelpKeywords("ezEmpDetails","Use this feature to view the Employee Details.<br>Click on <b>'Back'</b> to go to the Previous Page.");

		//end of employee
		
myKeys[9] = new EzHelpKeywords("ezListGroups","Use this feature to view the list of Groups.<br>Click on <b>'Add'</b> to add a new Group.<br><b>To modify a Group</b><li>Check the desired Group and Click on <b>'Edit'</b>.</li><b>To delete a Group,</b><li>Check the desired Group and Click on <b>'Delete'</b></li>Click on <b>'Cancel'</b> to go to the Home Page.");
myKeys[10] = new EzHelpKeywords("ezAddGroup","Use this feature to add new Group.<br>Enter the details and click on <b>'Save'</b> to add a new Group.<br>Click on <b>'Reset'</b> to Undo the changes you have done.<br>Click on <b>'back'</b> to go to the previous Page.");
myKeys[11] = new EzHelpKeywords("ezEditGroup","Use this feature to modify the existing Group Details.<br>Make desired Changes and click on <b>'Save'</b> to save the modified Data.<br>Click on <b>'Reset'</b> to Undo the changes you have done.<br>Click on <b>'Back'</b> to go to the previous Page.");
myKeys[12] = new EzHelpKeywords("ezViewGroups","Use this feature to view the Group Details.<br>Click on <b>'Back'</b> to go to the Previous Page.");

		//end of groups
		
myKeys[13] = new EzHelpKeywords("ezListProducts","Use this feature to view list of Products.<br>Select the <b>'Group'</b> to list the Products.<br>Click on <b>'Add'</b> to add a new Product.<br><b>Check the checkbox of the desired row and</b><li>Click on <b>'Edit'</b> to modify the existing Product Information.</li><li>Click on <b>'Delete'</b> to delete a Product.</li>Click on <b>'Cancel'</b> to go to the  Home Page.");
myKeys[14] = new EzHelpKeywords("ezAddProduct","Use this feature to add a new Product.<br>Enter the details and click on <b>'Save'</b> to add Product.<br>Click on <b>'Reset'</b> to Undo the changes you have done.<br>Click on <b>'back'</b> to go to the previous Page.");
myKeys[15] = new EzHelpKeywords("ezEditProduct","Use this feature to modify the existing Product Details.<br>Make desired Changes and click on <b>'Save'</b> to save the modified Data.<br>Click on <b>'Reset'</b> to Undo the changes you have done.<br>Click on <b>'Back'</b> to go to the previous Page.");
myKeys[16] = new EzHelpKeywords("ezViewProductList","Use this feature to view the ProductDetails.<br>Click on <b>'Back'</b> to go to the Previous Page.");

		//end of products
		// Click on <b>'Reset'</b> to Undo the changes you have done.<br>
myKeys[17] = new EzHelpKeywords("ezLeadListBySalesArea","Use this feature to view the list of Leads by Sales Area.<br>Select '<i><b>Sales Area</b></i>' to view list of Leads.<br><br><b>Check the checkbox of the desired row  and</b> <Li>Click on <b>'EditLead'</b> to modify the existing lead information.</li><li>Click on <b>'EditProduct'</b> to modify the ProductDetails.</li><li>click on <b>'EditErp'</b> to modify the ErpDeatils of the existing Lead.</li><li>Click on <b>'EditContact'</b> to modify the ContactDetails of the  existing lead.</li><li>Click on <b>'EditActivity'</b> to modify the ActivityDeatils of the existing Lead.</li><li>Click on <b>'Delete'</b> to delete the Lead.</li><br>Click on <b>'Cancel'</b> to go to the Home Page.");
myKeys[18] = new EzHelpKeywords("ezListLeadByEmployee","Use this feature to view list of Leads by Employee.<br>Select '<i><b>Employee</b></i>' to view list of Leads.<br><br><b>Check the checkbox of the desired row and </b> <Li>Click on <b>'EditLead'</b> to modify the existing lead information.</li><li>Click on <b>'EditProduct'</b> to modify the ProductDetails.</li><li>click on <b>'EditErp'</b> to modify the ErpDetails of the existing Lead.</li><li>Click on <b>'EditContact'</b> to modify the ContactDetails of the  existing lead.</li><li>Click on <b>'EditActivity'</b> to modify the ActivityDeatils of the existing Lead.</li><li>Click on <b>'Delete'</b> to delete the Lead.</li><br>Click on <b>'Cancel'</b>  to go to the Home Page.");
myKeys[19] = new EzHelpKeywords("ezAddLead","Use this feature to add a new Lead.<br>Enter the Lead Name,select the Sales Area to which the new Lead has to belong,select the responsible Sales Person, enter other necessary details and Click on <b>'Next'</b> to add Products to this Lead.<br>Click on <b>'Reset'</b> to Undo the changes you have done.<br>click on <b>'Cancel'</b> to go to the Home Page.<br><b>Note:</b> Fields marked ' <b>*</b> ' are mandatory.");
myKeys[20] = new EzHelpKeywords("ezAddLeadProduct","Use this feature to add Products to the Lead.<br>Select the Group,Product,probability of getting the Lead,enter other Details and Click on <b>'Next'</b> to add Contact Information of the Lead.<br>Click on <b>'AddMoreProducts'</b>to add more Products to this Lead.<br>Click on <b>'Back'</b> to Modify Lead Details of this Lead.");
myKeys[21] = new EzHelpKeywords("ezAddLeadContact","Use this feature to add Contact Information for the Lead.<br>Enter the contact details and Click on <b>'Next'</b> to add Environment Information of the Lead.<br>Click on <b>'Reset'</b> to Undo the changes you have done.<br>Click on <b>'Back'</b> to Modify the ProductDetails.");
myKeys[22] = new EzHelpKeywords("ezAddLeadErp","Use this feature to add Environment Information of the Lead.<br>Enter the Details and Click on <b>'Next'</b> to add Activity for this Lead.<br>Click on <b>'Reset'</b> to Undo the changes you have done.<br>Click on <b>'Back'</b> to Modify Contact Information of this Lead.");
myKeys[23] = new EzHelpKeywords("ezAddLeadActivity","Use this feature to add Activity for this Lead.<br>Enter the Details and Click on <b>'Save'</b> to save this Lead.<br>Click on <b>'Reset'</b> to Undo the changes you have done.<br>Click on <b>'Back'</b> to Modify Environment Information of this Lead.");
myKeys[24] = new EzHelpKeywords("ezEditLead","Use this feature to Modify LeadDetails.<br>Make desired changes and click on <b>'Save'</b> to save the modifications.<br>If you want to Assign the Lead to some other Sales Area/Sales Person select desired Sales Area/Sales Person and Click on <b>'Save'</b>. <br>Click on <b>'Reset'</b> to Undo the changes you have done.<br>Click on <b>'Cancel'</b>  to go to the Home Page.");
myKeys[25] = new EzHelpKeywords("ezListErp","Use this feature to list Environment Information of particular Lead.<br>Click on 'Erp' link to view the detials.<br><b>Check the checkbox of desired Row and</b><li>Click on <b>'Edit'</b> to modify EnvironmentInformation.</li><li>Click on <b>'Delete'</b> to Delete particular Environment.</li>Click on <b>'Back'</b>  to go to the previous Page.");
myKeys[26] = new EzHelpKeywords("ezEditErp","Use this feature to Modify Environment Information.<br>Make desired changes and Click on <b>'Save'</b> to modify Environment Information.<br>Click on <b>'Reset'</b> to Undo the changes you have done.<br>Click on <b>'Back'</b> to go to the Previous Page.");
myKeys[27] = new EzHelpKeywords("ezViewErp","Use this feature to view Environment Information Details.<br>Click on <b>'Back'</b> to go to the Previous Page");
myKeys[28] = new EzHelpKeywords("ezListContact","Use this feature to list Contact Information of a particular Lead.<br><b>Check the desired checkbox and</b><li>Click on <b>'Edit'</b> to Modify Contact Information.</li><li>Click on <b>'Delete'</b> to delete a particular Contact.</li>Click on <b>'Back'</b>  to go to the previous Page.");
myKeys[29] = new EzHelpKeywords("ezEditContact","Use this feature to modify Contact Information of a particular Lead.<br>Make desired changes and Click on <b>'Save'</b> to modify Contact Information.<br>Click on <b>'Reset'</b> to Undo the changes you have done.<br>Click on <b>'Back'</b> to go to the Previous Page.");
myKeys[30] = new EzHelpKeywords("ezViewContact","Use this feature to view Contact Information Details.<br>Click on <b>'Back'</b> to go to the Previous Page.");
myKeys[31] = new EzHelpKeywords("ezListActivities","Use this feature to view list of Activities for a particular Lead.<br>Click on 'Activity Type' link to view the details.<br><b>Check the desired checkbox and</b><li>Click on <b>'Edit'</b> to Modify Activity.</li><li>Click on <b>'Delete'</b> to delete a particular Activity.</li><li>Blinking image appers when the comment is updated.</li>Click on <b>'Back'</b>  to go to the previous Page.");
myKeys[32] = new EzHelpKeywords("ezEditLeadActivity","Use this feature to modify Activity of a particular Lead.<br>Make desired changes and Click on <b>'Save'</b> to modify Activity details.<br>Click on <b>'Reset'</b> to Undo the changes you have done.<br>Click on <b>'Back'</b> to go to the Previous Page.");
myKeys[33] = new EzHelpKeywords("ezListContactDirect","Use this feature to list Contact Information of a Lead.<br>Select desired Sales Area,Lead to view List of Contacts for that Lead.<br>Click on <b>'Add'</b> to add more Contact Details for that Lead.<br><b>Check the checkbox of desired row and </b><li>click  on <b>'Edit'</b>to modify a particular Contact Details.</li><li>Click on <b>'Delete'</b> to delete particular contact.</li>Click on <b>'Cancel'</b>  to go to the Home Page.");
myKeys[34] = new EzHelpKeywords("ezAddContactDirect","Use this feature to Add Contact Details of a Lead.<br>Select desired Sales Area,Lead to which you want to add Contact ,enter other contact details and click on <b>'Save'</b> to add new Contact.<br>Click on <b>'Reset'</b> to Undo the changes you have done.<br>Click on <b>'Back'</b> to go to the Previous Page.");
myKeys[35] = new EzHelpKeywords("ezEditContactDirect","Use this feature to  modify Contact Information of a particular Lead.<br>Make desired changes and Click on <b>'Save'</b> to modify Contact Information.<br>Click on <b>'Reset'</b> to Undo the changes you have done.<br>Click on <b>'Back'</b> to go to the Previous Page.");
myKeys[36] = new EzHelpKeywords("ezListErpDirect","Use this feature to list Environment Information of a Lead.<br>Select desired Sales Area,Lead to view List of Environments.<br>Click on <b>'Add'</b> to add more Environment Details for that Lead.<br><b>Check the checkbox of desired row and </b><li>Click  on <b>'Edit'</b> to modify a particular Environment Details.</li><li>Click on <b>'Delete'</b> to delete particular Environment.</li>Click on <b>'Cancel'</b>  to go to the Home Page.");
myKeys[37] = new EzHelpKeywords("ezAddErpDirect","Use this feature to Add Environment of a Lead.<br>Select desired Sales Area,Lead to which you want to add Environment,enter other details and click on <b>'Save'</b> to add new Environment.<br>Click on <b>'Reset'</b> to Undo the changes you have done.<br>Click on <b>'Back'</b> to go to the Previous Page.");
myKeys[38] = new EzHelpKeywords("ezEditErpDirect","Use this feature to  modify particular Environment of a Lead.<br>Make desired changes and Click on <b>'Save'</b> to modify Environment Information.<br>Click on <b>'Reset'</b> to Undo the changes you have done.<br>Click on <b>'Back'</b> to go to the Previous Page.");
myKeys[39] = new EzHelpKeywords("ezViewErpDirect","Use this feature to view Environment Information Details.<br>Click on <b>'Back'</b> to go to the Previous Page");
myKeys[40] = new EzHelpKeywords("ezListActivitiesDirect","Use this feature to list the Activities of a Lead.<br>Select desired Sales Area and the 'Lead Name' ,to view the activities related to that Lead.<br>Click on <b>'Add'</b> to add more Activities for that Lead.<br><b>Check the checkbox of the desired row and </b><li>Click  on <b>'Edit'</b> to modify a particular Activity.</li><li>Click on <b>'Delete'</b> to delete particular Activity.</li>Click on <b>'Cancel'</b>  to go to the Home Page.");
myKeys[41] = new EzHelpKeywords("ezAddActivityDirect","Use this feature to Add Activity for a Lead.<br>Select desired Sales Area,Lead to which an activity is to be added ,enter other Activity details and click on <b>'Save'</b> to add a new Activity.<br>Click on <b>'Reset'</b> to undo the changes you have made.<br>Click on <b>'Cancel'</b>  to go to the Home Page.");
myKeys[42] = new EzHelpKeywords("ezEditActivityAddDirect","Use this feature to  modify an Activity of a Lead.<br>Make desired changes and click on <b>'Save'</b> to modify that Activity.<br>Click on <b>'Reset'</b> to undo the changes you have made.<br>Click on <b>'Back'</b>  to go to the Previous Page.");
myKeys[43] = new EzHelpKeywords("ezViewActivityAddDirect","Use this feature to view Activity Details.<br>Click on <b>'Back'</b> to go to the previous page");
myKeys[44] = new EzHelpKeywords("ezViewActivityDirect","Use this feature to view Activity Details.<br>To modify the 'created' status of the activity to InProgress(if the activity yet to complete)/Completed(if the activity is completed) select the desired status.<br>Admin/Manager can add/modify the comments.<br>Click on <b>'Save'</b> button to modify the changes.<br> Click on <b>'Back'</b> to go to the previous page");


		//end of leads.
		
myKeys[45] = new EzHelpKeywords("ezSearchByName","Use this feature to search Leads based on their LeadName.<br>Select desired search condition and enter the search criteria.Click on <b>'Go'</b> to view the leads that satisfy the search condition specified.<br><b>Eg:</b>To get the Leads that start with <b>'LEA'</b> select search condition as 'StartsWith',enter the criteria as 'LEA' and Click on 'Go' to view the results.<br>In the list displayed after searching,click on <b>'LeadName'</b> to view Lead Details .<br>Click on <b>'Cancel'</b>  to go to the Home Page.");		
myKeys[46] = new EzHelpKeywords("ezSearchByErp","Use this feature to search Leads based on the Environment to which they belong to.<br>Select desired search condition,Enter the search criteria and click on <b>'Go'</b> to view the leads that satisfy the specified search condition.<br><b>Eg:</b>To get list of Leads which has Environment that starts with <b>'ERP'</b> select search condition as 'StartsWith',enter the criteria as 'ERP' and Click on 'Go' to view the results.<br>In the list displayed after searching ,click on <b>'LeadName'</b> to view Lead Details.<br>Click on <b>'Cancel'</b>  to go to the Home Page.");		

		//end of search.
		
myKeys[47] = new EzHelpKeywords("ezMonthsCalendar","Use this feature to view list of Reminders.<br>To view Previous/Next month reminder click on 'Prev'/'Next'<br>Click on desired 'Date'  to view the Reminders on that day.<br>Click on desired time to add new a Reminder.<br>To modify a reminder click on desired timing.<br>Click on 'Description' of the desired timing to View Reminder Details.<br>Click on Delete image to Delete a particular Reminder.<br>Reminder in <b>'Red'</b> color indicates an incomplete Reminder.<br>Reminder in <b>'Green'</b> color indicates a completed Reminder. ");
myKeys[48] = new EzHelpKeywords("ezAddDayDetails","Use this feature to add Reminder.<br>Enter the details and click on <b>'Save'</b> to add new Reminder.<br>Click on <b>'Reset'</b> to Undo the changes you have done.<br>Click on <b>'Back'</b> to go to the Previous Page.");
myKeys[49] = new EzHelpKeywords("ezEditDayDetails","Use this feature to modify the Reminder.<br>Make desired changes and click on <b>'Save'</b> to modify the Reminder.<br>Click on <b>'Reset'</b> to Undo the changes you have done.<br>Click on <b>'Back'</b> to go to the Previous Page.");
myKeys[50] = new EzHelpKeywords("ezViewDayDetails","Use this feature to view Reminder details.<br>Click on <b>'Back'</b> to go to the Previous Page");
myKeys[51] = new EzHelpKeywords("ezCalendarDetails","Use this feature to view  Activities .<br>To view previous/next month Activity click on 'Prev'/'Next'.<br>Lead Name will be displayed on the calender if there is any activity on that particular day,by keeping the mouse on that LeadName you can view the activity details. <br>Click on the desired 'Date' to view Reminders of that day.<Br>");
myKeys[52] = new EzHelpKeywords("ezByEmpCalendarDetails","Use this feature to view  Activities of the selected Employee.<br>Select the Employee to view the Activities.<br>To view previous/ next month Activity click on 'Prev'/'Next'.<br>Lead Name will be displayed on the calendar if there is any activity on that particular day,by keeping the mouse on that LeadName you can view the activity details. <br>Click on the desired 'Date' to view Reminders of that day.<br>");

//have to modify yet.

	//end of Reminders.

myKeys[53] = new EzHelpKeywords("ezSalesAreaReports","Use this feature to view Estimated sales based on the Sales Area in the selected year.<br>Select the year,type of graph  and click on <b>'Go'</b> to view the sales in the selected year based on 'Sales Area'.<br>Click on desired Sales Area bar in the graph to view sales based on Month.<br>Click on desired Month in the graph to view sales based on Group.  <br>Click on desired Group bar in the graph to view sales based on Product.");
myKeys[54] = new EzHelpKeywords("ezGraphByEmp","Use this feature to view Estimated sales based on the Employee in the selected year.<br>Select the year,type of graph  and click on <b>'Go'</b> to view the sales in the selected year based on 'Employee'.<br>Click on desired Employee bar in the graph to view sales based on Month.<br>Click on desired Month in the graph to view sales based on Group.  <br>Click on desired Group bar in the graph to view sales based on Product.");

	//end of reports.
	
myKeys[55] = new EzHelpKeywords("ezListLibraryFiles","Use this feature to view list of files in the Library.<br>You can upload documents by clicking <b>'Add'</b> button.<br>Click on File Name to DownLoad the file.<br><b>To delete the file,</b><br>Check the checkbox of desired file and click on <b>'Delete'</b>. <br>Click on <b>'Cancel'</b>  to go to the Home Page.");
myKeys[56] = new EzHelpKeywords("ezUploadFile","Use this feature to store documents.<br>Click on <b>'Browse'</b> to select desired file and click on <b>'Upload'</b> to store it in the Library.<br>Click on <b>'Reset'</b> to cancel the selection you have made.<br>Click on <b>'Back'</b> to go to the previous page");

	//end of library.
myKeys[57] = new EzHelpKeywords("ezChangePassword","Use this feature to change your Password.<br>Enter the old password, new password and the same in confirm password .<br>Click on <b>'Save'</b> to change the Password.<br>Click on <b>'Reset'</b> to undo the changes you have made.<br>Click on <b>'Cancel'</b>  to go to the Home Page.<br>Note:<b>*</b> Indicates Mandatory fields.");
myKeys[58] = new EzHelpKeywords("ezResetPassword","Use this feature to Change the Password of a selected Employee.<br>Enter the new password and the same in confirm password.<br>Click <b>'Save'</b> to change the Password.<br>Click on <b>'Reset'</b> to undo the changes you have made.<br>Click on <b>'Cancel'</b>  to go to the Home Page.<br>Note:<b>*</b> Indicates Mandatory fields.");

	//end of password.
	
	
//view leads goes here 

myKeys[59] = new EzHelpKeywords("ezViewLead","Use this feature to View Lead Details.<br>Click on <b>'View Product'</b> to view product details.<br>Click on <b>'View Environment'</b> to view environment details.<br>Clcik on <b>'View Contact'</b> to view contact details.<br>Clcik on <b>'View Activity'</b> to view activities.<br>Click on <b>'Back'</b>to go to the previous page.");
myKeys[60] = new EzHelpKeywords("ezViewLeadProducts","Use this feature to View product details.<br>Click on <b>'Back'</b> to go to the previous page.");
myKeys[61] = new EzHelpKeywords("ezViewListErp","Use this feature to View Environment details.<br>Click on <b>'Back'</b> to go to the previous page.");
myKeys[62] = new EzHelpKeywords("ezViewListContact","Use this feature to View list of Contacts.<br>Click on 'Contact Person Name' link to view the contact details.<br>Click on <b>'Back'</b> to go to the previous page.");
myKeys[63] = new EzHelpKeywords("ezViewActivitiesList","Use this feature to View Activities.<br>Click on 'Activity Type' link to view the Activity details.<br>Modification in the comments since last login can be identified by the 'image'. <br>Click on <b>'Back'</b> to go to the previous page.");
myKeys[64] = new EzHelpKeywords("ezViewActivity","Use this feature to view Activity Details.<br>To modify the  'created' status of the activity to InProgress(if the activity yet to complete)/Completed(if the activity is completed) select the desired status.<br>Admin/Manager can add/modify the comments.<br>Click on <b>'Save'</b> button to modify the changes.<br> Click on <b>'Back'</b> to go to the previous page");
myKeys[65] = new EzHelpKeywords("ezListLeadProducts","Use this feature to view list of Products.<br><b>Check the desired row, </b><li>Click on <b>'Edit'</b> to modify the product details.</li><li>Click on <b>'Add More Products'</b> to add more products.<li>Click on <b>'Delete'</b> to delete a product.</li>Click on <b>'Back'</b> to go to the previous page.");
myKeys[66] = new EzHelpKeywords("ezDayDetailsList","Use this feature to view list of Reminders.<br>Click on 'Description' link o view reminder details<br>Click on '<b>Back</b>' to go to the previous page");
myKeys[67] = new EzHelpKeywords("ezViewDayDetailsList","Use this feature to view reminder details.<br>Click on <b>'Back'</b> to go to the previous page.");
myKeys[68] = new EzHelpKeywords("ezSearchEmpActivities","Use this feature to view list of activities of an employee based on the follow up dates.<br>Select the desired employee,click on 'calendar image' to enter the follow up date from ,follow up date to and click on <b>'Go'</b> to view list of activities.<br>Click on 'Activity Type' link to view details.<br>Click on <b>'Back'</b> to go to the previous page.");
myKeys[69] = new EzHelpKeywords("ezListLeadProducts","Use this feature to view list of products.<br>If the there is no products list,Click on '<b>Add</b>' to add product. <br>Check the desired row,click on <b>'Edit'</b> to modify the product details.<br>Check the desired row,click on '<b>Delete</b>' to delete the product <br> Check the desired row,click on '<b>Add More Products</b>' to add products.<br>Click on <b>'Back'</b> to go to the previous page.");
myKeys[70] = new EzHelpKeywords("ezEditLeadProduct","Use this feature to Modify product details.<br>Make desired changes and click on <b>'Save'</b> to save the modifications. <br>Click on <b>'Reset'</b> to Undo the changes you have done.<br>Click on <b>'Back'</b> to go to the Previous Page.");
myKeys[71] = new EzHelpKeywords("ezEditAddLeadProducts","Use this feature to add products.<br>Enter the details and click on <b>'Save'</b> to add product.<br>Click on <b>'Add More Products'</b> to add more products.<br>Click on '<b>Reset</b>' to undo the changes made.<br>Clcl on <b>'Back'</b> to go to the previous page.");
myKeys[72] = new EzHelpKeywords("ezListLeadManager","Use this feature to view the list of leads that are already contacted .<br>Click on '<b>Cancel</b>' to go to home page.");
myKeys[73] = new EzHelpKeywords("ezAddAssignment","Use this feature to assign the lead to some other sales area / employee.<br>Select desired Lead which you want to assign ,select desired sales area,sales person and click on 'Save / Update Assignment' to assign the selected lead to that particular sales area / sales person.");



//mail option starts here


myKeys[74] = new EzHelpKeywords("ezInbox","Use this feature to view list of mails.<br>Click on mail <b>'Subject'</b> to view mail details.<br>Click on <b>'SelectAll'</b> to select all the mails.<br>Click on <b>'Delete'</b> to delete mails.<br>Click on <b>'Move To'</b> to move mails to another folder.<br>Click on <b>'Cancel'</b> to go to home page.");
myKeys[75] = new EzHelpKeywords("ezComposeMail","Use this feature to compose mails.<br>Enter mail id of the recipient in <b>'To'</b> field.<br>Click on <b>'SendMail'</b> to send mail.<br>Click on <b>'AttachFile'</b> to attach files to mail.<br>Click on <b>'Cancel'</b> to go to home page.");
myKeys[76] = new EzHelpKeywords("ezListFolders","Use this feature to view list of folders.<br>Click on folder description to view folder mails.<br>Click on <b>'Create'</b> to create new folder.<br>Click on <b>'Delete'</b> to delete folder.<br>Click on <b>'Cancel'</b> to go to home page.");
myKeys[77] = new EzHelpKeywords("ezCreateFolder","Use this feature to create new folder.<br>Enter folder name and click on <b>'Create'</b> to create new folder.<br>Click on <b>'Reset'</b> to Undo the changes you have done.<br>Click on <b>'Back'</b> to go to previous page.");
myKeys[78] = new EzHelpKeywords("ezReadMail","Use this feature to view mail content.<br>Click on <b>'Reply'</b> to reply to the mail.<br>Click on <b>'Delete'</b> to delete mail.<br>Click on <b>'Back'</b> to go to previous page.");
myKeys[79] = new EzHelpKeywords("ezReadFolderMail","Use this feature to view mail content.<br>Click on <b>'Reply'</b> to reply to the mail.<br>Click on <b>'Delete'</b> to delete mail.<br>Click on <b>'Back'</b> to go to previous page.");
myKeys[80] = new EzHelpKeywords("ezReplyMail","Use this feature to reply mail.<br>Click on <b>'SendMail'</b> to send mail.<br>Click on <b>'AttachFile'</b> to attach files to mail.<br>Click on <b>'Back'</b> to go to previous page.");

myKeys[81] = new EzHelpKeywords("ezSearchEmpActivitiesUser","Use this feature to view list of activities based on the follow up dates.<br>Click on 'calendar image' to enter the follow up date from ,follow up date to and click on <b>'Go'</b> to view list of activities.<br>Click on 'Activity Type' link to view details.<br>Click on <b>'Back'</b> to go to the previous page.");

function BrowserCheck() {
	var b = navigator.appName
	if (b=="Netscape") this.b = "ns"
	else if (b=="Microsoft Internet Explorer") this.b = "ie"
	     else this.b = b
	this.version = navigator.appVersion
	this.v = parseInt(this.version)
	this.ns = (this.b=="ns" && this.v>=4)
	this.ns4 = (this.b=="ns" && this.v==4)
	this.ns5 = (this.b=="ns" && this.v==5)
	this.ie = (this.b=="ie" && this.v>=4)
	this.ie4 = (this.version.indexOf('MSIE 4')>0)
	this.ie5 = (this.version.indexOf('MSIE 5')>0)
	this.min = (this.ns||this.ie)

 }
 is = new BrowserCheck();

var poptext
function ezPOPUp(msg,myDIV)
{
	poptext = myDIV.style;
	var docPath = "";
	var winHeight=0;
	
	if(top.display){
		docPath=top.display.document
		winHeight=top.display.window.innerHeight
	}else
		if(top.main.display){
			docPath=top.main.display.document
			winHeight=top.main.display.window.innerHeight
		}else{
			docPath=top.main.document
			winHeight=top.main.window.innerHeight
		}
	var content ="<Table width=300 class=tablehelp align = center><Tr><Td class=tdhelp><Table WIDTH=100% CELLPADDING=2 CELLSPACING=2 class=tablesubhelp align = center><Tr><Td  class=tdhelp><p style='align:justify'>"+msg+"</p></Td></TR></Table></Td></TR></Table>";
	if (is.ns4)
	{
	    poptext.document.write(content);
	    poptext.document.close();
	    poptext.visibility = "visible";
  	}
   	else if (is.ie || is.ns)
	{

	  myDIV.innerHTML = content;
	 if (is.ns){
	  	poptext.top =winHeight+2  - myDIV.scrollHeight;
		poptext.left=-490
	 }else{
	  	poptext.top =docPath.body.clientHeight  - myDIV.scrollHeight;
	}
     	 poptext.visibility = "visible";
  	}

}
function ezPOPOut()
{
	if (!(top.display)){
		listBoxHide()
	}
	poptext.visibility = "hidden";
}

function listBoxHide(){
  if(top.main.display)
  		docPath=top.main.display.document
  	else
		docPath=top.main.document

  	listBoxIds=docPath.getElementsByTagName("select")
  	if(listBoxIds!=null)
  	{
  		 for(i=0;i<listBoxIds.length;i++)
  		 {
  		      if(listBoxIds[i].id=="ShowHelp")
  			     listBoxIds[i].style.width="100%"
  			 }
	}

}

	
