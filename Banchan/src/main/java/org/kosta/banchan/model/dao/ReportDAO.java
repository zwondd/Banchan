package org.kosta.banchan.model.dao;

import java.util.List;

import org.kosta.banchan.model.vo.ReportVO;

public interface ReportDAO {

	int isKeywordExistInReportTable(String kw);

	void insertKeyword(ReportVO rvo);

	void updateKeyword(String kw);

	List<ReportVO> getReport();

}