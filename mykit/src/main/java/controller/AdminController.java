package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import exception.LoginException;
import logic.Mail;
import logic.ShopService;
import logic.User;

@Controller
@RequestMapping("admin")
public class AdminController {
	@Autowired
	private ShopService service;
	
	// [1. 회원리스트]
	@RequestMapping("list")
	public ModelAndView list(Integer sort, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		List<User> userlist = service.userList();
		if (sort == null) sort = 0;
		if (sort == 0) Collections.sort(userlist, (u1, u2)-> u1.getUserid().compareTo(u2.getUserid()));
		mav.addObject("list", userlist);
		return mav;
	}
	
	// [2. 회원수정, 회원탈퇴 확인]
	@GetMapping({ "adminupdate", "admindelete" })
	public ModelAndView userUpdate(String id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = service.userSelectOne(id);
		mav.addObject("user", user);
		return mav;
	}

	// [2-1. 회원수정]
	@PostMapping("adminupdate")
	public ModelAndView update(@Valid User user, BindingResult bresult, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if (bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		User loginUser = (User) session.getAttribute("loginUser");
		if (!loginUser.getUserpw().equals(user.getUserpw())) {
			bresult.reject("error.login.password");
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		try {
			service.userUpdate(user);
			if (user.getUserid().equals(loginUser.getUserid())) {
				session.setAttribute("loginUser", user);
			}
			mav.setViewName("redirect:list");
		} catch (Exception e) {
			e.printStackTrace();
			throw new LoginException("고객 정보 수정 실패", "adminupdate");
		}
		return mav;
	}
	
	// [3. 회원탈퇴]
	@PostMapping("admindelete")
	public ModelAndView delete(String userid, HttpSession session, String password) {
		ModelAndView mav = new ModelAndView();
		if (userid.equals("admin")) {
			throw new LoginException("관리자 탈퇴는 불가합니다.", "main");
		}
		User loginUser = (User) session.getAttribute("loginUser"); // 로그인한 정보 가져오기
		// 비밀번호 검증 -> 불일치
		if (!password.equals(loginUser.getUserpw())) {// 비밀번호 불일치
			throw new LoginException("비밀번호를 확인하세요!", "admindelete?id=" + userid);
		}
		// 비밀번호 검증 -> 일치
		try {
			service.userDelete(userid);
		} catch (Exception e) {
			e.printStackTrace();
			throw new LoginException("탈퇴시 오류발생", "admindelete?id=" + userid);
		}
		if (loginUser.getUserid().equals("admin")) {// 관리자
			mav.setViewName("redirect:list");
		}
		return mav;
	}
	
	// [4.메일보내기]
	@RequestMapping("mailForm")
	public ModelAndView mailform(String[] idchks, HttpSession session) {
		ModelAndView mav = new ModelAndView("admin/mail");
		if(idchks == null || idchks.length==0) {
			throw new LoginException("메일 전송 대상자를 선택하세요", "list");
		}
		//idchks : 회원목록에서 선택된 userid에 회원 정보 목록
		List<User> userlist = service.userList(idchks);
		mav.addObject("list", userlist);
		return mav;
	}
	@RequestMapping("mail")
	public ModelAndView mail(Mail mail, HttpSession session) {
		ModelAndView mav = new ModelAndView("alert");
		mailSend(mail);
		mav.addObject("message", "메일 전송이 완료되었습니다.");
		mav.addObject("url", "list");
		return mav;
	}
	private final class MyAuthenticator extends Authenticator{
		private String id;
		private String pw;
		public MyAuthenticator(String id, String pw) {
			this.id = id;
			this.pw = pw;
		}
		@Override
		protected PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(id, pw);
		}
	}
	private void mailSend(Mail mail) {
		//메일 전송시 사용할 인증 객체 
		MyAuthenticator auth = new MyAuthenticator (mail.getNaverid(), mail.getNaverpw());
		Properties prop = new Properties();
		try {
			FileInputStream fis = new FileInputStream
					("C:\\webtest\\project\\mykit\\sou\\mykit\\src\\main\\resources\\mail.properties"); //절대경로
			prop.load(fis);
			prop.put("mail.smtp.user", mail.getNaverid());
		}catch(IOException e) {
			e.printStackTrace();
		}
		Session session = Session.getInstance(prop, auth);
		MimeMessage mimeMsg = new MimeMessage(session);
		try {
			mimeMsg.setFrom(new InternetAddress(mail.getNaverid()+"@naver.com")); //보내는 사람의 메일 주소
			List<InternetAddress> addrs = new ArrayList<InternetAddress>();
			String[] emails = mail.getRecipient().split(",");
			for(String email : emails) {
				try {
					//한글처리를 위해 인코딩 부분 설정
					addrs.add(new InternetAddress(new String(email.getBytes("utf-8"), "8859_1")));
				}catch(UnsupportedEncodingException ue) {
					ue.printStackTrace();
				}
			}
			InternetAddress[] arr = new InternetAddress[emails.length];
			for(int i=0; i<addrs.size(); i++) {
				arr[i]=addrs.get(i);
			}
			mimeMsg.setSentDate(new Date()); //보낸일자
			mimeMsg.setRecipients(Message.RecipientType.TO, arr); //(수신메일 주소설정) TO: 수신인, CC: 참조인
			mimeMsg.setSubject(mail.getTitle()); //메일제목
			//MimeMultipart : 내용부분
			MimeMultipart multipart = new MimeMultipart();
			MimeBodyPart message = new MimeBodyPart(); //내용, 첨부파일 분리 부분
			message.setContent(mail.getContents(), mail.getMtype()); //내용 부분 설정
			multipart.addBodyPart(message); //내용추가
			//첨부파일(getFile1)
			for(MultipartFile mf : mail.getFile1()) {
				if((mf != null) && (!mf.isEmpty())) {
					multipart.addBodyPart(bodyPart(mf));
				}
			}
			mimeMsg.setContent(multipart); //메일, 첨부파일 저장
			Transport.send(mimeMsg); //메일전송
		}catch(MessagingException me) {
			me.printStackTrace();
		}
	}
	private BodyPart bodyPart(MultipartFile mf) {
		MimeBodyPart body = new MimeBodyPart();
		String orgFile = mf.getOriginalFilename();
		String path = "c:/mailupload/"; //절대경로
		File f = new File(path);
		if(!f.exists()) f.mkdirs(); //해당 폴더가 없으면 폴더 생성
		File f1 = new File(path + orgFile); //업로드할 파일
		try {
			mf.transferTo(f1); //파일을 저장
			body.attachFile(f1); //메일에 첨부파일로 추가
			//한글 처리 설정
			body.setFileName(new String(orgFile.getBytes("UTF-8"), "8859_1"));
		}catch(Exception e) {
			e.printStackTrace();
		}
		return body;
	}
}
