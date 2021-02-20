package org.kosta.banchan.model.dao;

import java.util.List;

import javax.annotation.Resource;

import org.kosta.banchan.model.vo.ReportVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
@Repository
public class ReportDAOImpl implements ReportDAO {
	@Resource
	private SqlSessionTemplate template;
	@Override
	public int isKeywordExistInReportTable(String kw){ //report테이블에 존재하는지 검사
		return template.selectOne("report.isKeywordExistInReportTable",kw);
	}
	@Override
	public void insertKeyword(ReportVO rvo) { //report테이블에 없으면 insert
		template.insert("report.insertKeyword",rvo);
	}
	@Override
	public void updateKeyword(String kw) { //report테이블에 존재하면 조회수 증가
		template.update("report.updateKeyword",kw);
	}
	@Override
	public List<ReportVO> getReport(){ //top5 select
		return template.selectList("report.getReport");
	}
}
