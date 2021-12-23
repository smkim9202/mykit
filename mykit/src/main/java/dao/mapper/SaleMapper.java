package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Sale;

public interface SaleMapper {

	@Select("select nvl(max(saleid), 0) from sale")
	int maxsaleid();
	
	@Insert("insert into sale (saleid, userid, saledate) values (#{saleid}, #{userid}, sysdate)")
	void insert(Sale sale);

	@Select("select * from sale where userid=#{value} order by saleid desc")
	List<Sale> select(String userid);

	@Select("select rpoint from sale where userid=#{value} and rownum=1")
	Integer getUserPoint(String userid);

	@Update("update sale set rpoint=#{rpoint} where userid=#{userid}")
	void updateUserPoint(Map<String, Object> param);

	@Update("update sale set saleamount=#{saleamount} where saleid=#{saleid}")
	void saleAmount(Map<String, Object> param);

	@Update("update sale set rpoint=rpoint+1000 where userid=#{value}")
	void pointTouser(String getuserID);

	//레시피보드 포인트 추가 2개.
	@Select("select rpoint from sale where userid like #{recipuserid} and rownum=1")
	int selectRpoint(String recipeuserid);

	@Update("update sale set rpoint=#{rpoint} where userid=#{userid}")
	void addRcpoint(Map<String, Object> param);
}
