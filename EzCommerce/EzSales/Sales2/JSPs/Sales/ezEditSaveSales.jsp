<%@ page import = "ezc.ezparam.*,ezc.ezbasicutil.*,ezc.ezutil.FormatDate,java.util.*" %>
<%@ include file= "../../../Includes/Lib/ezSessionBean.jsp" %>
<jsp:useBean id= "editSalVal" class="ezc.sales.params.EzSalesSetPropParams"/>
<jsp:setProperty name="editSalVal" property="*"/>
<jsp:useBean id="ConfigManager" class="ezc.client.EzSystemConfigManager" scope="session"></jsp:useBean>
<%
	ezc.ezcommon.EzLog4j log4j = new ezc.ezcommon.EzLog4j(); 

	ReturnObjFromRetrieve orderError=null; 
	
	String sysKey   =(String)session.getValue("SalesAreaCode");
	String docType	="TA";//(String)session.getValue("docType");
	String Div	=(String)session.getValue("division");
	String DC 	=(String)session.getValue("dc");
	String SalesOrg	=(String)session.getValue("salesOrg");

	ReturnObjFromRetrieve reterpdef = null;
	ReturnObjFromRetrieve orders =null;
	java.util.Hashtable reqQtyHT = new java.util.Hashtable();    
//end here
	String unitQty[] 	= request.getParameterValues("unitQty");
        String backEndNo 	= request.getParameter("backEndNo");	
        String carrierName	= request.getParameter("carrierName");
	String UserRole 	= (String)session.getValue("UserRole");  
	String generalNotesAll	= null;
        String status 		= null;
	String orderDate	= null;  
        String soNo 		= editSalVal.getSoNo();     
          
//===============================================================================    
        String generalNotes 		= editSalVal.getGeneralNotes();
	String packingInstructions 	= editSalVal.getPackingInstructions();
	String labelInstructions 	= editSalVal.getLabelInstructions();
	String inspectionClauses 	= editSalVal.getInspectionClauses();
	String handlingSpecifications 	= editSalVal.getHandlingSpecifications();
	String regulatoryRequirments 	= editSalVal.getRegulatoryRequirements();
	String documentsRequired 	= editSalVal.getDocumentsRequired();
	String others 			= editSalVal.getOthers();
	String generalNotes1		= editSalVal.getGeneralNotes1();
	String generalNotes2		= editSalVal.getGeneralNotes2();
	String generalNotes3		= editSalVal.getGeneralNotes3();  
	
	String shTpZone		= request.getParameter("tpZone");  
	String shJurCode	= request.getParameter("jurisdiction"); 
	String shFax		= request.getParameter("faxNumber"); 
	String shTel		= request.getParameter("telNumber"); 
	String shMobi		= request.getParameter("mobileNumber"); 
	String shAttn		= request.getParameter("shAttn"); 
	String billTPZone	= request.getParameter("billTPZone");  
	String billJurCode	= request.getParameter("billJurCode");   
	
	generalNotes 		= ((generalNotes==null)||(generalNotes.trim().length()==0))?"None":EzReplace.setReplace(generalNotes);
	packingInstructions 	= ((packingInstructions==null)||(packingInstructions.trim().length()==0))?"None":EzReplace.setReplace(packingInstructions);
	labelInstructions 	= ((labelInstructions==null)||(labelInstructions.trim().length()==0))?"None":EzReplace.setReplace(labelInstructions);
	inspectionClauses 	= ((inspectionClauses==null)||(inspectionClauses.trim().length()==0))?"None":EzReplace.setReplace(inspectionClauses);
	handlingSpecifications 	= ((handlingSpecifications==null)||(handlingSpecifications.trim().length()==0))?"None":EzReplace.setReplace(handlingSpecifications);
	regulatoryRequirments 	= ((regulatoryRequirments==null)||(regulatoryRequirments.trim().length()==0))?"None":EzReplace.setReplace(regulatoryRequirments);
	documentsRequired 	= ((documentsRequired==null)||(documentsRequired.trim().length()==0))?"None":EzReplace.setReplace(documentsRequired);
	others 			= ((others==null)||(others.trim().length()==0))?"None":EzReplace.setReplace(others);
	generalNotes1 		= ( (generalNotes1==null)||(generalNotes1.trim().length()==0))?"None":EzReplace.setReplace(generalNotes1);
	generalNotes2 		= ( (generalNotes2==null)||(generalNotes2.trim().length()==0))?"None":EzReplace.setReplace(generalNotes2);
	generalNotes3 		= ( (generalNotes3==null)||(generalNotes3.trim().length()==0))?"None":EzReplace.setReplace(generalNotes3);
	generalNotesAll		= "GeneralNotes@@ezc@@"+generalNotes.trim()+"^^ezc^^PackingInstructions@@ezc@@"+packingInstructions.trim()+"^^ezc^^LabelInstructions@@ezc@@"+labelInstructions.trim()+"^^ezc^^InspectionClauses@@ezc@@"+inspectionClauses.trim()+"^^ezc^^HandlingSpecifications@@ezc@@"+handlingSpecifications.trim()+"^^ezc^^Requlatoryrequirments@@ezc@@"+regulatoryRequirments.trim()+"^^ezc^^DocumentsRequired@@ezc@@"+documentsRequired.trim()+"^^ezc^^Others@@ezc@@"+others.trim();
      
	String salesAreaName 	= (String)session.getValue("Country");
	int Rows		= Integer.parseInt(editSalVal.getTotal()); 
	
	status 			= editSalVal.getStatus();
	orderDate 		= editSalVal.getOrderDate();
	String paymentterms 	= editSalVal.getPaymentTerms();       
               
	if(paymentterms != null) 
	{	
	        int f=0;
		try
		{
			f	= Integer.parseInt(paymentterms); 
			int l	= paymentterms.length();
			String ss="";					
			if(l==1)
			{
				ss="   ";    
			}
			else if(l==2)
			{
				ss="  ";
			}else if(l==3)
			{
				ss=" ";
			}
			paymentterms = ss+paymentterms;
		}catch(Exception e){}		
	}
	String ErrorType 	= "";
	String ErrorMessage 	= "";
	int maxLine 		= 0;
	int[] prodCodes 	= new int[Rows];

	String[] prodCode_1 = editSalVal.getLineNo(); 	//request.getParameterValues("lineNo");
        for(int i=0;i<Rows;i++)
	{
		prodCodes[i]=Integer.parseInt(prodCode_1[i]);
	}
	
	for (int i=0;i<prodCodes.length-1;i++)
	{
		for (int j=i+1;j<prodCodes.length;j++)
		{
			if (prodCodes[i] > prodCodes[j])
			{
				int temp=prodCodes[i];		
				prodCodes[i]=prodCodes[j];
				prodCodes[j]=temp;
			}	
		}
	}
	maxLine = prodCodes[prodCodes.length-1];

	ReturnObjFromRetrieve retSch=(ReturnObjFromRetrieve) session.getValue("EzDeliveryLines");
	int maxSchLine =0;
	int[] schcodes = new int[retSch.getRowCount()];

	for(int i=0;i<retSch.getRowCount();i++)
	{
		String p = retSch.getFieldValueString(i,"EZDS_SCHED_LINE");
		schcodes[i]=Integer.parseInt(p);
	}
	for (int i=0;i<schcodes.length-1;i++)  
	{
	 	for (int j=i+1;j<schcodes.length;j++)
		{
			if (schcodes[i] > schcodes[j])
			{
				int temp	= schcodes[i];		
				schcodes[i]	= schcodes[j];
				schcodes[j]	= temp;
			}	
		}
	}
	maxSchLine = schcodes[schcodes.length-1];
                  
	try
	{
	/*
		ezc.eztrans.EzTransactionParams params=new ezc.eztrans.EzTransactionParams();
		params.setSite("100");          //connection group number.
		params.setObject("SALESORDER"); //the table name.
		params.setKey(soNo.trim());//the row which u want to lock
		params.setUserId(Session.getUserId());//login user id
		params.setId(session.getId());//http session id
		params.setOpType("RELEASE");//to keep lock on the particular row.
		ezc.eztrans.EzTransaction trans = new ezc.eztrans.EzTransaction();
		trans.ezValidTrans(params);
	*/                               
 %>
 	<%@ include file="../../../Includes/JSPs/Lables/iEditSaveSales_Lables.jsp" %>
 	<body>
 	<Form target=main>
<%	try
	{
%>		<%@ include file="../../../Includes/JSPs/Sales/iEditSaveSales.jsp" %>    
<%	}
	catch(Exception e)
	{
		log4j.log("ERROR in iEdit Save page "+e,"W");      
	}
%>
	
	</form>
<%	}
	catch(Exception e)
	{
	
		log4j.log("EEEEEEEEEERRRRRRROOOOOOOORRRRRRR"+e,"W");
		response.sendRedirect("ezTransLockError.jsp?webOrNo="+soNo+"&exp="+e.getMessage() );
	}
%>
<jsp:forward page="../Misc/ezOutMsg.jsp"></jsp:forward>     
<Div id="MenuSol"></Div>