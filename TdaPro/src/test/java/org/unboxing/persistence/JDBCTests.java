package org.unboxing.persistence;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

import lombok.extern.log4j.Log4j;

@Log4j
public class JDBCTests {
		
		static {
			 try {
				 Class.forName("oracle.jdbc.driver.OracleDriver");
			 }catch(Exception e) {
				 e.printStackTrace();
			 }
			}
			
			//jdbc 연결테스트
			@Test
			public void testConnection() {
			
				try (Connection con =
						DriverManager.getConnection(
								"jdbc:oracle:thin:@localhost:1521:XE",
								"unboxing", /*아이디*/
								"0913" /*비밀번호*/ )){
					
					log.info(con);
				}catch(Exception e) {
					fail(e.getMessage());
				}
			}
	}