<%@ page import="jxl.Sheet,jxl.Workbook,jxl.read.biff.BiffException,jxl.write.*,jxl.format.*"%>
<%@ page import="java.awt.image.BufferedImage,java.io.ByteArrayOutputStream,javax.imageio.ImageIO,java.io.*,ezc.ezparam.*,java.util.*,java.io.*"%>

<%
	String fileName = "ExcelATP123.xls";
	WritableWorkbook workbook = null;
	response.setContentType("application/vnd.ms-excel");
	response.setHeader("Content-Disposition", "attachment; filename="+fileName);	
	
	ReturnObjFromRetrieve myRetATPSesGet = (ReturnObjFromRetrieve)session.getValue("myRetATPSes");
	
	char[] chars = "abcdefghijklmnopqrstuvwxyz1234567890".toCharArray();
	StringBuffer  sb = new StringBuffer();
	Random random = new Random();
	for (int i = 0; i < 6; i++) {
	    char c = chars[random.nextInt(chars.length)];
	    sb.append(c);
	}
	String output = sb.toString();
	
	String filePath = "F:/usr/sap/NWD/JC00/j2ee/cluster/server0/apps/sap.com/EzcAST/servlet_jsp/AST/root/"+output+".xls";
	File file = null;
		
	file = new File(filePath);
	//if(!file.exists()){
	file.createNewFile();
	//}
	

	try
	{
		int row=0;

		workbook = Workbook.createWorkbook(file);
		WritableSheet ws = workbook.createSheet("Sheet0", 0);
		
		WritableFont custHeadFont = new WritableFont(jxl.write.WritableFont.TIMES, 11 , jxl.write.WritableFont.BOLD);
		WritableCellFormat custHeadCellFormat = new WritableCellFormat(custHeadFont);
		
		//custHeadCellFormat.setBackground(jxl.format.Colour.WHITE);
		//custHeadCellFormat.setShrinkToFit(false);
		custHeadCellFormat.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);
		//custHeadCellFormat.setWrap(false);
		//custHeadCellFormat.setAlignment(jxl.format.Alignment.FILL);
		//custHeadCellFormat.setIndentation(10);
		//custHeadCellFormat.setOrientation(jxl.format.Orientation.HORIZONTAL);
		//custHeadCellFormat.setVerticalAlignment(jxl.format.VerticalAlignment.TOP);
				
		ws.setColumnView(0,40);
		ws.setColumnView(1,10);
		ws.setColumnView(2,20);
		ws.setColumnView(3,45);
		ws.setColumnView(4,12);
		ws.setColumnView(9,17);
		
		
		ws.addCell(new Label(0, row, "Availability", custHeadCellFormat));
		ws.addCell(new Label(1, row, "Order Qty", custHeadCellFormat));
		ws.addCell(new Label(2, row, "Material", custHeadCellFormat));
		ws.addCell(new Label(3, row, "Material Desc", custHeadCellFormat));		
		ws.addCell(new Label(4, row, "EAN/UPC", custHeadCellFormat));
		ws.addCell(new Label(5, row, "List Price", custHeadCellFormat));
		ws.addCell(new Label(6, row, "Luxury", custHeadCellFormat));
		ws.addCell(new Label(7, row, "Kit/Combo", custHeadCellFormat));
		ws.addCell(new Label(8, row, "Points", custHeadCellFormat));
		ws.addCell(new Label(9, row, "Product Status", custHeadCellFormat));

		WritableFont custDetFont = new WritableFont(jxl.write.WritableFont.TIMES, 10);
		WritableCellFormat custDetCellFormat = new WritableCellFormat(custDetFont);
		//custDetCellFormat.setBackground(jxl.format.Colour.WHITE);
		//custDetCellFormat.setShrinkToFit(false);
		custDetCellFormat.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);
		//custDetCellFormat.setWrap(true);
		//custDetCellFormat.setAlignment(jxl.format.Alignment.FILL);
		//custDetCellFormat.setOrientation(jxl.format.Orientation.HORIZONTAL);
		//custDetCellFormat.setVerticalAlignment(jxl.format.VerticalAlignment.TOP);
		
		
		
		for(int i=0;i<myRetATPSesGet.getRowCount();i++)
		{
		
					
			ws.addCell(new Label(0, row+1, myRetATPSesGet.getFieldValueString(i,"AVAILABILITY"), custDetCellFormat));
			ws.addCell(new Label(1, row+1, myRetATPSesGet.getFieldValueString(i,"ORDQTY"), custDetCellFormat));
			ws.addCell(new Label(2, row+1, myRetATPSesGet.getFieldValueString(i,"MATERIAL"), custDetCellFormat));
			ws.addCell(new Label(3, row+1, myRetATPSesGet.getFieldValueString(i,"MATERIALDESC"), custDetCellFormat));
			
			ws.addCell(new Label(4, row+1, myRetATPSesGet.getFieldValueString(i,"EANUPC"), custDetCellFormat));
			ws.addCell(new Label(5, row+1, myRetATPSesGet.getFieldValueString(i,"LIST_PRICE"), custDetCellFormat));
			ws.addCell(new Label(6, row+1, myRetATPSesGet.getFieldValueString(i,"LUXURY"), custDetCellFormat));
			ws.addCell(new Label(7, row+1, myRetATPSesGet.getFieldValueString(i,"KITCOMBO"), custDetCellFormat));
			ws.addCell(new Label(8, row+1, myRetATPSesGet.getFieldValueString(i,"POINTS"), custDetCellFormat));
			ws.addCell(new Label(9, row+1, myRetATPSesGet.getFieldValueString(i,"PRODUCT_STATUS"), custDetCellFormat));
					

			row++;
		}
	}
	catch(Exception e)
	{
		System.out.println("Exception in result set"+e);
	}
	finally
	{
		try{
			workbook.write();
			workbook.close();
		}catch(Exception ex){}
	}

%>


<%
response.sendRedirect("http://docs.google.com/viewer?url=http%3A%2F%2Fanswerthink.americanstandard.com%2FAST%2F"+output+".xls");
%>