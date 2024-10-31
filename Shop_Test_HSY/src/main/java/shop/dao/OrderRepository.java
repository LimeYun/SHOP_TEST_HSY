package shop.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import shop.dto.Order;
import shop.dto.Product;

public class OrderRepository extends JDBConnection {
	
	/**
	 * 주문 등록
	 * @param user
	 * @return
	 */
	public int insert(Order order) {
		int result = 0;
		
//		`order_no` int NOT NULL AUTO_INCREMENT COMMENT '주문번호',
//		  `ship_name` varchar(100) NOT NULL COMMENT '받는사람이름',
//		  `zip_code` varchar(100) NOT NULL COMMENT '우편번호',
//		  `country` varchar(100) NOT NULL COMMENT '국가',
//		  `address` varchar(200) NOT NULL COMMENT '주소',
//		  `date` varchar(200) NOT NULL COMMENT '배송일자',
//		  `order_pw` varchar(200) NULL COMMENT '주문 비밀번호',
//		  `user_id` varchar(10) DEFAULT NULL COMMENT '회원아이디',
//		  `total_price` int DEFAULT '0' COMMENT '총가격',
//		  `phone` varchar(20) DEFAULT NULL COMMENT '비회원 전화번호',
//		  PRIMARY KEY (`order_no`)
//		) COMMENT='주문';
		String sql = " INSERT INTO order(order_no, ship_name, zip_code,"
				   + " country, address, date, order_pw, user_id, total_price, phone)"
				   + " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setInt(1, order.getOrderNo());
			psmt.setString(2, order.getShipName());
			psmt.setString(3, order.getZipCode());
			psmt.setString(4, order.getCountry());
			psmt.setString(5, order.getAddress());
			psmt.setString(6, order.getDate());
			psmt.setString(7, order.getOrderPw());
			psmt.setString(8, order.getUserId());
			psmt.setInt(9, order.getTotalPrice());
			psmt.setString(10, order.getPhone());
			result = psmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println("주문등록 예외 발생");
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 최근 등록한 orderNo 
	 * @return
	 */
	public int lastOrderNo() {
		int result = 0;
		
		String sql = " SELECT max(order_no) last_order_no "
				   + "FROM order ";
		
		try {
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt("last_order_no");
			}
		} catch (SQLException e) {
			System.err.println("라스트 오더 넘버 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}

	
	/**
	 * 주문 내역 조회 - 회원
	 * @param userId
	 * @return
	 */
	public List<Product> list(String userId) {
		List<Product> orderList = new ArrayList<>();
		
		String sql = " SELECT o.order_no "
				+ ",p.name "
		  		+ ",p.unit_price "
		  		+ ",io.amount "
		  		+ "FROM `order` o JOIN product_io io ON o.order_no = io.order_no"
		  		+ "JOIN product p ON io.product_id = p.product_id"
		  		+ "WHERE o.user_id = 'joeun'";
		 
		Product product = null;
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, userId);
			rs = psmt.executeQuery();
			while (rs.next()) {
				product = new Product();
				product.setOrderNo(rs.getInt("order_no"));
				product.setName(rs.getString("name"));
				product.setUnitPrice(rs.getInt("unit_price"));
				product.setAmount(rs.getInt("amount"));
				orderList.add(product);
			}
		} catch (SQLException e) {
			System.err.println("회원주문내역 조회 예외 발생");
			e.printStackTrace();
		}
		
		return orderList;

	}
	
	/**
	 * 주문 내역 조회 - 비회원
	 * @param phone
	 * @param orderPw
	 * @return
	 */
	public List<Product> list(String phone, String orderPw) {
		List<Product> productList = new ArrayList<>();
		
		String sql = " SELECT o.order_no "
					+ ",p.name "
			  		+ ",p.unit_price "
			  		+ ",io.amount "
			  		+ "FROM `order` o JOIN product_io io ON o.order_no = io.order_no"
			  		+ "JOIN product p ON io.product_id = p.product_id"
			  		+ "WHERE o.phone = ? AND o.order_pw = ? ";
		 
		Product product = null;
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, phone);
			psmt.setString(2, orderPw);
			rs = psmt.executeQuery();
			while (rs.next()) {
				product = new Product();
				product.setOrderNo(rs.getInt("order_no"));
				product.setName(rs.getString("name"));
				product.setUnitPrice(rs.getInt("unit_price"));
				product.setAmount(rs.getInt("amount"));
			}
		} catch (SQLException e) {
			System.err.println("비회원주문내역 조회 예외 발생");
			e.printStackTrace();
		}
		
		return productList;
		
		
	}
	
}






























