package model;

import java.util.ArrayList;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

public class GradeDAO {
	public List<GradeVO> list(String lcode){
		List<GradeVO> array = new ArrayList<GradeVO>();
		try {
			String sql="select * from view_se where lcode=? order by scode";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, lcode);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				GradeVO vo = new GradeVO();
				vo.setScode(rs.getString("scode"));
				vo.setSname(rs.getString("sname"));
				vo.setDept(rs.getString("dept"));
				vo.setEdate(rs.getString("edate"));
				vo.setGrade(rs.getInt("grade"));
				array.add(vo);
			}
		}catch(Exception e) {
			System.out.println("성적목록" + e.toString());
		}
		return array;
	}
}
