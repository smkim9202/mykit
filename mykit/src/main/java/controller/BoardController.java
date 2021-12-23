package controller;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.HandlerMapping;
import org.springframework.web.servlet.ModelAndView;

import exception.BoardException;
import logic.Board;
import logic.ShopService;
import logic.User;

@Controller
@RequestMapping("board")
public class BoardController {
	@Autowired
	ShopService service;
	
	//Board 설정되있지 않은 모든페이지
	@GetMapping("*") 
	public ModelAndView getBoard(Integer num) {
		ModelAndView mav = new ModelAndView();
		if (num != null) {
		    Board board = service.getBoard(num);
		    mav.addObject("board", board);
		} else     mav.addObject(new Board());
		return mav;
	}
	
	//Q&A 글쓰기(회원만 가능 => aop)
	@GetMapping("qawrite")
	public ModelAndView getQawrite(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Board board = new Board();
		mav.addObject("board",board); 
		return mav;  
	}

	@PostMapping("qawrite")
	public ModelAndView qawrite(@Valid Board board, BindingResult bresult, HttpServletRequest request) {
		System.out.println("QA쓰기전:"+board);
		ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) {
			System.out.println(bresult.getModel());
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		System.out.println("로그인한 userid=>"+board.getUserid());
		service.boardqawrite(board,request);
		mav.setViewName("redirect:qalist");
		return mav;
	}
	
	//공지이벤트 글쓰기(관리자만 가능)
	@GetMapping("evwrite")
	public ModelAndView getEvwrite(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Board board = new Board();
		mav.addObject("board",board); 
		return mav;  
	}
	
	@PostMapping("evwrite")
	public ModelAndView evwrite(@Valid Board board, BindingResult bresult, HttpServletRequest request) {
		System.out.println("공이쓰기전:"+board);
		ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) {
			System.out.println(bresult.getModel());
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		service.boardevwrite(board,request);
		
		mav.setViewName("redirect:evlist");
		return mav;
	}
	
	//스마트에디터 - 이미지업로드
	@RequestMapping("imgupload")
	public String imgupload(MultipartFile upload, String CKEditorFuncNum,
			HttpServletRequest request,Model model ) {

		String path = request.getServletContext().getRealPath("/") + "board/imgfile/";
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
		String fileName = request.getContextPath() + "/board/imgfile/" 
		               + upload.getOriginalFilename();
		model.addAttribute("fileName",fileName);
		model.addAttribute("CKEditorFuncNum",CKEditorFuncNum);

		return "ckedit";
	}
	
	//Q&A 목록 / 공지이벤트 목록
	@RequestMapping(value ={"qalist","evlist"})
	public ModelAndView list(HttpServletRequest request, Integer pageNum, String searchtype, String searchcontent) { 
		ModelAndView mav = new ModelAndView();
		//Url구분 후 btype(0. Q&A게시판 / 1. 공지이벤트게시판)조회 할 값(boardtype) 넣어주기
		String requestUrl = (String)request.getAttribute(HandlerMapping.PATH_WITHIN_HANDLER_MAPPING_ATTRIBUTE);
		System.out.println(requestUrl);
		int boardtype = 0; 
		if(requestUrl.equals("/board/qalist")){
			boardtype = 0;
		}else if(requestUrl.equals("/board/evlist")){
			boardtype = 1;
		}
		System.out.println("게시판구분"+boardtype);
		
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
		int limit = 10; //10건식조회
		int listcount = service.boardcount(searchtype,searchcontent,boardtype); //전체 게시물 등록 건수  
		List<Board> boardlist = service.boardlist(pageNum,limit,searchtype,searchcontent,boardtype); //페이지에 출력한 게시물 목록 
		int maxpage = (int)((double)listcount/limit + 0.95); //최대 필요한 페이지 수
		int startpage = (int)((pageNum/10.0 + 0.9) - 1) * 10 + 1;//화면에 표시할 페이지의 시작 번호
		int endpage = startpage + 9;
		if(endpage > maxpage) endpage = maxpage; //화면에 표시할 페이지의 끝 번호
		int boardno = listcount - (pageNum - 1) * limit; //화면 표시될 게시물 번호. 의미없음
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("listcount", listcount);
		mav.addObject("boardlist", boardlist);
		mav.addObject("boardno", boardno);
		return mav;
	}	
	
	//Q&A 글상세보기(비공개글 : 작성자 and 관리자만 가능)
	@GetMapping("qadetail")
	public ModelAndView qadetail(Integer num, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if (num != null) {
		    Board board = service.getBoard(num);
		    //비공개글은 작성자와 관리자만 볼 수 있다.
		    //비공개글 =>작성자와관리자가 아닐경우=> 예외페이지로 넘겨주기
		   	if(board.getBoardlock().equals("bdlock")) {//비공개글일경우
 				User loginUser = (User)session.getAttribute("loginUser"); //로그인유저받아오기
				if(loginUser==null) {//로그아웃일경우
					throw new BoardException("권한이없습니다.","qalist");
				}
				else if((loginUser.getUserid().equals(board.getUserid())) //로그인유저가 작성자 
		    			|| (loginUser.getUserid().equals("admin"))) {//관리자일경우
					System.out.println("로그인유저:"+loginUser.getUserid());
					System.out.println("작성자:"+board.getUserid());
				}else {//로그인유저 아니고, 관리자도 아닐경우
					throw new BoardException("권한이없습니다.","qalist");
				}
			}
			mav.addObject("board", board);
		} 
		return mav;  
	}
	
	//공지이벤트 글상세보기
	@GetMapping("evdetail")
	public ModelAndView evdetail(Integer num) {
		ModelAndView mav = new ModelAndView();
		if (num != null) {
		    Board board = service.getBoard(num);
			mav.addObject("board", board);
			} 
		return mav;  
	}
	
	//Q&A 글수정하기, Q&A 글삭제하기(작성자 and 관리자만 가능)
	@GetMapping(value ={"qaupdate","qadelete"})
	public ModelAndView getQaboard(Integer num, String userid, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if (num != null) {
		    Board board = service.getBoard(num);
		    //관리자와 작성자만 Q&A게시판 수정,삭제 가능
		    User loginUser = (User)session.getAttribute("loginUser"); //로그인유저받아오기
		    if(loginUser==null) {//로그아웃일경우
				throw new BoardException("권한이없습니다.","qalist");
			}
		    else if((loginUser.getUserid().equals(board.getUserid())) //로그인유저가 작성자 
	    			|| (loginUser.getUserid().equals("admin"))) {//관리자일경우
				System.out.println("로그인유저:"+loginUser.getUserid());
				System.out.println("작성자:"+board.getUserid());
			}else {//로그인유저 아니고, 관리자도 아닐경우
				throw new BoardException("권한이없습니다.","qalist");
			}
		    mav.addObject("board", board);
		} 
		return mav;
	}
	
	//Q&A 답글달기 / 공지이벤트 글수정하기, 글삭제하기(관리자만 가능=>AOP)
	@GetMapping(value ={"qareply","evupdate","evdelete"})
	public ModelAndView getAdminBoard(Integer num, HttpSession session) {
		System.out.println("호출getAdaminBoard");
		ModelAndView mav = new ModelAndView();
		if (num != null) {
		    Board board = service.getBoard(num);
		    mav.addObject("board", board);
		} else     mav.addObject(new Board());
		return mav;
	}
	
	
	//Q&A 글수정하기 / 공지이벤트 글수정하기
	@PostMapping(value = {"qaupdate","evupdate"})
	public ModelAndView qaupdate(@Valid Board board,
			BindingResult bresult,HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		//글수정하기 게시판 구분 url
		String requestUrl = (String)request.getAttribute(HandlerMapping.PATH_WITHIN_HANDLER_MAPPING_ATTRIBUTE);
		System.out.println(requestUrl);
		System.out.println("수정하기 url : "+requestUrl);
		
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		
		try {
			board.setFileurl(request.getParameter("file2"));
			service.boardUpdate(board, request);
			
			if(requestUrl.equals("/board/qaupdate")) {
				mav.setViewName("redirect:qadetail?num="+board.getNum());
			}else {
				mav.setViewName("redirect:evdetail?num="+board.getNum());
			}
		} catch (Exception e) {
			e.printStackTrace();
			if(requestUrl.equals("/board/qaupdate")) {
				throw new BoardException("게시글 수정을 실패 했습니다.",
						"qaupdate?num="+board.getNum());
			}else{
				throw new BoardException("게시글 수정을 실패 했습니다.",
						"evupdate?num="+board.getNum());
			}
		}
		return mav;
	}	
	

	
	//Q&A 글삭제하기 / 공지이벤트 글삭제하기
	@PostMapping(value = {"qadelete","evdelete"})
	public ModelAndView delete(Board board,BindingResult bresult,HttpServletRequest request){
		ModelAndView mav = new ModelAndView();
		//글삭제하기 게시판 구분 url
		String requestUrl = (String)request.getAttribute(HandlerMapping.PATH_WITHIN_HANDLER_MAPPING_ATTRIBUTE);
		System.out.println(requestUrl);
		System.out.println("수정하기 url : "+requestUrl);
		
		System.out.println(board.getGrpnum()+":grpnum<==>num:"+board.getNum());
		//원글 삭제시 답글까지 같이 삭제, 답글 삭제시 답글만 삭제
		if(board.getNum() == board.getGrpnum()) { //원글이면 grpnum기준으로 모두 삭제
			
			int grpnum = board.getGrpnum();
			int num =board.getNum();
			try {
				service.orgboardDelete(grpnum);
				if(requestUrl.equals("/board/qadelete")) {
					mav.setViewName("redirect:qalist");
				}else {
					mav.setViewName("redirect:evlist");
				}
			}catch(Exception e){
				e.printStackTrace();
				if(requestUrl.equals("/board/qadelete")) {
					throw new BoardException("게시글 삭제를 실패 했습니다.", "qadelete?num="+num);
				}else {
					throw new BoardException("게시글 삭제를 실패 했습니다.", "evdelete?num="+num);
				}
			}
		
		} else {//원글이 아닐경우(답글일경우)
			int num =board.getNum();
			try {
				service.reboardDelete(num);
				if(requestUrl.equals("/board/qadelete")) {
					mav.setViewName("redirect:qalist");
				}else {
					mav.setViewName("redirect:evlist");
				}
			}catch (Exception e) {
				e.printStackTrace();
				if(requestUrl.equals("/board/qadelete")) {
					throw new BoardException("게시글 삭제를 실패 했습니다.", "qadelete?num="+num);
				}else {
					throw new BoardException("게시글 삭제를 실패 했습니다.", "evdelete?num="+num);
				}
			}		
		}
	    return mav;
	}
	
	//Q&A 답글달기
	@PostMapping("qareply")
	public ModelAndView reply (@Valid Board board,BindingResult bresult) {
		ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) {
			Board dbBoard = service.getBoard(board.getNum());
			// bresult.getModel() : 오류 정보를 저장하고 있는 객체
			Map<String, Object> map = bresult.getModel();
			Board b = (Board)map.get("board"); //화면에서 입력된 값 저장
			b.setTitle(dbBoard.getTitle());
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		//답변등록완료전 원글삭제시 답변등록 불가
		int checkgrpnum = service.boardcheckgrpnum(board.getGrpnum()); 
		System.out.println("원글 존재 결과 : "+checkgrpnum);//checkgrpnum 1:원글존재 0:원글삭제
		if(checkgrpnum==0) {//원글이 삭제 되었으면
	        throw new BoardException //강제로 예외페이지로 넘김
	        ("원글이 삭제되었습니다.","qalist");	
		}

		try {
			service.boardReply(board);
			mav.setViewName("redirect:qalist");
		} catch (Exception e) {
			e.printStackTrace();
	        throw new BoardException
           ("답글 등록에 실패 했습니다.","qareply?num="+board.getNum());
		}
		return mav;
	}
	

}