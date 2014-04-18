<%@ page import = "ezc.ezparam.*,ezc.ezbasicutil.*,ezc.ezutil.FormatDate,java.util.*" %>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezSalesBean.jsp" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp" %>
<jsp:useBean id="setSalVal" class="ezc.sales.params.EzSalesSetPropParams"/>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<jsp:setProperty name="setSalVal" property="*"/>
<% 

	log4j.log("in AddSaveQuote in AddSaveQuote in AddSaveQuote in AddSaveQuote in AddSaveQuote1","W");

	String product,productDesc,name,desiredQty,desiredDate,desiredPrice,netValue,plant,Currency,custProd;
	String requiredPrice,listPrice,itemPrice,itemOrgPrice;
	ReturnObjFromRetrieve itemoutTable 	= null;
	Hashtable getBonus = new Hashtable();
	String UserType = (String)session.getValue("UserType");
	UserType=UserType.trim();
	String UserRole = (String)session.getValue("UserRole");
	UserRole=UserRole.trim();
	String agent = (String)session.getValue("Agent");
	agent = agent.trim();
	String soldTo = request.getParameter("soldTo"); 
	String salesAreaCode = (String)session.getValue("SalesAreaCode");
	String salesAreaName = (String)session.getValue("Country");
	salesAreaCode = salesAreaCode.trim(); 
	ezc.ezcommon.EzLog4j.log("This message is to check the version control::::","I");
	System.out.println("Addding a new line to the changes");
	System.out.println("Addding a new line to the changes by different user of the team");
	System.out.println("Hot fix issues added");

	String status = setSalVal.getStatus(); 
	String status = setSalVal.getStatus();

	boolean NEW 		= false;	if(("New").equalsIgnoreCase(status)) NEW = true;
	boolean TRANSFERED 	= false;	if(("Transfered").equalsIgnoreCase(status))TRANSFERED= true;
	String paymentterms = setSalVal.getPaymentTerms();
	
	log4j.log("in AddSaveQuote in AddSaveQuote in AddSaveQuote in AddSaveQuote in AddSaveQuote2","W");

	if(paymentterms != null)              
	{         
		try 
		{
			int l=paymentterms.length();    
			String ss="";
			if(l==1)
				ss="   ";      
			else if(l==2)
				ss="  ";
			else if(l==3)
				ss=" ";   
			paymentterms = ss+paymentterms;  
		}catch(Exception e){}
	}
	
	log4j.log("in AddSaveQuote in AddSaveQuote in AddSaveQuote in AddSaveQuote in AddSaveQuote3","W");
	
	String msg  = null;
	String user = Session.getUserId();
	user=user.trim();
	
	log4j.log("in AddSaveQuote in AddSaveQuote in AddSaveQuote in AddSaveQuote in AddSaveQuote4","W");
	
	String[] prodCode_1 	= request.getParameterValues("product");	//setSalVal.getProduct();
	String[] prodDesc_1 	= request.getParameterValues("prodDesc");	//setSalVal.getProdDesc();
	String[] prodDQty_1 	= request.getParameterValues("desiredQty");	//setSalVal.getDesiredQty();
	String[] prodCQty_1 	= request.getParameterValues("commitedQty");	//setSalVal.getCommitedQty();
	String[] prodPack_1 	= request.getParameterValues("pack");		//setSalVal.getPack();
	String[] prodItemCat_1 	= request.getParameterValues("ItemCat");
	String[] prodUomQty	= request.getParameterValues("UomQty");
	String[] custprodCode	= request.getParameterValues("custprodCode");
	String[] itemVenCatalog	= request.getParameterValues("itemVenCatalog");
	
	String[] itemMfrPart	= request.getParameterValues("itemMfrPart"); 
	String[] itemMfrNr	= request.getParameterValues("itemMfrNr"); 
	String[] itemEanUPC	= request.getParameterValues("itemEanUPC"); 
	String[] itemMatId	= request.getParameterValues("itemMatId");
	String[] itemMmFlag	= request.getParameterValues("itemMmFlag");
	String[] itemDiscCode	= request.getParameterValues("itemDiscCode");
	String[] itemWeight	= request.getParameterValues("itemWeight");
	
	String shTpZone		= request.getParameter("tpZone");  
	String shJurCode	= request.getParameter("jurisdiction"); 
	String shFax		= request.getParameter("faxNumber"); 
	String shTel		= request.getParameter("telNumber"); 
	String shMobi		= request.getParameter("mobileNumber"); 
	String shAttn		= request.getParameter("shAttn"); 
	String billTPZone	= request.getParameter("billTPZone");  
	String billJurCode	= request.getParameter("billJurCode");
	String freightWeight 	= request.getParameter("weight");
	String freightPrice 	= request.getParameter("freightVal");
	String fServType 	= request.getParameter("fServType");
	String freightIns	= request.getParameter("freightIns");
	
	int prodCodeLength =prodCode_1.length; 

	log4j.log("in AddSaveQuote in AddSaveQuote in AddSaveQuote in AddSaveQuote in AddSaveQuote52"+prodCodeLength,"W");

	String[] desiredDate_1 = request.getParameterValues("desiredDate");	//setSalVal.getDesiredDate();
	String[] lineValue_1   = request.getParameterValues("lineValue");	//setSalVal.getLineValue();
	String[] desiredPrice_1= request.getParameterValues("desiredPrice");	//setSalVal.getDesiredPrice();
	String[] itemListPrice = request.getParameterValues("itemListPrice");	//setSalVal.getDesiredPrice();
	String[] itemOrgPrice_1= request.getParameterValues("itemOrgPrice");
	String[] listPrice_1 = request.getParameterValues("listPrice");		//portal list price
	//String[] requiredPrice_1 = request.getParameterValues("requiredPrice");	//customer neg. price
	
	log4j.log("in AddSaveQuote in AddSaveQuote in AddSaveQuote in AddSaveQuote in AddSaveQuote5"+prodCodeLength,"W");

	//String[] del_sch_qty_1 = setSalVal.getDel_sch_qty();
	//String[] del_sch_date_1= setSalVal.getDel_sch_date();  
	String incoTerms1      = setSalVal.getIncoTerms1();
	String incoTerms2      = setSalVal.getIncoTerms2();

	log4j.log("in AddSaveQuote in AddSaveQuote in AddSaveQuote in AddSaveQuote in AddSaveQuote53"+prodCodeLength,"W");
	
	incoTerms1=(incoTerms1==null)?" ":incoTerms1;
	incoTerms2=(incoTerms2==null)?" ":EzReplace.setReplace(incoTerms2);

	log4j.log("in AddSaveQuote in AddSaveQuote in AddSaveQuote in AddSaveQuote in AddSaveQuote6","W");

	//String paymentTerm    = request.getParameter("paymentTerm");	//for CRI
	String paymentTerm = "Z030";	//Hard coded to Net 30 days -- for CRI
	
	//String carrierName    = request.getParameter("shippingTypeVal");
	String carrierName    = request.getParameter("shippingType");	//for CRI
	String shipType = "";
	
	try
	{
		shipType = carrierName.split("#")[0];
	}
	catch(Exception e)
	{
		shipType = "";
	}

	log4j.log("in AddSaveQuote in AddSaveQuote in AddSaveQuote in AddSaveQuote in AddSaveQuote--shipType:-->"+shipType,"W");
	log4j.log("in AddSaveQuote in AddSaveQuote in AddSaveQuote in AddSaveQuote in AddSaveQuote--carrierName:-->"+carrierName,"W");
	
	String shippingCond    = request.getParameter("shippingCond");
	shippingCond	= carrierName;
	shippingCond=(shippingCond==null)?" ":shippingCond;
	
	String generalNotesAll = "";
	String generalNotes 		= setSalVal.getGeneralNotes();
	String packingInstructions 	= setSalVal.getPackingInstructions();  
	String labelInstructions 	= setSalVal.getLabelInstructions();
	String inspectionClauses 	= setSalVal.getInspectionClauses();
	String handlingSpecifications 	= setSalVal.getHandlingSpecifications();   
	String regulatoryRequirments 	= setSalVal.getRegulatoryRequirements();
	String documentsRequired 	= setSalVal.getDocumentsRequired();
	String others 			= setSalVal.getOthers();
	String generalNotes1		= setSalVal.getGeneralNotes1();
	String generalNotes2		= setSalVal.getGeneralNotes2();
	String generalNotes3		= setSalVal.getGeneralNotes3();

	log4j.log("in AddSaveQuote in AddSaveQuote in AddSaveQuote in AddSaveQuote in AddSaveQuote7","W");

	generalNotes 		= ((generalNotes==null)||(generalNotes.trim().length()==0))?"None":EzReplace.setReplace(generalNotes);
	packingInstructions 	= ((packingInstructions==null)||(packingInstructions.trim().length()==0))?"None":EzReplace.setReplace(packingInstructions);
	labelInstructions 	= ((labelInstructions==null)||(labelInstructions.trim().length()==0))?"None":EzReplace.setReplace(labelInstructions);
	inspectionClauses 	= ((inspectionClauses==null)||(inspectionClauses.trim().length()==0))?"None":EzReplace.setReplace(inspectionClauses);
	handlingSpecifications 	= ((handlingSpecifications==null)||(handlingSpecifications.trim().length()==0))?"None":EzReplace.setReplace(handlingSpecifications);
	regulatoryRequirments 	= ((regulatoryRequirments==null)||(regulatoryRequirments.trim().length()==0))?"None":EzReplace.setReplace(regulatoryRequirments);
	documentsRequired 	= ((documentsRequired==null)||(documentsRequired.trim().length()==0))?"None":EzReplace.setReplace(documentsRequired);
	others 			= ((others==null)||(others.trim().length()==0))?"None":EzReplace.setReplace(others);
	generalNotes1 		= ((generalNotes1==null)||(generalNotes1.trim().length()==0))?"None":EzReplace.setReplace(generalNotes1);
	generalNotes2 		= ((generalNotes2==null)||(generalNotes2.trim().length()==0))?"None":EzReplace.setReplace(generalNotes2);
	generalNotes3 		= ((generalNotes3==null)||(generalNotes3.trim().length()==0))?"None":EzReplace.setReplace(generalNotes3);
	generalNotesAll		="GeneralNotes@@ezc@@"+generalNotes.trim()+"^^ezc^^PackingInstructions@@ezc@@"+packingInstructions.trim()+"^^ezc^^LabelInstructions@@ezc@@"+labelInstructions.trim()+"^^ezc^^InspectionClauses@@ezc@@"+inspectionClauses.trim()+"^^ezc^^HandlingSpecifications@@ezc@@"+handlingSpecifications.trim()+"^^ezc^^Requlatoryrequirments@@ezc@@"+regulatoryRequirments.trim()+"^^ezc^^DocumentsRequired@@ezc@@"+documentsRequired.trim()+"^^ezc^^Others@@ezc@@"+others.trim();

	ReturnObjFromRetrieve orderError=null;
	String ErrorType 	="";
	String ErrorMessage 	="";
	boolean SAPnumber 	=true;
   	String sDocNumber 	= null;	
   	String sTempDocNumber 	= null;	
	String weborno 		= null;
	String docType	=(String)session.getValue("docType");
	String Div	=(String)session.getValue("division");
	String DC 	=(String)session.getValue("dc");
	String SalesOrg	=(String)session.getValue("salesOrg");
	ReturnObjFromRetrieve reterpdef = null;
	ReturnObjFromRetrieve orders =null;

	log4j.log("in AddSaveQuote in AddSaveQuote in AddSaveQuote in AddSaveQuote in AddSaveQuote4","W");
%>
<Html>
<Body>
<Form target=main>   
<%
	try
	{
%>		 
		<%@ include file="../../../Includes/JSPs/Quotation/iAddSaveQuote.jsp"%>   
<%	
	}
	catch(Exception e)
	{
		System.out.println("Error in iAddSaveQuote.jsp");  
	}
%>
</Form>
<Div id="MenuSol"></Div>
</Body>
</Html>
<jsp:forward page="../Misc/ezOutMsg.jsp"></jsp:forward>