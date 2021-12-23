package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.RecipeMapper;
import logic.Recipe;

@Repository
public class RecipeDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String,Object> param = new HashMap<String,Object>();

	public void rcwrite(Recipe recipe) {
		int rcnum = maxRcnum() + 1; 
		recipe.setRcnum(rcnum); //게시글번호
		System.out.println("레시피작성후:"+recipe);
		template.getMapper(RecipeMapper.class).insert(recipe);
		
	}

	private int maxRcnum() {
		return template.getMapper(RecipeMapper.class).maxRcnum();
	}

	public int count(String searchtype, String searchcontent) {
		return template.getMapper(RecipeMapper.class).count(searchtype,searchcontent);

	}

	public List<Recipe> list(Integer pageNum, int limit, String searchtype, String searchcontent, String sort) {
		param.clear();
		int startrow = (pageNum - 1) * limit + 1;
		int endrow = startrow + limit - 1;
		param.put("startrow", startrow);
		param.put("endrow", endrow);
		if(searchtype != null && searchcontent != null) {
			param.put("searchtype", searchtype);
			param.put("searchcontent", searchcontent);
		}
		if(sort.equals("recent"))
			param.put("sort", "rcdate");
		else if(sort.equals("hits"))
			param.put("sort", "rcreadcnt");
		else if(sort.equals("heart"))
			param.put("sort", "heartcnt");
		return template.getMapper(RecipeMapper.class).list(param);
	}


	public Recipe selectOne(Integer rcnum) {
		return template.getMapper(RecipeMapper.class).selectOne(rcnum);
	}

	public void rcreadcntadd(Integer rcnum) {//조회건수 증가
		template.getMapper(RecipeMapper.class).rcreadcntadd(rcnum);
		
	}

	public void rcupdate(Recipe recipe) {
		template.getMapper(RecipeMapper.class).update(recipe);
		
	}

	public void rcdelete(int rcnum) {
		template.getMapper(RecipeMapper.class).delete(rcnum);		
	}

	//----
	public List<Integer> getItemRcnum() {
		return template.getMapper(RecipeMapper.class).getItemRcnum();
	}
	public String getID(int rcnum) {
		return template.getMapper(RecipeMapper.class).getID(rcnum);
	}
	//좋아요
	public int checkheart(Integer rcnum, String userid) {
		param.clear();
		param.put("rcnum", rcnum);
		param.put("userid", userid);
		return template.getMapper(RecipeMapper.class).checkHeart(param);
	}

	public void addHeart(int rcnum, String userid) {
		param.clear();
		param.put("rcnum", rcnum);
		param.put("userid", userid);
		template.getMapper(RecipeMapper.class).addHeart(param);
	}

	public void minusHeart(int rcnum, String userid) {
		param.clear();
		param.put("rcnum", rcnum);
		param.put("userid", userid);
		template.getMapper(RecipeMapper.class).minusHeart(param);
	}





	
}
