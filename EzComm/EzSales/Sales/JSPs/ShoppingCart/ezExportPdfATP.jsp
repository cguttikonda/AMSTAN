<%@ page import="java.awt.image.BufferedImage,java.io.ByteArrayOutputStream,javax.imageio.ImageIO,java.io.*,ezc.ezparam.*,java.util.*,java.io.*"%>
<%@ page import="ezc.ezutil.*,java.util.*,java.text.*,java.io.*,com.lowagie.text.*" %>
<%@ page import="com.lowagie.text.pdf.PdfPTable,com.lowagie.text.pdf.PdfPCell,com.lowagie.text.pdf.PdfWriter,com.lowagie.text.Document,com.lowagie.text.Paragraph,com.lowagie.text.Image" %>


<%

	char[] chars = "abcdefghijklmnopqrstuvwxyz1234567890".toCharArray();
	StringBuffer  sb = new StringBuffer();
	Random random = new Random();
	for (int i = 0; i < 6; i++) {
	    char c = chars[random.nextInt(chars.length)];
	    sb.append(c);
	}
	String output = sb.toString();
	
	String filePath = "F:/usr/sap/NWD/JC00/j2ee/cluster/server0/apps/sap.com/EzcAST/servlet_jsp/AST/root/"+output+".pdf";
	File file = null;

	file = new File(filePath);
	//if(!file.exists()){
	file.createNewFile();
	//}
	
	ReturnObjFromRetrieve myRetATPSesGet = (ReturnObjFromRetrieve)session.getValue("myRetATPSes");
		
	String  fileName = output+".pdf";
	WritableWorkbook workbook = null;
	response.setContentType("application/pdf");
	response.setHeader("Content-Disposition", "attachment; filename="+fileName);
				
	/*Font titleFont = new Font(Font.TIMES_ROMAN, 17, Font.BOLD);
	Anchor anchor = new Anchor(auctionDesc+" ("+auctionId+")", titleFont);
	anchor.setName(auctionDesc+" ("+auctionId+")");

	Chapter chapter = new Chapter(new Paragraph(anchor), 1);
	chapter.setNumberDepth(0);
	document.add(chapter);*/
		
	Document document = new Document();
	try{
	
	
		PdfPTable table = new PdfPTable(10);
		table.setWidthPercentage(100);
		table.setSpacingBefore(10f);

		PdfPCell cell =null;

		cell = new PdfPCell();
		cell.setHorizontalAlignment(PdfPCell.ALIGN_CENTER);
		cell.setPhrase(new Phrase("Availability", FontFactory.getFont(FontFactory.HELVETICA, 12, Font.BOLD,java.awt.Color.BLACK)));	
		table.addCell(cell);
		
		cell = new PdfPCell();
		cell.setHorizontalAlignment(PdfPCell.ALIGN_CENTER);
		cell.setPhrase(new Phrase("Order Qty", FontFactory.getFont(FontFactory.HELVETICA, 12, Font.BOLD,java.awt.Color.BLACK)));	
		table.addCell(cell);
		
		cell = new PdfPCell();
		cell.setHorizontalAlignment(PdfPCell.ALIGN_CENTER);
		cell.setPhrase(new Phrase("Material", FontFactory.getFont(FontFactory.HELVETICA, 12, Font.BOLD,java.awt.Color.BLACK)));	
		table.addCell(cell);
		
		cell = new PdfPCell();
		cell.setHorizontalAlignment(PdfPCell.ALIGN_CENTER);
		cell.setPhrase(new Phrase("Material Desc", FontFactory.getFont(FontFactory.HELVETICA, 12, Font.BOLD,java.awt.Color.BLACK)));	
		table.addCell(cell);
		
		cell = new PdfPCell();
		cell.setHorizontalAlignment(PdfPCell.ALIGN_CENTER);
		cell.setPhrase(new Phrase("EAN/UPC", FontFactory.getFont(FontFactory.HELVETICA, 12, Font.BOLD,java.awt.Color.BLACK)));	
		table.addCell(cell);
		
		cell = new PdfPCell();
		cell.setHorizontalAlignment(PdfPCell.ALIGN_CENTER);
		cell.setPhrase(new Phrase("List Price", FontFactory.getFont(FontFactory.HELVETICA, 12, Font.BOLD,java.awt.Color.BLACK)));	
		table.addCell(cell);
		
		cell = new PdfPCell();
		cell.setHorizontalAlignment(PdfPCell.ALIGN_CENTER);
		cell.setPhrase(new Phrase("Luxury", FontFactory.getFont(FontFactory.HELVETICA, 12, Font.BOLD,java.awt.Color.BLACK)));	
		table.addCell(cell);
		
		cell = new PdfPCell();
		cell.setHorizontalAlignment(PdfPCell.ALIGN_CENTER);
		cell.setPhrase(new Phrase("Kit/Combo", FontFactory.getFont(FontFactory.HELVETICA, 12, Font.BOLD,java.awt.Color.BLACK)));	
		table.addCell(cell);
		
		cell = new PdfPCell();
		cell.setHorizontalAlignment(PdfPCell.ALIGN_CENTER);
		cell.setPhrase(new Phrase("Points", FontFactory.getFont(FontFactory.HELVETICA, 12, Font.BOLD,java.awt.Color.BLACK)));	
		table.addCell(cell);
		
		cell = new PdfPCell();
		cell.setHorizontalAlignment(PdfPCell.ALIGN_CENTER);
		cell.setPhrase(new Phrase("Product Status", FontFactory.getFont(FontFactory.HELVETICA, 12, Font.BOLD,java.awt.Color.BLACK)));	
		table.addCell(cell);
		
			
		//PdfWriter.getInstance(document,response.getOutputStream()); // Code 2
		PdfWriter.getInstance(document,file);
		document.open();

		// Code 3
		for(int i=0;i<myRetATPSesGet.getRowCount();i++)
		{

			cell = new PdfPCell();
			cell.setPhrase(new Phrase(myRetATPSesGet.getFieldValueString(i,"AVAILABILITY"), FontFactory.getFont(FontFactory.HELVETICA, 11, Font.BOLD,java.awt.Color.BLACK)));	
			table.addCell(cell);

			cell = new PdfPCell();
			cell.setPhrase(new Phrase(myRetATPSesGet.getFieldValueString(i,"ORDQTY"), FontFactory.getFont(FontFactory.HELVETICA, 11, Font.BOLD,java.awt.Color.BLACK)));	
			table.addCell(cell);

			cell = new PdfPCell();
			cell.setPhrase(new Phrase(myRetATPSesGet.getFieldValueString(i,"MATERIAL"), FontFactory.getFont(FontFactory.HELVETICA, 11, Font.BOLD,java.awt.Color.BLACK)));	
			table.addCell(cell);

			cell = new PdfPCell();
			cell.setPhrase(new Phrase(myRetATPSesGet.getFieldValueString(i,"MATERIALDESC"), FontFactory.getFont(FontFactory.HELVETICA, 11, Font.BOLD,java.awt.Color.BLACK)));	
			table.addCell(cell);

			cell = new PdfPCell();
			cell.setPhrase(new Phrase(myRetATPSesGet.getFieldValueString(i,"EANUPC"), FontFactory.getFont(FontFactory.HELVETICA, 11, Font.BOLD,java.awt.Color.BLACK)));	
			table.addCell(cell);

			cell = new PdfPCell();
			cell.setPhrase(new Phrase(myRetATPSesGet.getFieldValueString(i,"LIST_PRICE"), FontFactory.getFont(FontFactory.HELVETICA, 11, Font.BOLD,java.awt.Color.BLACK)));	
			table.addCell(cell);

			cell = new PdfPCell();
			cell.setPhrase(new Phrase(myRetATPSesGet.getFieldValueString(i,"LUXURY"), FontFactory.getFont(FontFactory.HELVETICA, 11, Font.BOLD,java.awt.Color.BLACK)));	
			table.addCell(cell);

			cell = new PdfPCell();
			cell.setPhrase(new Phrase(myRetATPSesGet.getFieldValueString(i,"KITCOMBO"), FontFactory.getFont(FontFactory.HELVETICA, 11, Font.BOLD,java.awt.Color.BLACK)));	
			table.addCell(cell);

			cell = new PdfPCell();
			cell.setPhrase(new Phrase(myRetATPSesGet.getFieldValueString(i,"POINTS"), FontFactory.getFont(FontFactory.HELVETICA, 11, Font.BOLD,java.awt.Color.BLACK)));	
			table.addCell(cell);

			cell = new PdfPCell();
			cell.setPhrase(new Phrase(myRetATPSesGet.getFieldValueString(i,"PRODUCT_STATUS"), FontFactory.getFont(FontFactory.HELVETICA, 11, Font.BOLD,java.awt.Color.BLACK)));	
			table.addCell(cell);

			table.completeRow(); 
		
		}
			

		// Code 4
		document.add(table);		
		document.close(); 
	}catch(DocumentException e){
		e.printStackTrace();
	}

response.sendRedirect("http://docs.google.com/viewer?url=http%3A%2F%2Fanswerthink.americanstandard.com%2FAST%2F"+output+".pdf");
%>			