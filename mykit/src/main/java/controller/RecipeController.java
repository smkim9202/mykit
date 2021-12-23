package controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import exception.RecipeException;
import logic.Recipe;
import logic.ShopService;
import logic.User;


@Controller
@RequestMapping("recipe")
public class RecipeController {
	@Autowired
	ShopService service;
	
	//Recipe 설정되있지 않은 모든페이지
	@GetMapping("*") 
	public ModelAndView getRecipe(Integer rcnum) {
		ModelAndView mav = new ModelAndView();
		if (rcnum != null) {
		    Recipe recipe = service.getRecipe(rcnum);
		    mav.addObject("recipe", recipe);
		} else     mav.addObject(new Recipe());
		return mav;
	}
	
	//레시피 글쓰기(회원만 가능 => aop)
	@GetMapping("rcwrite")
	public ModelAndView getRcwrite(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Recipe recipe = new Recipe();
		mav.addObject("recipe",recipe); 
		return mav;  
	}

	@PostMapping("rcwrite")
	public ModelAndView rcwrite(@Valid Recipe recipe, BindingResult bresult, HttpServletRequest request) {
		System.out.println("레시피작성전:"+recipe);
		ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		service.rcwrite(recipe,request);
		mav.setViewName("redirect:rclist");
		return mav;
	}

	//스마트에디터 - 이미지업로드
	@RequestMapping("imgupload")
	public String imgupload(MultipartFile upload, String CKEditorFuncNum,
			HttpServletRequest request,Model model ) {

		String path = request.getServletContext().getRealPath("/") + "recipe/imgfile/";
		File f =new File(path);

		if(!f.exists()) f.mkdirs();
		
		if(!upload.isEmpty()) { 
			File file = new File(path,upload.getOriginalFilename());
			try {
				upload.transferTo(file); 
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		String fileName = request.getContextPath() + "/recipe/imgfile/" 
		               + upload.getOriginalFilename();
		model.addAttribute("fileName",fileName);
		model.addAttribute("CKEditorFuncNum",CKEditorFuncNum);

		return "ckedit";
	}
	
	//레시피 목록 - 기본정렬
	@RequestMapping("rclist")
	public ModelAndView list(HttpServletRequest request, Integer pageNum, String searchtype, String searchcontent, String sort) { 
		ModelAndView mav = new ModelAndView();
		// sort null check
		if (sort == null)
			sort = "recent";
		
		//페이징처리
		if(pageNum == null || pageNum.toString().equals("")) {
			   pageNum = 1;
			}
		
		//검색
		if(searchtype == null || searchcontent == null ||
				searchtype.trim().equals("") || searchcontent.trim().equals("")) {
			searchtype = null;
			searchcontent = null;
		}
		int limit = 5; //5건식조회
		int listcount = service.recipeCount(searchtype,searchcontent); //전체 게시물 등록 건수  
		List<Recipe> recipelist = service.recipelist(pageNum,limit,searchtype,searchcontent,sort); //페이지에 출력한 게시물 목록 		
		int maxpage = (int)((double)listcount/limit + 0.95); //최대 필요한 페이지 수
		int startpage = (int)((pageNum/10.0 + 0.9) - 1) * 10 + 1;//화면에 표시할 페이지의 시작 번호
		int endpage = startpage + 9;
		if(endpage > maxpage) endpage = maxpage; //화면에 표시할 페이지의 끝 번호
		int recipeno = listcount - (pageNum - 1) * limit; //화면 표시될 게시물 번호. 의미없음
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("listcount", listcount);
		mav.addObject("recipelist", recipelist);
		mav.addObject("recipeno", recipeno);
		mav.addObject("sort", sort);
		return mav;
	}
	
	//레시피 포인트 추가 - 관리자만 가능
	@PostMapping("rcpoint")
	public String addpoint(HttpServletRequest request, Integer rcpoint, String recipeuserid) {
		System.out.println("추가해야할 포인트 : "+rcpoint); //view단에서 받아온 레시피 추가 포인트 값
		System.out.println("추가해줘야할 회원 : "+recipeuserid); //view단에서 받아온 레시피게시판 작성자
		int crrentRpoint = service.selectRpoint(recipeuserid); //작성자의 현재포인트 조회 후 리턴
		System.out.println("현재포인트"+crrentRpoint); //Sale에서 받아온 현재 포인트 값
		int totalPoint = crrentRpoint + rcpoint;// 총포인트 = 현재포인트 + 레시피 추가 포인트
		System.out.println("총포인트"+totalPoint);
		service.addRcpoint(totalPoint,recipeuserid);
		
		return "redirect:rclist";
	}

	
	
	//레시피 글상세보기
	@GetMapping("rcdetail")
	public ModelAndView evdetail(Integer rcnum, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if (rcnum != null) {
		    Recipe recipe = service.getRecipe(rcnum);
		    service.rcreadcntadd(rcnum);//조회된 레코드의 조회건수 1증가
		    User loginUser = (User)session.getAttribute("loginUser"); //로그인유저받아오기
		    int heart = 0;
		    if(loginUser!=null) {//로그인일경우
		    	heart = service.checkheart(rcnum,loginUser.getUserid());//좋아요 체크하트가 0이면 좋아요x 1이면 누름
		    }
			mav.addObject("recipe", recipe);
			mav.addObject("heart", heart);
			} 
		return mav;  
	}
	
	//레시피 글수정, 레시피 글삭제(작성자 and 관리자만 가능)
	@GetMapping(value ={"rcupdate","rcdelete"})
	public ModelAndView getQaboard(Integer rcnum, String userid, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if (rcnum != null) {
		    Recipe recipe = service.getRecipe(rcnum);
		    //관리자와 작성자만 수정,삭제 가능
		    User loginUser = (User)session.getAttribute("loginUser"); //로그인유저받아오기
		    if(loginUser==null) {//로그아웃일경우
				throw new RecipeException("권한이없습니다.","rclist");
			}
		    else if((loginUser.getUserid().equals(recipe.getUserid())) //로그인유저가 작성자 
	    			|| (loginUser.getUserid().equals("admin"))) {//관리자일경우
				System.out.println("로그인유저:"+loginUser.getUserid());
				System.out.println("작성자:"+recipe.getUserid());
			}else {//로그인유저 아니고, 관리자도 아닐경우
				throw new RecipeException("권한이없습니다.","rclist");
			}
		    mav.addObject("recipe", recipe);
		} 
		return mav;
	}
	
	//레시피 글수정
	@PostMapping("rcupdate")
	public ModelAndView rcupdate(Recipe recipe,
			BindingResult bresult,HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		try {
			recipe.setRcimgurl(request.getParameter("file2"));
			service.recipeUpdate(recipe, request);
			mav.setViewName
			("redirect:rcdetail?rcnum="+recipe.getRcnum());
		} catch (Exception e) {
			e.printStackTrace();
			throw new RecipeException("레시피 수정을 실패 했습니다.",
				"rcupdate?rcnum="+recipe.getRcnum());
		}
		return mav;
	}
	
	//레시피 글삭제
	@PostMapping("rcdelete")
	public ModelAndView delete(Recipe recipe,BindingResult bresult,HttpServletRequest request){
		ModelAndView mav = new ModelAndView();
		int rcnum =recipe.getRcnum();
			try {
				service.recipeDelete(rcnum);
				mav.setViewName("redirect:rclist");

			}catch (Exception e) {
				e.printStackTrace();
				throw new RecipeException("레시피 삭제를 실패 했습니다.", "rcdelete?rcnum="+rcnum);		
			}		
	    return mav;
	}
	
	//좋아요 구현
	@RequestMapping(value="addHeart.do")
	public ModelAndView addHeart(@RequestParam int rcnum, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User loginUser = (User)session.getAttribute("loginUser");
		service.addHeart(rcnum, loginUser.getUserid());
		return mav;
	}
	@RequestMapping(value="minusHeart.do")
	public ModelAndView minusHeart(@RequestParam int rcnum, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User loginUser = (User)session.getAttribute("loginUser");
		service.minusHeart(rcnum, loginUser.getUserid());
		return mav;
	}
	@RequestMapping(value="doHeart.do")
	public ModelAndView doHeart(@RequestParam("rcnum") int rcnum, @RequestParam("userid") String userid, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		System.out.println("doHeart(userid) : "+userid);
		System.out.println("doHeart(rcnum) : "+rcnum);
		//User loginUser = (User)session.getAttribute("loginUser");
		//service.minusHeart(rcnum, loginUser.getUserid());
		return mav;
	}
}
