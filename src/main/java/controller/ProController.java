package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import model.*;

@WebServlet(value={"/pro/list", "/pro/list.json", "/pro/total", "/pro/insert", "/pro/update"})
public class ProController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ProDAO dao = new ProDAO();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	DecimalFormat df = new DecimalFormat("#,###원");
	
       
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		switch(request.getServletPath()) {
		case "/pro/list":
			request.setAttribute("pageName", "/pro/list.jsp");
			dis.forward(request, response);
			break;
		case "/pro/list.json":
			int page = request.getParameter("page")==null ? 1:
				Integer.parseInt(request.getParameter("page"));
			String query = request.getParameter("query")==null ? "":
				request.getParameter("query");
			String key = request.getParameter("key");
			List<ProVO> array = dao.list(page, query, key);
			JSONArray jarray = new JSONArray();
			for (ProVO vo : array) {
				JSONObject job = new JSONObject();
				job.put("pcode", vo.getPcode());
				job.put("pname", vo.getPname());
				job.put("dept", vo.getDept());
				job.put("hiredate", vo.getHiredate());
				job.put("title", vo.getTitle());
				job.put("salary", df.format(vo.getSalary()));
				jarray.add(job);
			}
			
			out.print(jarray);
			break;
		case "/pro/total":
			key = request.getParameter("key");
			query = request.getParameter("query")==null ? "":
				request.getParameter("query");
			out.print(dao.total(query, key));
			break;
		case "/pro/update":
			String pcode= request.getParameter("pcode");
			request.setAttribute("vo", dao.read(pcode));
			request.setAttribute("pageName", "/pro/update.jsp");
			dis.forward(request, response);
			break;
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		switch(request.getServletPath()) {
		case "/pro/insert":
			ProVO vo = new ProVO();
			vo.setPname(request.getParameter("pname"));
			vo.setDept(request.getParameter("dept"));
			vo.setTitle(request.getParameter("title"));
			vo.setSalary(Integer.parseInt(request.getParameter("salary")));
			vo.setHiredate(request.getParameter("hiredate"));
			dao.insert(vo);
			break;
		case "/pro/update":
			vo = new ProVO();
			vo.setPcode(request.getParameter("pcode"));
			vo.setPname(request.getParameter("pname"));
			vo.setDept(request.getParameter("dept"));
			vo.setTitle(request.getParameter("title"));
			vo.setSalary(Integer.parseInt(request.getParameter("salary")));
			vo.setHiredate(request.getParameter("hiredate"));
			System.out.println(vo.toString());
			dao.update(vo);
			response.sendRedirect("/pro/list");
			break;
		}
	}

}
