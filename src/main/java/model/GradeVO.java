package model;

public class GradeVO extends StuVO{
	private String lcode;
	private String scode;
	private String edate;
	private int grade;
	
	public String getLcode() {
		return lcode;
	}
	public void setLcode(String lcode) {
		this.lcode = lcode;
	}
	public String getScode() {
		return scode;
	}
	public void setScode(String scode) {
		this.scode = scode;
	}
	public String getEdate() {
		return edate;
	}
	public void setEdate(String edate) {
		this.edate = edate;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	@Override
	public String toString() {
		return "GradeVO [lcode=" + lcode + ", scode=" + scode + ", edate=" + edate + ", grade=" + grade
				+ ", getSname()=" + getSname() + ", getDept()=" + getDept() + ", getPname()=" + getPname() + "]";
	}
	
	
	
}
