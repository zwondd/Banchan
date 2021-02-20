package org.kosta.banchan.model.service;

import java.util.List;

import org.kosta.banchan.model.vo.ReportVO;

public interface ReportService {

	int isKeywordExistInReportTable(String kw);

	void insertKeyword(ReportVO reportVO);

	void updateKeyword(String kw);

	List<ReportVO> getReport();

}