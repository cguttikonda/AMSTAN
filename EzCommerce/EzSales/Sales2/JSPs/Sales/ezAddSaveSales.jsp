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

	log4j.log("in AddSave in AddSave in AddSave in AddSave in AddSave in AddSave1","W");

	String product,productDesc,name,desiredQty,desiredDate,desiredPrice,value_Net,plant,Currency,custProd,itemPrice;
	ReturnObjFromRetrieve itemoutTable 	= null;
	Hashtable getBonus = new Hashtable();
	String UserType = (String)session.getValue("UserType");
	UserType=UserType.trim();
	String UserRole = (String)session.getValue("UserRole");
	UserRole=UserRole.trim();
	String agent = (String)session.getValue("Agent");   
	agent = agent.trim();
	String salesAreaCode = (String)session.getValue("SalesAreaCode");
	String salesAreaName = (String)session.getValue("Country");
	salesAreaCode = salesAreaCode.trim();
	String status = setSalVal.getStatus();
	boolean NEW 		= false;	if(("New").equalsIgnoreCase(status)) NEW = true;
	boolean TRANSFERED 	= false;	if(("Transfered").equalsIgnoreCase(status))TRANSFERED= true;
	boolean NEGOTIATED 	= false;	if(("Negotiated").equalsIgnoreCase(status))NEGOTIATED= true;
	
	String paymentterms = setSalVal.getPaymentTerms();
	log4j.log("in AddSave in AddSave in AddSave in AddSave in AddSave in AddSave2"+status,"W");       

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
	log4j.log("in AddSave in AddSave in AddSave in AddSave in AddSave in AddSave3","W");
	String msg  = null;
	String user = Session.getUserId();
	user=user.trim(); 
	log4j.log("in AddSave in AddSave in AddSave in AddSave in AddSave in AddSave4","W");
	String[] prodCode_1 	= request.getParameterValues("product");	//setSalVal.getProduct();
	String[] prodDesc_1 	= request.getParameterValues("prodDesc");	//setSalVal.getProdDesc();
	String[] prodDQty_1 	= request.getParameterValues("desiredQty");	//setSalVal.getDesiredQty();
	String[] prodCQty_1 	= request.getParameterValues("commitedQty");	//setSalVal.getCommitedQty();
	String[] prodPack_1 	= request.getParameterValues("pack");		//setSalVal.getPack();
	String[] prodItemCat_1 	= request.getParameterValues("ItemCat");
	String[] prodUomQty	= request.getParameterValues("UomQty");
	String[] custprodCode	= request.getParameterValues("custprodCode");
	String[] itemVenCatalog	= request.getParameterValues("itemVenCatalog");
	String[] itemOrderType	= request.getParameterValues("orderType"); 
	String[] itemPlant	= request.getParameterValues("plant");
	
	String[] itemMfrPart	= request.getParameterValues("itemMfrPart"); 
	String[] itemMfrNr	= request.getParameterValues("itemMfrNr"); 
	String[] itemEanUPC	= request.getParameterValues("itemEanUPC"); 
	String[] itemMatId	= request.getParameterValues("itemMatId");
	String[] itemMmFlag	= request.getParameterValues("itemMmFlag");
	String[] itemDiscCode	= request.getParameterValues("itemDiscCode");
	String[] itemPromoCode  = request.getParameterValues("itemPromoCode");
	String[] itemWeight	= request.getParameterValues("itemWeight");
	String[] itemCnetProd	= request.getParameterValues("itemCnetProd");
	String[] itemMfrCode	= request.getParameterValues("itemMfrCode");
	String[] itemOrgPrice	= request.getParameterValues("itemOrgPrice");
	
	
	String promoCode 	= request.getParameter("hidePromoCode");
	String freightPrice 	= request.getParameter("freightVal"); 
	String freightWeight 	= request.getParameter("weight");
	String fServType 	= request.getParameter("fServType");
	String freightIns	= request.getParameter("freightIns");
	
	String shTpZone		= request.getParameter("tpZone");  
	String shJurCode	= request.getParameter("jurisdiction"); 
	String shFax		= request.getParameter("faxNumber");
	String shTel		= request.getParameter("telNumber");
	String shMobi		= request.getParameter("mobileNumber"); 
	String shAttn		= request.getParameter("shAttn"); 
	String billTPZone	= request.getParameter("billTPZone");  
	String billJurCode	= request.getParameter("billJurCode");  
	String specialShIns	= request.getParameter("specialShIns"); 
	String saveEmail	= request.getParameter("saveEmail");
	
	
	String grandTotalVal	= request.getParameter("grandTotalVal");      
	
	
	 
	
	
	int prodCodeLength =prodCode_1.length;   
	log4j.log("in AddSave in AddSave in AddSave in AddSave in AddSave in AddSave52"+prodCodeLength,"W");

	String[] desiredDate_1 = request.getParameterValues("desiredDate"); 	//setSalVal.getDesiredDate();
	String[] lineValue_1   = request.getParameterValues("lineValue");	//setSalVal.getLineValue();
	//String[] desiredPrice_1= request.getParameterValues("desiredPrice");	//setSalVal.getDesiredPrice();
	String[] desiredPrice_1= request.getParameterValues("finalPrice");
	String[] itemListPrice = request.getParameterValues("itemListPrice");	//setSalVal.getDesiredPrice();
	String[] finalPriceVal_1= request.getParameterValues("finalPriceVal");
	
	log4j.log("in AddSave in AddSave in AddSave in AddSave in AddSave in AddSave5"+prodCodeLength,"W");
	String[] del_sch_qty_1 = setSalVal.getDel_sch_qty();
	String[] del_sch_date_1= setSalVal.getDel_sch_date();  
	String incoTerms1      = setSalVal.getIncoTerms1();   
	String incoTerms2      = setSalVal.getIncoTerms2();
	log4j.log("in AddSave in AddSave in AddSave in AddSave in AddSave in AddSave53"+prodCodeLength,"W");
	
	incoTerms1=(incoTerms1==null)?" ":incoTerms1;
	incoTerms2=(incoTerms2==null)?" ":EzReplace.setReplace(incoTerms2);
	log4j.log("in AddSave in AddSave in AddSave in AddSave in AddSave in AddSave6","W");
	
	String carrierName    		= "02";		// hardcoded value will be sent if shiptype is null

	/*String[] shippingTypeDesc	= new String[2];
	String shippingType 		= request.getParameter("shippingType");
	
	if(shippingType==null || "null".equals(shippingType) || "".equals(shippingType))
	{
		shippingTypeDesc[0]="02";
		shippingTypeDesc[1]="Mail";
	}
	else
	{
		shippingTypeDesc = shippingType.split("#");
	}*/
	
	//carrierName = shippingTypeDesc[0];
	if("SP".equals(fServType))carrierName=" ";

	log4j.log("in AddSave in AddSave in AddSave in AddSave in AddSave in AddSave--carrierName:-->"+carrierName,"W");
	
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
	log4j.log("in AddSave in AddSave in AddSave in AddSave in AddSave in AddSave7","W");

	generalNotes 		= ((generalNotes==null)||(generalNotes.trim().length()==0))?"None":EzReplace.setReplace(generalNotes);
	packingInstructions 	= ((packingInstructions==null)||(packingInstructions.trim().length()==0))?"None":EzReplace.setReplace(packingInstructions);
	labelInstructions 	= ((labelInstructions==null)||(labelInstructions.trim().length()==0))?"None":EzReplace.setReplace(labelInstructions);
	inspectionClauses 	= ((inspectionClauses==null)||(inspectionClauses.trim().length()==0))?"None":EzReplace.setReplace(inspectionClauses);
	handlingSpecifications 	= ((handlingSpecifications==null)||(handlingSpecifications.trim().length()==0))?"None":EzReplace.setReplace(handlingSpecifications);
	regulatoryRequirments 	= ((regulatoryRequirments==null)||(regulatoryRequirments.trim().length()==0))?"None":EzReplace.setReplace(regulatoryRequirments);
	documentsRequired 	= ((documentsRequired==null)||(documentsRequired.trim().length()==0))?"None":EzReplace.setReplace(documentsRequired);
	others 			= ((others==null)||(others.trim().length()==0))?"None":EzReplace.setReplace(others);
	generalNotes1 		= ((generalNotes1==null)||(generalNotes1.trim().length()==0))?"":EzReplace.setReplace(generalNotes1);
	generalNotes2 		= ((generalNotes2==null)||(generalNotes2.trim().length()==0))?"None":EzReplace.setReplace(generalNotes2);
	generalNotes3 		= ((generalNotes3==null)||(generalNotes3.trim().length()==0))?"None":EzReplace.setReplace(generalNotes3);
	generalNotesAll		="GeneralNotes@@ezc@@"+generalNotes.trim()+"^^ezc^^PackingInstructions@@ezc@@"+packingInstructions.trim()+"^^ezc^^LabelInstructions@@ezc@@"+labelInstructions.trim()+"^^ezc^^InspectionClauses@@ezc@@"+inspectionClauses.trim()+"^^ezc^^HandlingSpecifications@@ezc@@"+handlingSpecifications.trim()+"^^ezc^^Requlatoryrequirments@@ezc@@"+regulatoryRequirments.trim()+"^^ezc^^DocumentsRequired@@ezc@@"+documentsRequired.trim()+"^^ezc^^Others@@ezc@@"+others.trim();
	specialShIns 		= ((specialShIns==null)||(specialShIns.trim().length()==0))?"None":EzReplace.setReplace(specialShIns);
	generalNotes2           = specialShIns;
	
	if(shAttn==null || "null".equals(shAttn) || "".equals(shAttn)) shAttn = "N/A";
	if(shTel==null || "null".equals(shTel) || "".equals(shTel)) shTel = "N/A";
	if(shMobi==null || "null".equals(shMobi) || "".equals(shMobi)) shMobi = "N/A";   
	if(shFax==null || "null".equals(shFax) || "".equals(shFax)) shFax = "N/A"; 

	generalNotesAll		= shAttn+"¥"+shTel+"¥"+shMobi+"¥"+shFax;
	 
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
	log4j.log("in AddSave in AddSave in AddSave in AddSave in AddSave in AddSave4","W"); 
%> 

<Html>
<Body>
<Form target=main>   
<%
	try
	{
%>
		<%@ include file="../../../Includes/JSPs/Sales/iAddSaveSales.jsp"%>
<%
		//** file attachment **//

		String attachString = request.getParameter("attachString");

		if(attachString != null)
		{
			if(!"".equals(attachString))
			{
				String objNo 		= weborno;
				String documentType 	= "SO";
%>
				<%@ include file="../UploadFiles/ezSaveAttachFiles.jsp" %>
<%
			}
		}

		//** file attachment **//
	}
	catch(Exception e)
	{
		System.out.println("Error in iAddSaveSales.jsp");  
	}
%>
</Form>
<Div id="MenuSol"></Div>
</Body>
</Html> 
<jsp:forward page="../Misc/ezOutMsg.jsp"></jsp:forward>