package controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import exception.CartException;
import logic.Cart;
import logic.Item;
import logic.ItemSet;
import logic.Sale;
import logic.ShopService;
import logic.User;

@Controller
@RequestMapping("cart")
public class CartController {
	@Autowired
	private ShopService service;
	
	//[1.장바구니 담기]
	@RequestMapping("cartAdd")
	public ModelAndView loginCheckadd(Integer itemid, Integer quantity, HttpSession session) {
		ModelAndView mav = new ModelAndView("cart/cart");
		// 1.id에 해당하는 Item 데이터를 저장
		Item item = service.getItem(itemid);
		// 2.session에 저장된 Cart객체를 조회
		Cart cart = (Cart) session.getAttribute("CART");
		if (cart == null) {// 해당 session의 장바구니에 담긴 것이 없으면
			cart = new Cart();
			session.setAttribute("CART", cart); // session에 등록
		}
		// 3.재고보다 많이 담을 수 없음
		Integer stock = service.getStock(itemid);
		if(stock < quantity) {
			throw new CartException("해당 상품의 현재 재고는 " + stock + "입니다!", "../item/detail?id="+itemid);
		}else {
			cart.push(new ItemSet(item, quantity));
			mav.addObject("message", item.getItemname() + ":" + quantity + "개 장바구니 추가");
			mav.addObject("cart", cart);
		}
		// 4.포인트 저장
		User loginUser = (User)session.getAttribute("loginUser");
		int userpoint = service.getUserPoint(loginUser.getUserid());
		mav.addObject("userpoint", userpoint);
		return mav;
	}

	//[2.장바구니 상품 삭제]
	@RequestMapping("cartDelete")
	public ModelAndView loginCheckdelete(int index, HttpSession session) {
		ModelAndView mav = new ModelAndView("cart/cart");
		Cart cart = (Cart) session.getAttribute("CART"); // session에 저장된 Cart객체를 조회
		ItemSet del = cart.getItemSetList().remove(index); // 아이템 삭제
		User loginUser = (User)session.getAttribute("loginUser");
		int userpoint = service.getUserPoint(loginUser.getUserid());
		mav.addObject("userpoint", userpoint);
		mav.addObject("message", "장바구니에서 " + del.getItem().getItemname() + " 삭제됨");
		mav.addObject("cart", cart);
		return mav;
	}

	//[3.장바구니 목록보기]
	@RequestMapping("cartView")
	public ModelAndView loginCheckview(HttpSession session) {
		ModelAndView mav = new ModelAndView("cart/cart");
		Cart cart = (Cart) session.getAttribute("CART");
		User loginUser = (User)session.getAttribute("loginUser");
		int userpoint = service.getUserPoint(loginUser.getUserid());
		mav.addObject("userpoint", userpoint);
		mav.addObject("cart", cart);
		return mav;
	}

	//[4.구매 전 확인] + 포인트 사용
	@RequestMapping("checkout")
	public ModelAndView checkout(int usepoint, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Cart cart = (Cart) session.getAttribute("CART");
		User loginUser = (User)session.getAttribute("loginUser");
		int num = 0;
		ItemSet stock;
		for(int i = 0; i < cart.getItemSetList().size(); i++) {
			stock = cart.getItemSetList().get(i);
			num = cart.getItemSetList().get(i).getItem().getStock();
			if(num < stock.getQuantity()) {
				throw new CartException(stock.getItem().getItemname() + "의 현재 재고는 " + num 
						+ "입니다! 재고 확인 후 다시 담아주세요.", "cartView");
			}
			System.out.println("["+i+"] "+"재고: "+num+", 장바구니 담은 수: "+stock.getQuantity());
		}
		int rpoint = service.getUserPoint(loginUser.getUserid()); //해당 회원의 현재 포인트
		if(rpoint < usepoint) {
			throw new CartException("현재 회원님의 포인트는 " + rpoint +"입니다! 그 이상 사용하실 수 없습니다.", "cartView");
		}
		mav.addObject("usepoint", usepoint);
		mav.addObject("cart", cart);
		return mav;
	}

	//[5.주문 확정]
	@RequestMapping("end")
	public ModelAndView checkend(int usepoint, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Cart cart = (Cart) session.getAttribute("CART"); // 장바구니 세션 정보
		User loginUser = (User) session.getAttribute("loginUser"); // 로그인 세션 정보
		//포인트
		int rpoint = service.getUserPoint(loginUser.getUserid()); //해당 회원의 현재 포인트
		if(rpoint < usepoint) {
			throw new CartException("현재 회원님의 포인트는 " + rpoint +"입니다! 그 이상 사용하실 수 없습니다.", "cartView");
		}
		rpoint -= usepoint; //현재 포인트 - 사용 포인트
		Sale sale = service.checkend(loginUser, cart);
		service.updateUserPoint(loginUser.getUserid(), rpoint); //해당 회원 포인트 update
		System.out.println("사용 포인트: " + usepoint);
		System.out.println("현재 포인트: " + rpoint);
		sale.setUsepoint(usepoint);
		service.saleAmount(sale.getTotal(), sale.getSaleid()); //총 금액
		//재고에서 구매물량 빼기
		int num = 0;
		ItemSet stock;
		int result = cart.getItemSetList().size();
		System.out.println("장바구니에 담은 상품 종류 개수: " + cart.getItemSetList().size());
		for(int i = 0; i < result; i++) {
			stock = cart.getItemSetList().get(i);
			num = stock.getItem().getStock();
			System.out.println("[" +i+"] " + stock.getItem().getItemname() + " " + num + " - " + stock.getQuantity() 
					+ " = " + (num - stock.getQuantity()) + "개");
			service.reStock(stock.getItem().getItemid(), num - stock.getQuantity());
		}
		//주문 후 장바구니 비우기
		cart.getItemSetList().clear();
		mav.addObject("sale", sale);
		return mav;
	}
}
