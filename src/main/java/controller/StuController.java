package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.google.gson.Gson;

import model.*;

@WebServlet(value={"/stu/list", "/stu/list.json", 
		"/stu/total", "/stu/insert", 
		"/stu/update", "/stu/enroll", "/stu/enroll.json", "/enroll/insert", "/enroll/delete"})
public class StuController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	StuDAO dao = new StuDAO();
	ProDAO dao2 = new ProDAO();
	CouDAO cdao = new CouDAO();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
       
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		switch(request.getServletPath()) {
		case "/stu/list":
			request.setAttribute("parray", dao2.all());
			request.setAttribute("pageName", "/stu/list.jsp");
			dis.forward(request, response);
			break;
		case "/stu/list.json":
			String query = request.getParameter("query")==null ? "": 
				request.getParameter("query");
			int page = request.getParameter("page")==null ? 1: 
				Integer.parseInt(request.getParameter("page"));
			String key = request.getParameter("key")==null ? "pname":
				request.getParameter("key");
			JSONArray jarray = new JSONArray();
			for (StuVO vo : dao.list(page, query, key)) {
				JSONObject obj = new JSONObject();
				obj.put("scode", vo.getScode());
				obj.put("sname", vo.getSname());
				obj.put("dept", vo.getDept());
				obj.put("year", vo.getYear());
				obj.put("birthday", vo.getBirthday());
				obj.put("advisor", vo.getAdvisor());
				obj.put("pname", vo.getPname());
				jarray.add(obj);
			}
			out.print(jarray);
			break;
		case "/stu/total":
			query = request.getParameter("query")==null ? "": 
				request.getParameter("query");
			key = request.getParameter("key")==null ? "pname":
				request.getParameter("key");
			out.print(dao.total(query, key));
			break;
		case "/stu/enroll":
			request.setAttribute("carray", cdao.all());
			String scode = request.getParameter("scode");
			request.setAttribute("vo", dao.read(scode));
			request.setAttribute("pageName", "/stu/enroll.jsp");
			dis.forward(request, response);
			break;
		case "/stu/update":
			request.setAttribute("vo", dao.read(request.getParameter("scode")));
			request.setAttribute("parray", dao2.all());
			request.setAttribute("pageName", "/stu/update.jsp");
			dis.forward(request, response);
			break;
		case "/stu/enroll.json":
			List<EnrollVO> earray = dao.list(request.getParameter("scode"));
			jarray = new JSONArray();
			for (EnrollVO vo : earray) {
				JSONObject job = new JSONObject();
				job.put("lcode", vo.getLcode());
				job.put("lname", vo.getLname());
				job.put("edate", vo.getEdate().substring(0,10));
				job.put("grade", vo.getGrade());
				job.put("room", vo.getRoom());
				job.put("hours", vo.getHours());
				job.put("persons", vo.getPersons());
				job.put("capacity", vo.getCapacity());
				job.put("pname", vo.getPname());
				jarray.add(job);
			}
			
			out.print(jarray);
			break;
		case "/enroll/insert":
			scode = request.getParameter("scode");
			String lcode = request.getParameter("lcode");
			out.print(dao.insert(scode, lcode));
			break;
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		switch(request.getServletPath()) {
		case "/stu/insert":
			StuVO vo = new StuVO();
			vo.setSname(request.getParameter("sname"));
			vo.setDept(request.getParameter("dept"));
			vo.setBirthday(request.getParameter("birthday"));
			vo.setYear(Integer.parseInt(request.getParameter("year")));
			vo.setAdvisor(request.getParameter("advisor"));
			System.out.println(vo.toString());
			dao.insert(vo);
			response.sendRedirect("/stu/list");
			break;
		case "/stu/update":
			vo = new StuVO();
			vo.setScode(request.getParameter("scode"));
			vo.setSname(request.getParameter("sname"));
			vo.setDept(request.getParameter("dept"));
			vo.setBirthday(request.getParameter("birthday"));
			vo.setYear(Integer.parseInt(request.getParameter("year")));
			vo.setAdvisor(request.getParameter("advisor"));
			System.out.println(vo.toString());
			dao.update(vo);
			response.sendRedirect("/stu/list");
			break;
		case "/enroll/delete":
			String scode = request.getParameter("scode");
			String lcode = request.getParameter("lcode");
			dao.delete(scode, lcode);
			break;
		}
	}

}
