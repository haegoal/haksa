package model;

import java.util.ArrayList;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

public class ProDAO {
	
	public void update(ProVO vo) {
		try {
			String sql= "update professors set pname=?, dept=?,salary=?,title = ?,hiredate=?"
					+ " where pcode=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getPname());
			ps.setString(2, vo.getDept());
			ps.setInt(3, vo.getSalary());
			ps.setString(4, vo.getTitle());
			ps.setString(5, vo.getHiredate());
			ps.setString(6, vo.getPcode());
			ps.execute();
		}catch(Exception e) {
			System.out.println("교수수정" + e.toString());
		}
	}
	
	public ProVO read(String pcode){
		ProVO vo = new ProVO();
		try {
			String sql = "select * from professors where pcode = ?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, pcode);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				vo.setPcode(rs.getString("pcode"));
				vo.setPname(rs.getString("pname"));
				vo.setDept(rs.getString("dept"));
				vo.setHiredate(rs.getString("hiredate"));
				vo.setTitle(rs.getString("title"));
				vo.setSalary(rs.getInt("salary"));
			}
		}catch(Exception e) {
			System.out.println("교수정보" + e.toString());
		}
		return vo;
	}

	
	public void insert(ProVO vo) {
		try {
			int ncode=0;
			String sql = "select max(pcode+1) ncode from professors";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				ncode = rs.getInt("ncode");
			}
			sql= "insert into professors(pcode,pname,dept,salary,title,hiredate) "
					+ "values(?,?,?,?,?,?)";
			ps = Database.CON.prepareStatement(sql);
			ps.setInt(1, ncode);
			ps.setString(2, vo.getPname());
			ps.setString(3, vo.getDept());
			ps.setInt(4, vo.getSalary());
			ps.setString(5, vo.getTitle());
			ps.setString(6, vo.getHiredate());
			ps.execute();
		}catch(Exception e) {
			System.out.println("교수등록" + e.toString());
		}
	}
	
	
	public int total(String query, String key){
		int total = 0;
		try {
			String sql = "select count(*) cnt from professors where " + key + " like ?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%"+query+"%");
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				total = rs.getInt("cnt");
			}
		}catch(Exception e) {
			System.out.println("교수총원" + e.toString());
		}
		return total;
	}
	
	public List<ProVO> list(int page, String query, String key){
		List<ProVO> array = new ArrayList<ProVO>();
		try {
			String sql = "select * from professors "
					+ "where " + key + " like ? "
					+ "order by pcode limit ?,5";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%" + query + "%");
			ps.setInt(2, (page-1)*5);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				ProVO vo = new ProVO();
				vo.setPcode(rs.getString("pcode"));
				vo.setPname(rs.getString("pname"));
				vo.setDept(rs.getString("dept"));
				vo.setHiredate(rs.getString("hiredate"));
				vo.setTitle(rs.getString("title"));
				vo.setSalary(rs.getInt("salary"));
				array.add(vo);
			}
		}catch(Exception e) {
			System.out.println("교수목록" + e.toString());
		}
		return array;
	}
	
	public List<ProVO> all(){
		List<ProVO> array = new ArrayList<ProVO>();
		try {
			String sql = "select * from professors order by pname";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				ProVO vo = new ProVO();
				vo.setPcode(rs.getString("pcode"));
				vo.setPname(rs.getString("pname"));
				vo.setDept(rs.getString("dept"));
				vo.setHiredate(rs.getString("hiredate"));
				vo.setTitle(rs.getString("title"));
				vo.setSalary(rs.getInt("salary"));
				array.add(vo);
			}
		}catch(Exception e) {
			System.out.println("총목록" + e.toString());
		}
		return array;
	}
}
