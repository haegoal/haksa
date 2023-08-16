package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.google.gson.Gson;

import java.util.*;
import model.*;

@WebServlet(value={"/cou/list", "/cou/total", "/cou/list.json", 
		"/cou/insert", "/cou/update", "/cou/all.json", 
		"/cou/grade","/cou/grade.json", "/grade/update"})
public class CourseController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	CouDAO dao = new CouDAO();
	GradeDAO gdao= new GradeDAO();
	ProDAO pdao = new ProDAO();
       
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		switch(request.getServletPath()) {
		case "/cou/list":
			request.setAttribute("parray", pdao.all());
			request.setAttribute("pageName", "/cou/list.jsp");
			dis.forward(request, response);
			break;
		case "/cou/total":
			String query = request.getParameter("query")==null ? "":
				request.getParameter("query");
			String key = request.getParameter("key");
			out.print(dao.total(key, query));
			break;
		case "/cou/list.json":
			int page = request.getParameter("page")==null ? 1:
				Integer.parseInt(request.getParameter("page"));
			query = request.getParameter("query")==null ? "":
				request.getParameter("query");
			key = request.getParameter("key");
			Gson gson = new Gson();
			out.print(gson.toJson(dao.list(page, key, query)));
			break;
		case "/cou/update":
			request.setAttribute("vo", dao.read(request.getParameter("lcode")));
			request.setAttribute("parray", pdao.all());
			request.setAttribute("pageName", "/cou/update.jsp");
			dis.forward(request, response);
			break;
		case "/cou/all.json":
			List<CouVO> array = dao.all();
			JSONArray jarray = new JSONArray();
			for (CouVO vo : array) {
				JSONObject obj = new JSONObject();
				obj.put("lcode", vo.getLcode());
				obj.put("lname", vo.getLname());
				obj.put("pname", vo.getPname());
				obj.put("persons", vo.getPersons());
				obj.put("capacity", vo.getCapacity());
				jarray.add(obj);
			}
			out.print(jarray);
			break;
		case  "/cou/grade":
			request.setAttribute("vo", dao.read(request.getParameter("lcode")));
			request.setAttribute("pageName", "/cou/grade.jsp");
			dis.forward(request, response);
			break;
		case "/cou/grade.json":
				String lcode=request.getParameter("lcode");
				List<GradeVO> carray = gdao.list(lcode);
				jarray = new JSONArray();
				for (GradeVO vo : carray) {
					JSONObject obj = new JSONObject();
					obj.put("lcode", vo.getLcode());
					obj.put("lname", vo.getSname());
					obj.put("dept", vo.getDept());
					obj.put("grade", vo.getGrade());
					obj.put("edate", vo.getEdate().substring(1,10));
					jarray.add(obj);
				}
				out.print(jarray);
				break;
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		switch(request.getServletPath()) {
		case "/cou/insert":
			CouVO vo = new CouVO();
			vo.setLname(request.getParameter("lname"));
			vo.setHours(Integer.parseInt(request.getParameter("hour")));
			vo.setRoom(request.getParameter("room"));
			vo.setInstructor(request.getParameter("instructor"));
			vo.setPersons(Integer.parseInt(request.getParameter("persons")));
			vo.setCapacity(Integer.parseInt(request.getParameter("capacity")));
			System.out.println(vo.toString());
			dao.insert(vo);
			response.sendRedirect("/cou/list");
			break;
		case "/cou/update":
			vo = new CouVO();
			vo.setLcode(request.getParameter("lcode"));
			vo.setLname(request.getParameter("lname"));
			vo.setHours(Integer.parseInt(request.getParameter("hour")));
			vo.setRoom(request.getParameter("room"));
			vo.setInstructor(request.getParameter("instructor"));
			vo.setPersons(Integer.parseInt(request.getParameter("persons")));
			vo.setCapacity(Integer.parseInt(request.getParameter("capacity")));
			System.out.println(vo.toString());
			dao.update(vo);
			response.sendRedirect("/cou/list");
			break;
		case "/grade/update":
			GradeVO gvo=new GradeVO();
			gvo.setLcode(request.getParameter("lcode"));
			gvo.setScode(request.getParameter("scode"));
			gvo.setGrade(Integer.parseInt(request.getParameter("grade")));
			dao.update(gvo);
			break;
		}
	}

}
