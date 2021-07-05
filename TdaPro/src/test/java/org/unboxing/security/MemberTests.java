package org.unboxing.security;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml","file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class MemberTests {

	@Setter(onMethod_=@Autowired)
	private PasswordEncoder pwencoder;
	
	@Setter(onMethod_=@Autowired)
	private DataSource ds;
	
	//아이디 만들어보고 패스워드가 잘 암호화된지 확인
	//test 용 admin , manager , user 계정만들기
	@Test
	public void test() {
		String sql = "insert into member(userid,userpw,username) values(?,?,?)";
		
		for(int i=1;i<=10;i++) {
			
		
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "manager"+i);
			pstmt.setString(2, pwencoder.encode("pw"+i));
			pstmt.setString(3, "운영자"+i);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) {
				if(pstmt!=null){try {pstmt.close();}catch(Exception e) {}}
				if(con!=null){try {pstmt.close();}catch(Exception e) {}}
			}
		}
		
		}
	
	}
	
	//생성된 사용자에 대한 권한추가
	@Test
	public void testAuth() {
		String sql = "insert into member_auth(userid,auth) values (?,?)";
		
		for(int i=1;i<=10;i++) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "user"+i);
			pstmt.setString(2, "ROLE_USER");
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) {
				if(pstmt!=null){try {pstmt.close();}catch(Exception e) {}}
				if(con!=null){try {pstmt.close();}catch(Exception e) {}}
			}
		}
	}
	}
}
