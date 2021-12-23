package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.BoardMapper;
import logic.Board;

@Repository
public class BoardDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String,Object> param = new HashMap<String,Object>();
	
	public void qawrite(Board board) {
		int num = maxNum() + 1; 
		board.setNum(num); //게시글번호
		board.setGrpnum(num);
		board.setBtype(0);//qa게시판타입 0
		System.out.println("QA작성후:"+board);
		template.getMapper(BoardMapper.class).insert(board);
	}
	
	public void evwrite(Board board) {
		int num = maxNum() + 1; 
		board.setNum(num); //게시글번호
		board.setGrpnum(num);
		board.setBtype(1);//공이게시판타입 1
		board.setBoardlock("bdunlock");//공이게시판은 무조건 공개글
		
		board.setUserid("admin");//우선은 관리자계정으로 글쓰기
		System.out.println("공이작성후:"+board);
		template.getMapper(BoardMapper.class).insert(board);
	}

	private int maxNum() {
		return template.getMapper(BoardMapper.class).maxnum();
	}

	public int count(String searchtype, String searchcontent, int boardtype) {
		return template.getMapper(BoardMapper.class).count(searchtype,searchcontent,boardtype);
	}

	public List<Board> list(Integer pageNum, int limit, String searchtype, String searchcontent, int boardtype) {
		param.clear();
		int startrow = (pageNum - 1) * limit + 1;
		int endrow = startrow + limit - 1;
		param.put("startrow", startrow);
		param.put("endrow", endrow);
		param.put("boardtype", boardtype);
		if(searchtype != null && searchcontent != null) {
			param.put("searchtype", searchtype);
			param.put("searchcontent", searchcontent);
		}
		return template.getMapper(BoardMapper.class).list(param);
	}

	public Board selectOne(Integer num) {
		return template.getMapper(BoardMapper.class).selectOne(num);
	}

	public void update(Board board) {
		template.getMapper(BoardMapper.class).update(board);	
	}

	public void orgdelete(int grpnum) {
		System.out.println("grpnum:"+grpnum);
		template.getMapper(BoardMapper.class).orgdelete(grpnum);
		
	}
	public void redelete(int num) {
		System.out.println("num:"+num);
		template.getMapper(BoardMapper.class).redelete(num);
	}

	public void qareply(Board board) {
		board.setNum(maxNum() + 1);
		template.getMapper(BoardMapper.class).insert(board);
	}
	//답변등록완료전 원글삭제시 답변등록 불가
	public int checkgrpnum(int grpnum) {
		return template.getMapper(BoardMapper.class).checkgrpnum(grpnum);
		
	}










}
