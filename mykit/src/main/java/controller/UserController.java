package controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import exception.LoginException;
import logic.Sale;
import logic.ShopService;
import logic.User;

@Controller
@RequestMapping("user")
public class UserController {
	@Autowired
	private ShopService service;
	
	@GetMapping("*")
	public ModelAndView getUser() {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new User());
		return mav;
	}
	
	//[1.회원가입]
	@PostMapping("userentry")
	public ModelAndView userEnrty(@Valid User user, BindingResult bresult) {
		ModelAndView mav = new ModelAndView();
		//비밀번호 일치 확인
		if(!user.getPwcheck().equals(user.getUserpw()) || user.getPwcheck() == null) {
			bresult.rejectValue("userpw", "error.check");
		}
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel()); //User.java에 설정한 오류메세지
			bresult.reject("error.input.user"); //메모에 설정한 오류메세지
			return mav;
		}
		// 아이디 중복: 중복확인 무시하고 그대로 입력했을 경우 대비
		try {
			service.userInsert(user);
			mav.addObject("user", user);
		}catch(DataIntegrityViolationException e) {//DataIntegrityViolationException: 중복오류
			e.printStackTrace();
			bresult.reject("error.duplicate.user");
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		mav.setViewName("redirect:userlogin");
		return mav;
	}
	
	//[1.회원가입] - 아이디 중복확인
	@ResponseBody
	@RequestMapping(value = "/idcheck", produces="text/plane")
	public String idcheck(@RequestBody String paramData){
		//클라이언트가 보낸 ID값
		String ID = paramData.trim();
		String result = service.idcheck(ID);
		if(result != null) {//결과 값이 있으면 아이디 존재	
			return "-1";
		} else {//없으면 아이디 존재 X
			return "0";
		}
	}
	
	//[2.로그인]
	@PostMapping("userlogin")
	public ModelAndView login(@Valid User user, BindingResult bresult, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User dbUser = service.userSelectOne(user.getUserid()); //db에 아이디랑 일치하는 레코드
		if(dbUser == null) {
			bresult.reject("error.login.id"); //에러메세지: 아이디를 확인
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		System.out.println(dbUser.getUserid());
		//비밀번호 비교
		if(user.getUserpw().equals(dbUser.getUserpw())) {//입력한 비밀번호 = DB 비밀번호
			session.setAttribute("loginUser", dbUser); //세션에 등록
			mav.setViewName("redirect:main");
		}else {
			bresult.reject("error.login.password"); //에러메세지: 비밀번호 틀림
			mav.getModel().putAll(bresult.getModel());
		}
		return mav;
	}
	
	//[3.로그아웃] + 로그인 확인(aop: loginCheck*)
	@RequestMapping("userlogout")
	public String loginChecklogout(HttpSession session) {
		session.invalidate();
		return "redirect:userlogin";
	}
	@RequestMapping("mainlogout")
	public String loginCheckmainlogout(HttpSession session) {
		session.invalidate();
		return "redirect:main";
	}
	
	//[4-1.아이디, 비밀번호 찾기]
	@PostMapping("{url}search")
	public ModelAndView search(User user, BindingResult bresult, @PathVariable String url) {
		ModelAndView mav = new ModelAndView();
		String code = "error.userid.search";
		String title = "아이디";
		if(user.getEmail() == null || user.getEmail().equals("")) {
			bresult.rejectValue("email", "error.required");
		}
		if(user.getPhoneno() == null || user.getPhoneno().equals("")) {
			bresult.rejectValue("phoneno", "error.required");
		}
		if(url.equals("pw")) {
			code = "error.password.search";
			title = "비밀번호";
			if(user.getUserid() == null || user.getUserid().equals("")) {
				bresult.rejectValue("userid", "error.required");
			}
		}
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		String result = null;
		//고칠 부분(엉뚱한 값 넣었을 때 예외처리)
		result = service.getSearch(user, url);
		System.out.println(result);
		if(result==null) {
			bresult.reject(code);
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		mav.addObject("result", result);
		mav.addObject("title", title);
		mav.setViewName("search");
		return mav;
	}
	
	//[4-2.아이디, 비밀번호 이메일전송]
	@RequestMapping("{url}send")
	public ModelAndView send(User user, BindingResult bresult, @PathVariable String url) throws Exception {
		ModelAndView mav = new ModelAndView();
		String code = "error.userid.search";
		String result = "";
		if(user.getEmail() == null || user.getEmail().equals("")) {
			bresult.rejectValue("email", "error.required");
		}
		if(user.getPhoneno() == null || user.getPhoneno().equals("")) {
			bresult.rejectValue("phoneno", "error.required");
		}
		if(url.equals("pw")) {
			code = "error.password.search";
			if(user.getUserid() == null || user.getUserid().equals("")) {
				bresult.rejectValue("userid", "error.required");
			}
		}
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		if(url.equals("pw")) {
			result = service.find(user, url);
			emailsend(user.getEmail(), user.getUserid(), result, "비밀번호");
		}else if(url.equals("id")) {
			result = service.find(user, url);
			emailsend(user.getEmail(), result, "test", "아이디");
		}
		if(result==null) {
			bresult.reject(code);
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		mav.addObject("result", result);
		mav.setViewName("send");
		return mav;
	}
	public void emailsend(String em, String id, String pw, String word) throws Exception{
		// Mail Server 설정
		String charSet = "utf-8";
		String hostSMTP = "smtp.naver.com";
		String hostSMTPid = "rabbi31@naver.com"; //보내는 사람 이메일 주소
		String hostSMTPpwd = "20qo20qo"; //보내는 사람 이메일 비번
		// 보내는 사람 E-Mail, 제목, 내용
		String fromEmail = "rabbi31@naver.com"; //보내는 사람 이메일주소(받는 사람 이메일에 표시됨)
		String fromName = "관리자"; //프로젝트이름 또는 보내는 사람 이름
		String subject = "";
		String msg = "";

		if(word.equals("비밀번호")) {
			subject = "[MyKit] 비밀번호 찾기 인증 이메일 입니다.";
			msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
			msg += "<h3 style='color: blue;'>";
			msg += id + "님의 비밀번호 입니다. 비밀번호를 변경하시려면 회원수정을 이용해주세요.</h3>";
			msg += "<p>비밀번호 : ";
			msg += pw + "</p></div>";
		}
		if(word.equals("아이디")) {
			subject = "[MyKit] 아이디 찾기 인증 이메일 입니다.";
			msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
			msg += "<h3 style='color: blue;'>";
			msg += "회원님의 아이디 입니다. 로그인 후 MyKit 사이트를 이용해주세요.</h3>";
			msg += "<p>아이디 : ";
			msg += id + "</p></div>";
		}
		// 받는 사람 E-Mail 주소
		String mail = em;
		try {
			HtmlEmail email = new HtmlEmail();
			email.setDebug(true);
			email.setCharset(charSet);
			email.setSSL(true);
			email.setHostName(hostSMTP);
			email.setSmtpPort(587);

			email.setAuthentication(hostSMTPid, hostSMTPpwd);
			email.setTLS(true);
			email.addTo(mail, charSet);
			email.setFrom(fromEmail, fromName, charSet);
			email.setSubject(subject);
			email.setHtmlMsg(msg);
			email.send();
		} catch (Exception e) {
			System.out.println("메일발송 실패 : " + e);
		}
	}
	
	//[5. 회원수정, 회원탈퇴 확인]
	@GetMapping({"userupdate", "userdelete"})
	public ModelAndView idCheckUpdate(String id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = service.userSelectOne(id);
		mav.addObject("user", user); //user객체 전달
		return mav;
	}
	
	//[5-1. 회원수정]
	@PostMapping("userupdate")
	public ModelAndView update(@Valid User user, BindingResult bresult, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		//1.유효성 검증
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		 //2.비밀번호 검증 
		User loginUser = (User)session.getAttribute("loginUser");
		if(!loginUser.getUserpw().equals(user.getUserpw())) {//비밀번호 틀린경우
			bresult.reject("error.login.password");
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		//비밀번호 정상인 경우
		try {
			service.userUpdate(user); //수정 성공
			//session정보 수정하기
			if(user.getUserid().equals(loginUser.getUserid())) { //본인정보 수정시에만 로그인 정보 수정
				session.setAttribute("loginUser", user);
			}
			mav.setViewName("redirect:mypage?id="+loginUser.getUserid());
		}catch(Exception e) {
			e.printStackTrace(); //수정 실패
			throw new LoginException("고객 정보 수정 실패", "userupdate");
		}
		return mav;
	}
	
	//[5-2. 비밀번호 변경]
	@GetMapping("password")
	public String loginCheckPasswordGet(HttpSession session) {
		return null;
	}
	//로그인한 사용자의 비밀번호만 변경 가능
	@PostMapping("password")
	public ModelAndView loginCheckPassword(@RequestParam Map<String, String> req, HttpSession session) {
		System.out.println(req); //password, chgpass(바뀔 번호), chgpass2(바뀔 번호 확인용)
		ModelAndView mav = new ModelAndView();
		User loginUser = (User)session.getAttribute("loginUser"); //로그인한 정보 가져오기
		//입력 비밀번호와 로그인정보의 비밀번호가 비교
		if(!req.get("password").equals(loginUser.getUserpw())) {
			throw new LoginException("비밀번호 오류입니다!", "password");
		}
		//1.db에 비밀번호변경
		//2.session 유저 정보 변경
		try {
			service.userPassword(loginUser.getUserid(), req.get("chgpass")); //아이디, 바꿀 비번
			loginUser.setUserpw(req.get("chgpass")); //session의 loginUser객체의 비밀번호 수정
			session.invalidate();
			mav.setViewName("redirect:userlogin");
		}catch(Exception e) {
			throw new LoginException("비밀번호 수정 시, 오류가 있습니다.", "password");
		}
		return mav;
	}
	
	//[5-3. 회원탈퇴]
	@PostMapping("userdelete")
	public ModelAndView idCheckdelete(String userid, HttpSession session, String password) { //1.파라미터 정보 저장
		ModelAndView mav = new ModelAndView();
		if(userid.equals("admin")) {//관리자인 경우
			throw new LoginException("관리자 탈퇴는 불가합니다.", "main");
		}
		//본인탈퇴
		User loginUser = (User)session.getAttribute("loginUser"); //로그인한 정보 가져오기
		//비밀번호 검증 -> 불일치
		if(!password.equals(loginUser.getUserpw())) {//비밀번호 불일치
			throw new LoginException("비밀번호를 확인하세요!", "userdelete?id="+userid);
		}
		//비밀번호 검증 -> 일치
		try {
			service.userDelete(userid); //db연결해서 삭제
		}catch(Exception e) {
			e.printStackTrace();
			throw new LoginException("탈퇴시 오류발생", "userdelete?id="+userid);
		}
		if(loginUser.getUserid().equals("admin")) {//관리자
			//관리자가 회원 강제 탈퇴시 admin/list페이지로 이동
			mav.setViewName("redirect:../admin/list");
		}else {//일반사용자
			mav.setViewName("redirect:userlogin");
			session.invalidate();
		}
		return mav;
	}
	
	//[6-1. 마이페이지]
	@RequestMapping("mypage")
	public ModelAndView idCheckMypage(String id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = service.userSelectOne(id);
		int rpoint = service.getUserPoint(id);
		mav.addObject("rpoint", rpoint);
		mav.addObject("user", user);
		return mav;
	}
	
	//[6-2. 마이페이지 주문목록]
	@RequestMapping("myitemlist")
	public ModelAndView idCheckMyItemList(String id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		//1.db에서 id에 해당하는 User객체 조회
		User user = service.userSelectOne(id);
		//2.주문정보 조회, 리스트 가져오기
		List<Sale> salelist = service.salelist(id);
		mav.addObject("salelist", salelist); //[회원이 주문한 정보]
		mav.addObject("user", user); //[회원정보]user객체 전달
		return mav;
	}
}
