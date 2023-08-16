package model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

public class CouDAO {
	
	public void update(GradeVO vo) {
		try {
			String sql="update enrollments set grade=? where scode=? and lcode=?";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setInt(1, vo.getGrade());
			ps.setString(2, vo.getScode());
			ps.setString(3, vo.getLcode());
			ps.execute();
		}catch(Exception e) {
			System.out.println("점수수정:" + e.toString());
		}
	}
	
	
	public void update(CouVO vo) {
		try {
			String sql="update courses set lname=?, room=?, hours=?, capacity=?, persons=?, instructor=? where lcode=?";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getLname());
			ps.setString(2, vo.getRoom());
			ps.setInt(3, vo.getHours());
			ps.setInt(4, vo.getCapacity());
			ps.setInt(5, vo.getPersons());
			ps.setString(6, vo.getInstructor());
			ps.setString(7, vo.getLcode());
			ps.execute();
		}catch(Exception e) {
			System.out.println("강좌수정:" + e.toString());
		}
	}
	
	public CouVO read(String lcode){
		CouVO vo = new CouVO();
		try {
			String sql="select * from view_cou where lcode= ?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, lcode);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				vo.setLcode(rs.getString("lcode"));
				vo.setLname(rs.getString("lname"));
				vo.setPname(rs.getString("pname"));
				vo.setRoom(rs.getString("room"));
				vo.setInstructor(rs.getString("instructor"));
				vo.setHours(rs.getInt("hours"));
				vo.setPersons(rs.getInt("persons"));
				vo.setCapacity(rs.getInt("capacity"));
			}
		}catch(Exception e) {
			System.out.println("강좌읽기" + e.toString());
		}
		return vo;
	}
	
	public String getCode(){
		String code="";
		try {
			String ncode="";
			String sql="select max(lcode) ncode from courses";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				ncode= rs.getString("ncode");
				code= "N" + (Integer.parseInt(ncode.substring(1))+1);
			}
		}catch(Exception e) {
			System.out.println("강좌번호" + e.toString());
		}
		return code;
	}
	
	public int total(String key, String query){
		int total=0;
		try {
			String sql="select count(*) cnt from view_cou where " + key + " like ? ";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%"+query+"%");
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				total = rs.getInt("cnt");
			}
		}catch(Exception e) {
			System.out.println("강좌총합" + e.toString());
		}
		return total;
	}
	
	public void insert(CouVO vo) {
		try {
			String code=getCode();
			String sql="insert into courses(lcode,lname,room,hours,capacity,persons,instructor) values(?,?,?,?,?,?,?)";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, code);
			ps.setString(2, vo.getLname());
			ps.setString(3, vo.getRoom());
			ps.setInt(4, vo.getHours());
			ps.setInt(5, vo.getCapacity());
			ps.setInt(6, vo.getPersons());
			ps.setString(7, vo.getInstructor());
			ps.execute();
		}catch(Exception e) {
			System.out.println("강좌등록:" + e.toString());
		}
	}
	
	public List<CouVO> all(){
		List<CouVO> array = new ArrayList<CouVO>();
		try {
			String sql="select * from view_cou order by lname";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				CouVO vo = new CouVO();
				vo.setLcode(rs.getString("lcode"));
				vo.setLname(rs.getString("lname"));
				vo.setPname(rs.getString("pname"));
				vo.setRoom(rs.getString("room"));
				vo.setInstructor(rs.getString("instructor"));
				vo.setHours(rs.getInt("hours"));
				vo.setPersons(rs.getInt("persons"));
				vo.setCapacity(rs.getInt("capacity"));
				array.add(vo);
			}
		}catch(Exception e) {
			System.out.println("강좌전체목록" + e.toString());
		}
		return array;
	}
	
	public List<CouVO> list(int page, String key, String query){
		List<CouVO> array = new ArrayList<CouVO>();
		try {
			String sql="select * from view_cou "
					+ "where " + key + " like ? "
					+ "limit ?,5";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%"+query+"%");
			ps.setInt(2, (page-1)*5);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				CouVO vo = new CouVO();
				vo.setLcode(rs.getString("lcode"));
				vo.setLname(rs.getString("lname"));
				vo.setPname(rs.getString("pname"));
				vo.setRoom(rs.getString("room"));
				vo.setInstructor(rs.getString("instructor"));
				vo.setHours(rs.getInt("hours"));
				vo.setPersons(rs.getInt("persons"));
				vo.setCapacity(rs.getInt("capacity"));
				array.add(vo);
			}
		}catch(Exception e) {
			System.out.println("강좌목록" + e.toString());
		}
		return array;
	}
}
