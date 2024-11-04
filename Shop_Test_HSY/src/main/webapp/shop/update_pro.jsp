<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.DiskFileUpload"%>
<%@page import="shop.dao.ProductRepository"%>
<%@page import="shop.dto.Product"%>
<%@page import="javax.servlet.ServletException"%>
<%@page import="java.io.IOException"%>
<%@page import="java.util.UUID"%>
<%@page import="java.io.File"%>
<%@page import="javax.servlet.annotation.MultipartConfig"%>
<%@page import="javax.servlet.http.Part"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page language="java" %>
<%
    String root = request.getContextPath();
    String path = "C:\\UPLOAD"; // 업로드 경로를 초기화합니다.

    // 상품 수정 처리
    ProductRepository productRepository = new ProductRepository();
    Product product = new Product();

    String productId = "";
    String name = "";
    int unitPrice = 0;
    String description = "";
    String manufacturer = "";
    String category = "";
    int unitsInStock = 0;
    String condition = "";
    String fileUrl = "";

    DiskFileUpload upload = new DiskFileUpload();
    upload.setRepositoryPath(path);    
    // 파일 업로드 처리
    List<FileItem> items = upload.parseRequest(request);
    Iterator params = items.iterator();
    while(params.hasNext()) {
        FileItem item = (FileItem) params.next();
        // 일반 데이터
        if(item.isFormField()) {
            String fieldName = item.getFieldName();
            String value = item.getString("utf-8");
            switch(fieldName) {
                case "productId":
                    productId = value;
                    break;
                case "name":
                    name = value;
                    break;
                case "unitPrice":
                    unitPrice = Integer.parseInt(value);
                    break;
                case "description":
                    description = value;
                    break;
                case "manufacturer":
                    manufacturer = value;
                    break;
                case "category":
                    category = value;
                    break;
                case "unitsInStock":
                    unitsInStock = Integer.parseInt(value);
                    break;
                case "condition":
                    condition = value;
                    break;
            }
        } 
        // 파일 데이터
        else {
            if(item.getName().length() > 0) {
                String fileFieldName = item.getFieldName();
                String fileName = item.getName();
                String contentType = item.getContentType();
                
                fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
                long fileSize = item.getSize();
                
                File file = new File(path + "\\" + fileName); // 경로 구분자를 \로 수정
                item.write(file);
            }
        }
    }

    product = productRepository.getProductById(productId);
    

    product.setProductId(productId);
    product.setName(name);
    product.setUnitPrice(unitPrice);
    product.setDescription(description);
    product.setManufacturer(manufacturer);
    product.setCategory(category);
    product.setUnitsInStock(unitsInStock);
    product.setCondition(condition);

    int result = productRepository.update(product);
    
    response.sendRedirect(root + "/shop/products.jsp");
%>
