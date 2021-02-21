package org.kosta.banchan.model.service;

import java.util.List;

import javax.annotation.Resource;

import org.kosta.banchan.model.dao.ReportDAO;
import org.kosta.banchan.model.vo.ReportVO;
import org.springframework.stereotype.Service;

@Service
public class ReportServiceImpl implements ReportService {
	@Resource
	private ReportDAO reportDAO;
	@Override
	public int isKeywordExistInReportTable(String kw) {
		return reportDAO.isKeywordExistInReportTable(kw);
	}
	@Override
	public void insertKeyword(ReportVO rvo) {
		reportDAO.insertKeyword(rvo);
		
	}
	@Override
	public void updateKeyword(String kw) {
		reportDAO.updateKeyword(kw);
	}
	@Override
	public List<ReportVO> getReport(){
		return reportDAO.getReport();
	}
}
