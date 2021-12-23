package aop;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import exception.ItemException;
import exception.LoginException;
import logic.User;

@Component	//객체화되는 클래스
@Aspect
public class UserLoginAspect {
	@Around("execution(* controller.User*.loginCheck*(..)) && args(..,session)")
	public Object userLoginCheck(ProceedingJoinPoint joinPoint, HttpSession session)throws Throwable{
		User loginUser = (User)session.getAttribute("loginUser"); //로그인 정보 조회
		if(loginUser==null) { //=로그아웃 상태
			throw new LoginException("로그인 후 사용가능합니다!", "userlogin");
		}
		return joinPoint.proceed();
	}
	@Around("execution(* controller.User*.idCheck*(..)) && args(id,session,..)")
	public Object userIdCheck(ProceedingJoinPoint joinPoint, String id, HttpSession session)throws Throwable{
		User loginUser = (User)session.getAttribute("loginUser"); //로그인 정보 조회
		if(loginUser==null) { //=로그아웃 상태
			throw new LoginException("로그인 후 거래하세요.", "userlogin");
		}else if(!loginUser.getUserid().equals(id) && !loginUser.getUserid().equals("admin")) {
			throw new LoginException("본인 정보만 거래가능합니다.", "main");
		}
		return joinPoint.proceed();
	}
	@Around("execution(* controller.Item*.adminCheck*(..)) && args(..,session)")
	public Object adminCheck(ProceedingJoinPoint joinPoint, HttpSession session)throws Throwable{
		User loginUser = (User)session.getAttribute("loginUser"); //세션에서 로그인 정보 가져오기
		if(loginUser==null) { //=로그아웃 상태
			throw new LoginException("로그인 후 거래하세요.", "../user/userlogin");
		}else if(!loginUser.getUserid().equals("admin")) {
			throw new LoginException("관리자만 거래가능합니다.", "../user/main");
		}
		return joinPoint.proceed();
	}
	@Around("execution(* controller.Admin*.*(..)) && args(..,session)")
	public Object admin(ProceedingJoinPoint joinPoint, HttpSession session)throws Throwable{
		User loginUser = (User)session.getAttribute("loginUser"); //세션에서 로그인 정보 가져오기
		if(loginUser==null || !loginUser.getUserid().equals("admin")) {
			throw new LoginException("관리자만 거래가능합니다.", "../user/main");
		}
		return joinPoint.proceed();
	}
	@Around("execution(* controller.Review*.iditck*(..)) && args(..,userid,itemid,session)")
	public Object userIdItCk(ProceedingJoinPoint joinPoint, String userid, Integer itemid, HttpSession session)throws Throwable{
		User loginUser = (User)session.getAttribute("loginUser"); //로그인 정보 조회
		if(loginUser==null) { //=로그아웃 상태
			throw new LoginException("로그인 후 거래하세요.", "../user/userlogin");
		}else if(!loginUser.getUserid().equals(userid) && !loginUser.getUserid().equals("admin")) {
			
			throw new LoginException("본인 정보만 거래가능합니다.", "../user/main");
		}
		if(itemid==null) {
			throw new ItemException("상품을 선택해주세요!", "../user/myitemlist?id="+loginUser.getUserid());
		}
		return joinPoint.proceed();
	}
	@Around("execution(* controller.Review*.idck*(..)) && args(id,session,..)")
	public Object userIdCk(ProceedingJoinPoint joinPoint, String id, HttpSession session)throws Throwable{
		User loginUser = (User)session.getAttribute("loginUser"); //로그인 정보 조회
		if(loginUser==null) { //=로그아웃 상태
			throw new LoginException("로그인 후 거래하세요.", "../user/userlogin");
		}else if(!loginUser.getUserid().equals(id) && !loginUser.getUserid().equals("admin")) {
			throw new LoginException("본인 정보만 거래가능합니다.", "../user/main");
		}
		return joinPoint.proceed();
	}
	@Around("execution(* controller.Review*.idnumck*(..)) && args(..,id,num,session)")
	public Object idNumCk(ProceedingJoinPoint joinPoint, String id, Integer num, HttpSession session)throws Throwable{
		User loginUser = (User)session.getAttribute("loginUser"); //로그인 정보 조회
		if(loginUser==null) { //=로그아웃 상태
			throw new LoginException("로그인 후 거래하세요.", "../user/userlogin");
		}else if(!loginUser.getUserid().equals(id) && !loginUser.getUserid().equals("admin")) {
			
			throw new LoginException("**본인 정보만 거래가능합니다.", "../user/main");
		}
		if(num==null) {
			throw new ItemException("리뷰를 선택해주세요!", "list?id="+loginUser.getUserid());
		}
		return joinPoint.proceed();
	}
}
