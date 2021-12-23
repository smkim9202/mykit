package logic;



import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import dao.BoardDao;
import dao.ItemDao;
import dao.SaleDao;
import dao.SaleitemDao;
import dao.UserDao;
import dao.RecipeDao;
import dao.ReviewDao;


@Service
public class ShopService {
	@Autowired
	UserDao userDao;
	@Autowired
	ItemDao itemDao;
	@Autowired
	BoardDao boardDao;
	@Autowired
	SaleDao saleDao;
	@Autowired
	SaleitemDao saleitemDao;
	@Autowired
	ReviewDao reviewDao;
	@Autowired
	RecipeDao recipeDao;

	//----review
		public void reviewrite(Review review) {
			reviewDao.write(review);
		}
		public List<Review> reviewList(String id) {
			return reviewDao.list(id);
		}
		public void reviewUpdate(Review review, HttpServletRequest request) {
			reviewDao.update(review);
		}
		public Review getReview(Integer num) {
			return reviewDao.selectOne(num);
		}
		public void reviewDelete(int num) {
			reviewDao.delete(num);
		}
		public List<Review> reviewItemList(String id) {
			return reviewDao.reviewlist(id);
		}
		public double avgReview(String id) {
			return reviewDao.avgReview(id);
		}


	//----user
	public void userInsert(User user) {
		userDao.insert(user);
	}
	public String idcheck(String id) {
		return userDao.idcheck(id);
	}
	public User userSelectOne(String userid) {
		return userDao.selectOne(userid);
	}
	public String getSearch(User user, String url) {
		return userDao.search(user, url);
	}
	public String find(User user, String url) {
		return userDao.find(user, url);
	}
	public void userUpdate(User user) {
		userDao.update(user);
	}
	public void userPassword(String userid, String chgpass) {
		userDao.passwordupdate(userid, chgpass);
	}
	public void userDelete(String userid) {
		userDao.delete(userid);
	}
	
	//----admin
	public List<User> userList() {
		return userDao.list();
	}
	public List<User> userList(String[] idchks) {
		return userDao.list(idchks);
	}
	
	//----item
	public void itemCreate(Item item, HttpServletRequest request) {
		item.setItemimg(""); //빈 문자열 넣음으로써 사진없이 등록 가능
		if (item.getPictureimg() != null && !item.getPictureimg().isEmpty()) {// 업로드된 파일이 존재하면
			uploadFileCreate(item.getPictureimg(), request, "imgitem/");// 파일로 저장
			item.setItemimg(item.getPictureimg().getOriginalFilename());// 업로드된 파일의 이름
		}
		item.setDescription("");
		if (item.getPicturedes() != null && !item.getPicturedes().isEmpty()) {
			uploadFileCreate(item.getPicturedes(), request, "imgitem/");
			item.setDescription(item.getPicturedes().getOriginalFilename());
		}
		int maxid = itemDao.maxNo();
		item.setItemid(maxid+1);
		itemDao.insert(item);
	}
	private void uploadFileCreate(MultipartFile file, HttpServletRequest request, String upath) {
		String orgFile = file.getOriginalFilename(); //업로드된 파일의 실제 파일명
		//파일 업로드 위치
		//request.getServletContext().getRealPath("/"): 실제 웹어플리케이션 서버의 폴더 위치
		String uploadPath = request.getServletContext().getRealPath("/") + upath;//서버단에서 파일이 업로드되는 위치
		File fpath = new File(uploadPath);
		//fpath: 파일 업로드 위치정보를 저장하고있는 File클래스의 객체
		//fpath.exists(): 폴더가 존재하나? 존재하면:true, 없으면:false
		if(!fpath.exists()) fpath.mkdirs(); //폴더를 생성하라: 파일 업로드시 폴더가 없으면 오류발생
		try {
			file.transferTo(new File(uploadPath + orgFile)); //서버에 업로드된 파일을 저장.
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	public List<Item> itemList(String itype, String userpick) {
		return itemDao.list(itype, userpick);
	}
	public Item getItem(Integer itemid) {
		return itemDao.selectOne(itemid);
	}
	public void itemUpdate(Item item, HttpServletRequest request) {
		if (item.getPictureimg() != null && !item.getPictureimg().isEmpty()) {// 업로드된 파일이 존재하면
			uploadFileCreate(item.getPictureimg(), request, "imgitem/");// 파일로 저장
			item.setItemimg(item.getPictureimg().getOriginalFilename());// 업로드된 파일의 이름
		}
		if (item.getPicturedes() != null && !item.getPicturedes().isEmpty()) {// 업로드된 파일이 존재하면
			uploadFileCreate(item.getPicturedes(), request, "imgitem/");// 파일로 저장
			item.setDescription(item.getPicturedes().getOriginalFilename());// 업로드된 파일의 이름
		}
		itemDao.update(item);
	}
	public void itemDelete(String id) {
		itemDao.delete(id);
	}
	public Integer getStock(Integer itemid) {
		return itemDao.getStock(itemid);
	}
	public Sale checkend(User loginUser, Cart cart) {
		// 1.sale 테이블의 saleid의 최대값 조회: 최대값+1
		int maxid = saleDao.getMaxSaleId();
		// 2.sale 정보 저장: userid, sysdate
		Sale sale = new Sale();
		sale.setSaleid(maxid + 1); // 최대값 + 1
		sale.setUser(loginUser); // 주문 고객 정보
		sale.setUserid(loginUser.getUserid());
		saleDao.insert(sale);
		// 3.Cart 데이터에서 saleitem 데이터 추출. insert
		int seq = 0;
		for (ItemSet iset : cart.getItemSetList()) {
			SaleItem saleItem = new SaleItem(sale.getSaleid(), ++seq, iset);
			// 4.saleitem 정보를 sale데이터 저장
			sale.getItemList().add(saleItem);
			saleitemDao.insert(saleItem);
		}
		// 5.sale 데이터 리턴
		return sale;
	}
	public void reStock(int itemid, int i) {
		itemDao.reStock(itemid, i);
	}
	public List<Sale> salelist(String id) {
		List<Sale> list = saleDao.list(id); //현재 내가 주문한 목록들(세일 아이템)
		for (Sale s1 : list) {//(세일아이템에서 하나씩 꺼냄)
			List<SaleItem> saleitemlist = saleitemDao.list(s1.getSaleid());
			for(SaleItem s2 : saleitemlist) {//해당되는 아이템들 하나씩 출력
				Item item = itemDao.selectOne(s2.getItemid());
				s2.setItem(item);
			}
			s1.setItemList(saleitemlist);
		}
		return list;
	}
	public int getUserPoint(String userid) {
		if(saleDao.getUserPoint(userid)==null) {
			return 1000;
		}
		return saleDao.getUserPoint(userid).intValue();
	}
	public void updateUserPoint(String userid, int rpoint) {
		saleDao.updateUserPoint(userid, rpoint);
	}
	public void saleAmount(long total, int i) {
		saleDao.saleAmount(total, i);
	}
	


//--Board-----
	public void boardqawrite(Board board, HttpServletRequest request) {
		if(board.getMyfile() != null && !board.getMyfile().isEmpty()) { //업로드된 파일이 존재하면
			uploadFileCreate(board.getMyfile(),request,"board/file");  //파일로 저장
			board.setFileurl(board.getMyfile().getOriginalFilename()); //업로드된 파일의 이름
		}
		boardDao.qawrite(board);
	}
	
	public void boardevwrite(Board board, HttpServletRequest request) {
		if(board.getMyfile() != null && !board.getMyfile().isEmpty()) { //업로드된 파일이 존재하면
			uploadFileCreate(board.getMyfile(),request,"board/file");  //파일로 저장
			board.setFileurl(board.getMyfile().getOriginalFilename()); //업로드된 파일의 이름
		}
		boardDao.evwrite(board);
	}
/* Item에서의 기능과 중복되는 코드
	private void uploadFileCreate(MultipartFile file, HttpServletRequest request,String upath) {
		String orgFile = file.getOriginalFilename(); //업로드된 파일의 실제 파일 명.
		String uploadPath = request.getServletContext().getRealPath("/") + upath;
		File fpath = new File(uploadPath); 
		if(!fpath.exists()) fpath.mkdirs(); //폴더 생성. 파일 업로드시 폴더가 없으면 오류발생.
		try {
			file.transferTo(new File(uploadPath + orgFile)); //서버에 업로드된 파일을 저장.
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
*/
	public int boardcount(String searchtype, String searchcontent, int boardtype) {
		return boardDao.count(searchtype,searchcontent,boardtype);
	}
	public List<Board> boardlist(Integer pageNum, int limit, String searchtype, String searchcontent, int boardtype) {
		return boardDao.list(pageNum,limit,searchtype,searchcontent,boardtype);
	}
	public Board getBoard(Integer num) {
		return boardDao.selectOne(num);
	}
	public void boardUpdate(@Valid Board board, HttpServletRequest request) {
		if(board.getMyfile() != null && !board.getMyfile().isEmpty()) { //업로드된 파일이 존재하면
			uploadFileCreate(board.getMyfile(),request,"board/file/");               //파일로 저장
			board.setFileurl(board.getMyfile().getOriginalFilename()); //업로드된 파일의 이름
		}
		boardDao.update(board);
	}

	//원글삭제시 답글까지 삭제
	public void orgboardDelete(int grpnum) {
		boardDao.orgdelete(grpnum);
	}
	//답글삭제시 답글만 삭제
	public void reboardDelete(int num) {
		boardDao.redelete(num);
		
	}
	
	public void boardReply(Board board) {
		boardDao.qareply(board);	
	}
	
	//답변등록완료전 원글삭제시 답변등록 불가
	public int boardcheckgrpnum(int grpnum) {
		return boardDao.checkgrpnum(grpnum);
		
	}
	
//--Recipe-----

	public void rcwrite(Recipe recipe, HttpServletRequest request) {
		if(recipe.getRcimg() != null && !recipe.getRcimg().isEmpty()) { //업로드된 파일이 존재하면
			uploadFileCreate(recipe.getRcimg(),request,"recipe/file/");   //파일로 저장
			recipe.setRcimgurl(recipe.getRcimg().getOriginalFilename()); //업로드된 파일의 이름
		}
		recipeDao.rcwrite(recipe);
	}
	public int recipeCount(String searchtype, String searchcontent) {
		return recipeDao.count(searchtype,searchcontent);
	}
	public List<Recipe> recipelist(Integer pageNum, int limit, String searchtype, String searchcontent, String sort) {
		return recipeDao.list(pageNum,limit,searchtype,searchcontent,sort);
	}

	public Recipe getRecipe(Integer rcnum) {
		return recipeDao.selectOne(rcnum);
	}
	public void rcreadcntadd(Integer rcnum) {
		recipeDao.rcreadcntadd(rcnum);
		
	}
	public void recipeUpdate(Recipe recipe, HttpServletRequest request) {
		if(recipe.getRcimg() != null && !recipe.getRcimg().isEmpty()) { //업로드된 파일이 존재하면
			uploadFileCreate(recipe.getRcimg(),request,"recipe/file/");  //파일로 저장
			recipe.setRcimgurl(recipe.getRcimg().getOriginalFilename()); //업로드된 파일의 이름
		}
		recipeDao.rcupdate(recipe);
		
	}
	public void recipeDelete(int rcnum) {
		recipeDao.rcdelete(rcnum);
		
	}
	//레시피게시판 포인트증정 : 작성자 id로 현재포인트 얻어오기
	public int selectRpoint(String recipeuserid) {
		return saleDao.selectRpoint(recipeuserid);
	}
	
	//레시피게시판 포인트증정 : 현재포인트+추가포인트 = 총포인트 업데이트
	public void addRcpoint(int totalPoint, String recipeuserid) {
		saleDao.addRcpoint(totalPoint,recipeuserid);
		
	}
	//---추가
	public List<Integer> getItemRcnum() {
		return recipeDao.getItemRcnum();
		}
	public String getID(int rcnum) {
		return recipeDao.getID(rcnum);
		}
	public void pointToUser(String getuserID) {
		saleDao.pointTouser(getuserID);
		}
	//좋아요
	public int checkheart(Integer rcnum, String userid) {
		return recipeDao.checkheart(rcnum,userid);		
	}
	public void addHeart(int rcnum, String userid) {
		recipeDao.addHeart(rcnum,userid);		
	}
	public void minusHeart(int rcnum, String userid) {
		recipeDao.minusHeart(rcnum,userid);	
	}



}



		

