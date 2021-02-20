package org.kosta.banchan.model.aop;

import java.util.List;

import javax.annotation.Resource;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.kosta.banchan.model.service.ReportService;
import org.kosta.banchan.model.vo.ReportVO;
import org.springframework.stereotype.Component;

/*
 * 공통 관심 사항을 정의
 */
@Component // spring container에게 객체생성하라고 명시
@Aspect // aop 객체임을 명시한다!!
//reportService주입받는다
public class ReportAspect {
	@Resource
	private ReportService reportService;
	@Around("execution(public * org.kosta.banchan.model.service.*Service.find*List(..))")
	public Object report(ProceedingJoinPoint point) throws Throwable {
		Object retValue = null;
		try {
			retValue = point.proceed(); // 실제 대상 메서드를 실행
		} finally {
			if(retValue!=null && retValue instanceof List && !((List)retValue).isEmpty()) {
				//검색어 추출
				Object params[] = point.getArgs(); //실제 대상 메서드의 매개변수에 할당되는 인자값(검색어)
				String keyword = params[0].toString();
				int count = reportService.isKeywordExistInReportTable(keyword);
				if(count<=0)
					reportService.insertKeyword(new ReportVO(keyword,1));
				else
					reportService.updateKeyword(keyword);
			}
		}
		return retValue; //실제 대상 메서드가 반환하는 리턴값
	}
	
}
