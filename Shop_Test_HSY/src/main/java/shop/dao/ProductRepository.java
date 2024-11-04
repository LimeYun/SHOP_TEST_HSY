package shop.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import shop.dto.Product;

public class ProductRepository extends JDBConnection {
	
	/**
	 * 상품 목록
	 * @return
	 */
	public List<Product> list() {
		List<Product> productList = new ArrayList<>();
		
		String sql = " SELECT * "
				   + " FROM product ";
		
		Product product = null;
		try {
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			while (rs.next()) {
				product = new Product();
				product.setProductId(rs.getString("product_id"));
				product.setName(rs.getString("name"));
				product.setUnitPrice(rs.getInt("unit_price"));
				product.setDescription(rs.getString("description"));
				product.setManufacturer(rs.getString("manufacturer"));
				product.setCategory(rs.getString("category"));
				product.setUnitsInStock(rs.getLong("units_in_stock"));
				product.setCondition(rs.getString("condition"));
				product.setFile(rs.getString("file"));
				productList.add(product);
			}
		} catch (SQLException e) {
			System.err.println("상품 리스트 조회 예외 발생");
			e.printStackTrace();
		}
		
		
		return productList;
		
	}
	
	
	/**
	 * 상품 목록 검색
	 * @param keyword
	 * @return
	 */
	public List<Product> list(String keyword) {
		List<Product> productList = new ArrayList<>();
		
		// name, description, manufacturer, category 
		String sql = " SELECT * "
				   + " FROM product "
				   + " WHERE name like concat('%', ?, '%')"
				   + " OR description like concat('%', ?, '%')"
				   + " OR manufacturer like concat('%', ?, '%')"
				   + " OR category like concat('%', ?, '%')";
		
		Product product = null;
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, keyword);
			psmt.setString(2, keyword);
			psmt.setString(3, keyword);
			psmt.setString(4, keyword);
			rs = psmt.executeQuery();
			while (rs.next()) {
				product = new Product();
				product.setProductId(rs.getString("product_id"));
				product.setName(rs.getString("name"));
				product.setUnitPrice(rs.getInt("unit_price"));
				product.setDescription(rs.getString("description"));
				product.setManufacturer(rs.getString("manufacturer"));
				product.setCategory(rs.getString("category"));
				product.setUnitsInStock(rs.getLong("units_in_stock"));
				product.setCondition(rs.getString("condition"));
				product.setFile(rs.getString("file"));
				productList.add(product);
			}
		} catch (SQLException e) {
			System.err.println("상품 검색 예외 발생");
			e.printStackTrace();
		}
		return productList;
	}
	
	/**
	 * 상품 조회
	 * @param productId
	 * @return
	 */
	public Product getProductById(String productId) {
		String sql = " SELECT * "
				   + " FROM product "
				   + " WHERE product_id = ? ";
		
		Product product = null;
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, productId);
			rs = psmt.executeQuery();
			if (rs.next()) {
				product = new Product();
				product.setProductId(rs.getString("product_id"));
				product.setName(rs.getString("name"));
				product.setUnitPrice(rs.getInt("unit_price"));
				product.setDescription(rs.getString("description"));
				product.setManufacturer(rs.getString("manufacturer"));
				product.setCategory(rs.getString("category"));
				product.setUnitsInStock(rs.getLong("units_in_stock"));
				product.setCondition(rs.getString("condition"));
				product.setFile(rs.getString("file"));
			}
		} catch (SQLException e) {
			System.err.println("상품 조회 에러 발생");
			e.printStackTrace();
		}
		return product;
	}
	
	/**
	 * 상품 등록
	 * @param product
	 * @return
	 */
	public int insert(Product product) {
		int result = 0;
		
		String sql = " INSERT INTO product(product_id, name, unit_price, "
				   + "description, manufacturer, category, units_in_stock,"
				   + " condition, file)"
				   + " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?) ";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, product.getProductId());
			psmt.setString(2, product.getName());
			psmt.setInt(3, product.getUnitPrice());
			psmt.setString(4, product.getDescription());
			psmt.setString(5, product.getManufacturer());
			psmt.setString(6, product.getCategory());
			psmt.setLong(7, product.getUnitsInStock());
			psmt.setString(8, product.getCondition());
			psmt.setString(9, product.getFile());
			result = psmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println("상품 등록 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
		
	/**
	 * 상품 수정
	 * @param product
	 * @return
	 */
	public int update(Product product) {
		int result = 0;
		
		String sql = " UPDATE product "
				   + "	  SET product_id = ? "
				   + " 		 ,name = ? "
				   + "       ,unit_price = ? "
				   + "       ,description = ? "
				   + "       ,manufacturer = ? "
				   + "       ,category = ? "
				   + "       ,units_in_stock = ? "
				   + "       ,condition = ? "
				   + "       ,file = ? "
				   + " WHERE product_id = ? ";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, product.getProductId());
			psmt.setString(2, product.getName());
			psmt.setInt(3, product.getUnitPrice());
			psmt.setString(4, product.getDescription());
			psmt.setString(5, product.getManufacturer());
			psmt.setString(6, product.getCategory());
			psmt.setLong(7, product.getUnitsInStock());
			psmt.setString(8, product.getCondition());
			psmt.setString(9, product.getFile());
			result = psmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println("상품 수정 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	
	
	/**
	 * 상품 삭제
	 * @param product
	 * @return
	 */
	public int delete(String productId) {
		int result = 0;
		
		String sql = " DELETE FROM product "
				   + " WHERE product_id = ? ";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, productId);
			result = psmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println("상품 삭제 예외 발생");
			e.printStackTrace();
		}
		return result;
		
	}

}








