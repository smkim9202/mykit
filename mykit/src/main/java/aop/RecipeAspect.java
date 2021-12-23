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
public class RecipeAspect {
	//rcwrite(rc글쓰기) url로 접속 => 비회원 일 경우 사용 불가(logout 상태 사용 불가)
	@Around("execution(* controller.Recipe*.getRcwrite(..)) && args(..,session)")
	public Object rcwriteLoginCheck(ProceedingJoinPoint joinPoint,HttpSession session)	throws Throwable{
		User loginUser = (User)session.getAttribute("loginUser"); //로그인 정보 조회
		if(loginUser==null) {//로그아웃상태
			throw new LoginException("회원만 작성 가능합니다. 로그인 후 이용하세요.", "../user/userlogin");
		}
		return joinPoint.proceed(); //다음 메서드(핵심메서드)를 호출.
	}
}
