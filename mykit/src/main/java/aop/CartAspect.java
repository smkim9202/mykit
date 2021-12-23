package aop;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import exception.CartException;
import exception.LoginException;
import logic.Cart;
import logic.User;

@Component
@Aspect
public class CartAspect {
	@Around("execution(* controller.Cart*.check*(..)) && args(..,session)")
	public Object cartCheck(ProceedingJoinPoint joinPoint, HttpSession session)throws Throwable{
		User loginUser = (User)session.getAttribute("loginUser");
		if(loginUser==null) {
			throw new LoginException("회원만 주문 가능합니다. 로그인 하세요.", "../user/userlogin");
		}
		Cart cart = (Cart)session.getAttribute("CART");
		//1.session객체에 CART라는 객체가 아예 없는 경우
		//2.CART객체는 있지만 안에 ArrayList 즉 장바구니에 담긴 물건이 없는 경우
		if(cart == null || cart.getItemSetList().size() == 0) { 
			throw new CartException("장바구니에 주문할 상품이 없습니다.", "../item/list");
		}
		return joinPoint.proceed();
	}
	@Around("execution(* controller.Cart*.loginCheck*(..)) && args(..,session)")
	public Object userLoginCheck(ProceedingJoinPoint joinPoint, HttpSession session)throws Throwable{
		User loginUser = (User)session.getAttribute("loginUser"); //로그인 정보 조회
		if(loginUser==null) { //=로그아웃 상태
			throw new LoginException("로그인 후 사용가능합니다!", "../user/userlogin");
		}
		return joinPoint.proceed();
	}
}
