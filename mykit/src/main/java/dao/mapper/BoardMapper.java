package dao.mapper;

import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Board;

public interface BoardMapper {
	
	@Insert("insert into board "
	+"(num,userid,btype,title,content,regdate,myfile,boardlock,grpnum) "
	+"values (#{num},#{userid},#{btype},#{title},#{content},sysdate,"
	+"#{fileurl,jdbcType=VARCHAR},#{boardlock},#{grpnum})")
	void insert(Board board);

	@Select("select nvl(max(num),0) from board")
	int maxnum();

	@Select({"<script>",
		"select count(*) from board"
		+" where btype = ${boardtype} ",
		"<if test='searchtype != null and searchcontent != null'>"
		+ " and ${searchtype} like '%${searchcontent}%'</if>",
		"</script>"})
	int count(@Param("searchtype") String searchtype, @Param("searchcontent") String searchcontent, @Param("boardtype") int boardtype);

	@Select({"<script>",
		    "select * from "
			+ "(select rownum rnum , num, userid, title, content, regdate, myfile fileurl,"
			+ " grpnum, btype, boardlock from "
			+ "(select * from board "
			+ " where btype = ${boardtype} "			
			+ "<if test='searchtype != null and searchcontent != null'>"
			+ " and ${searchtype} like '%${searchcontent}%'</if>"			
			+ " order by grpnum desc, regdate asc ))"
			+ " where rnum >= #{startrow} and rnum &lt;= #{endrow}",
			"</script>"})
	List<Board> list(Map<String, Object> param);
		
	@Select("select num, userid, title, content, regdate, myfile fileurl, "
			+ "boardlock, grpnum from board where num=#{value}")
	Board selectOne(Integer num);

	@Update("update board set userid=#{userid}, title=#{title}, content=#{content},"
			+ "myfile=#{fileurl} where num=#{num}")
	void update(@Valid Board board);
	
	@Delete("delete from board where grpnum=#{value}")
	void orgdelete(int grpnum);
	
	@Delete("delete from board where num=#{value}")
	void redelete(int num);

	@Select("select count(*) from board where num=#{grpnum}")
	int checkgrpnum(int grpnum);







}
