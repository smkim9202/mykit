package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Recipe;

public interface RecipeMapper {

	@Insert("insert into recipeboard "
	+"(rcnum,userid,rctitle,rccontent,rcimg,rcdate,rcreadcnt) "
	+"values (#{rcnum},#{userid},#{rctitle},#{rccontent},"
	+"#{rcimgurl},sysdate,0)")
	void insert(Recipe recipe);

	@Select("select nvl(max(rcnum),0) from recipeboard")
	int maxRcnum();

	
	@Select({"<script>",
		"select count(*) from recipeboard"
		+ "<if test='searchtype != null and searchcontent != null'>"
		+ " where ${searchtype} like '%${searchcontent}%'</if>",
		"</script>"})
	int count(@Param("searchtype") String searchtype, @Param("searchcontent") String searchcontent);

	//좋아요수 추가
	@Select({"<script>",
	    "select * from "
		+ "(select rownum rnum , rcnum, userid, rctitle, rccontent, rcdate, rcimg rcimgurl, rcreadcnt, heartcnt "
	    + "from "
		+ "((select r.RCNUM, r.USERID, r.RCTITLE, r.RCCONTENT, r.RCIMG, r.RCDATE, r.RCREADCNT, nvl(h.heartcnt,0) as HEARTCNT \r\n"
		+ "from recipeboard r, (select rcnum, count(*) as heartcnt from heart group by rcnum) h \r\n"
		+ "where r.rcnum=h.rcnum(+))) "	
		+ "<if test='searchtype != null and searchcontent != null'>"
		+ " where ${searchtype} like '%${searchcontent}%'</if>"	
		+ " order by "
		+ "${sort} desc, rcnum desc"
		+ "  )"
		+ " where rnum >= #{startrow} and rnum &lt;= #{endrow}",
		"</script>"})
	List<Recipe> list(Map<String, Object> param);
	
	//좋아요수 추가
	@Select("select r.RCNUM, r.USERID, r.RCTITLE, r.RCCONTENT, r.RCIMG, r.RCDATE, r.RCREADCNT, nvl(h.heartcnt,0) as HEARTCNT \r\n"
			+ "from recipeboard r, (select rcnum, count(*) as heartcnt from heart group by rcnum) h \r\n"
			+ "where r.rcnum=h.rcnum(+) and r.rcnum=#{value}")
	Recipe selectOne(Integer rcnum);

	@Update("update recipeboard set rcreadcnt = rcreadcnt+1 where rcnum = #{value}")
	void rcreadcntadd(Integer rcnum);

	@Update("update recipeboard set userid=#{userid}, rctitle=#{rctitle}, rccontent=#{rccontent},"
			+ "rcimg=#{rcimgurl} where rcnum=#{rcnum}")
	void update(Recipe recipe);

	@Delete("delete from recipeboard where rcnum=#{value}")
	void delete(int rcnum);


	//----
	@Select("select rcnum from recipeboard where rcnum > 0")
	List<Integer> getItemRcnum();
	
	@Select("select userid from recipeboard where rcnum=#{value}")
	String getID(int rcnum);

	//좋아요
	@Select("select count(*) from heart where rcnum=#{rcnum} and userid like #{userid}")
	int checkHeart(Map<String, Object> param);
	@Insert("insert into heart (rcnum, userid) values (#{rcnum}, #{userid})")
	void addHeart(Map<String, Object> param);
	@Delete("delete from heart where rcnum=#{rcnum} and userid=#{userid}")
	void minusHeart(Map<String, Object> param);





}
