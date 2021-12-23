package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import exception.ItemException;
import logic.Item;
import logic.ShopService;

@Controller
@RequestMapping("item")
public class ItemController {
	@Autowired
	private ShopService service;
	
	//[1.상품 목록] - 분류, 추천/당선
	@RequestMapping("list") //Get, Post 둘다
	public ModelAndView list(String itype, String userpick) {
		ModelAndView mav = new ModelAndView();
		List<Item> itemlist = service.itemList(itype, userpick);
		mav.addObject("itemList", itemlist); //jsp에서 itemList로 가져오기 때문에 이름 같아야함(내가 틀린 부분)
		return mav;
	}
	
	//[2.상품 등록] - adminCheck:관리자만
	@RequestMapping("create")
	public ModelAndView adminCheckadd(HttpSession session) {
		ModelAndView mav = new ModelAndView("item/add");
		List<Integer> getUserItem = service.getItemRcnum();
		mav.addObject("getUserItem", getUserItem);
		mav.addObject(new Item());
		return mav;
	}
	@RequestMapping("register")
	public ModelAndView adminCheckadd(@Valid Item item, BindingResult bresult, HttpServletRequest request, HttpSession session) {
		ModelAndView mav = new ModelAndView("item/add"); //입력값 오류 발생시 화면
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		List<Integer> getUserItem = service.getItemRcnum();
		mav.addObject("getUserItem", getUserItem);
		//item 테이블에 insert, picture 업로드파일을 파일로 생성
		service.itemCreate(item, request);
		String getuserID = service.getID(item.getRcnum()); //rcnum -> 아이디(레시피보드)
		service.pointToUser(getuserID); //아이디 -> rpoint plus(sale)
		mav.setViewName("redirect:list");
		return mav;
	}
	
	//[3-1.상품 상세보기]
	@RequestMapping("detail")
	public ModelAndView detail(Integer id) {
		ModelAndView mav = new ModelAndView();
		Item item = service.getItem(id);
		mav.addObject("item", item);
		return mav;
	}
	
	//[3-2.상품 상세보기] - 관리자(수정, 삭제확인)
	@RequestMapping({"edit", "confirm"})
	public ModelAndView adminCheckdetail(Integer id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Item item = service.getItem(id);
		List<Integer> getUserItem = service.getItemRcnum();
		mav.addObject("getUserItem", getUserItem);
		mav.addObject("item", item);
		return mav;
	}
	
	//[4.상품 수정] - 관리자
	@RequestMapping("update")
	public ModelAndView adminCheckupdate(@Valid Item item, BindingResult bresult, 
		HttpServletRequest request, HttpSession session) {
		ModelAndView mav = new ModelAndView("item/edit");
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		List<Integer> getUserItem = service.getItemRcnum();
		mav.addObject("getUserItem", getUserItem);
		service.itemUpdate(item, request);
		//3.등록성공후 list로 페이지 이동
		mav.setViewName("redirect:list");
		return mav;
	}
	
	//[5.상품삭제] - 관리자
	@RequestMapping("delete")
	public String adminCheckdelete(String id){
		try {
			service.itemDelete(id);
		}catch(DataIntegrityViolationException e) {
			e.printStackTrace();
			throw new ItemException("주문된 상품이 존재합니다. 주문 상품 삭제 후에 삭제 가능합니다.", "list");
		}
		return "redirect:list";
	}
}
