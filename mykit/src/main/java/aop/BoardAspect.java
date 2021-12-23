package aop;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import exception.LoginException;
import logic.User;

@Component
@Aspect
public class BoardAspect {
	//qalist(qa목록)-글쓰기버튼클릭 => 
	//qawrite(qa글쓰기) url로 접속 => 비회원 일 경우 사용 불가(logout 상태 사용 불가)
	@Around("execution(* controller.Board*.getQawrite(..)) && args(..,session)")
	public Object qawriteLoginCheck(ProceedingJoinPoint joinPoint,HttpSession session)	throws Throwable{
		User loginUser = (User)session.getAttribute("loginUser"); //로그인 정보 조회
		if(loginUser==null) {//로그아웃상태
			throw new LoginException("회원만 작성 가능합니다. 로그인 후 이용하세요.", "../user/userlogin");
		}
		return joinPoint.proceed(); //다음 메서드(핵심메서드)를 호출.
	}
	
	//evwrite(ev글쓰기) url로 접속 
	//	=> 비회원 or 관리자(admin) 아닌 회원 사용 불가(logout or 관리자X 사용 불가)
	@Around("execution(* controller.Board*.getEvwrite(..)) && args(..,session)")
	public Object evwriteLoginCheck(ProceedingJoinPoint joinPoint,HttpSession session)	throws Throwable{
		User loginUser = (User)session.getAttribute("loginUser"); 
		if((loginUser==null) || (!loginUser.getUserid().equals("admin"))) {//로그아웃상태 or 관리자X
			throw new LoginException("권한이 없습니다.", "../user/userlogin");
		}
		return joinPoint.proceed(); 
	}	
	
	/*  AOP로 받아오기엔 userid값을 중간에서 받아 오려면, url로 보내야 하는 문제 발생 => controller에서 공개글처럼 처리
	//qaupdate(qa글수정)/qadelete(qa글삭제) url로 접속 
	//	=> 비회원 or 관리자(admin) 아닌 회원 or 작성자 아닌 회원 사용 불가(logout or 관리자X or 작성자X)
	@Around("execution(* controller.Board*.getQaboard(..)) && args(..,userid,session)")
	public Object writerLoginCheck(ProceedingJoinPoint joinPoint,String userid,HttpSession session)	throws Throwable{
		User loginUser = (User)session.getAttribute("loginUser"); 
		System.out.println("chk userid (writerLoginCheck) : "+userid);
		//로그아웃상태 or 관리자X or 작성자X
		if((loginUser==null) || (!loginUser.getUserid().equals(userid)) || (!loginUser.getUserid().equals("admin"))) {//로그아웃 상태
			throw new LoginException("권한이 없습니다.", "../user/userlogin");
		} 
		return joinPoint.proceed(); 
	}	
	*/
	
	
	//qareply(qa답변글)/evupdate(ev글수정)/evdelete(ev글삭제)) url로 접속 
	//	=> 비회원 or 관리자(admin) 아닌 회원 사용 불가(logout or 관리자X)
	@Around("execution(* controller.Board*.getAdminBoard(..)) && args(..,session)")
	public Object adminLoginCheck(ProceedingJoinPoint joinPoint,HttpSession session)	throws Throwable{
		User loginUser = (User)session.getAttribute("loginUser"); 
		//로그아웃상태 or 관리자X or 작성자X
		if((loginUser==null) || (!loginUser.getUserid().equals("admin"))) {//로그아웃상태 or 관리자X
			throw new LoginException("권한이 없습니다.", "../user/userlogin");
		}
		return joinPoint.proceed(); 
	}	

}
