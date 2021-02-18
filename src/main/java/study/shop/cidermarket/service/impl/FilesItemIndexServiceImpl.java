package study.shop.cidermarket.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import study.shop.cidermarket.model.Files;
import study.shop.cidermarket.service.FilesService;

@Slf4j
@Service
public class FilesItemIndexServiceImpl implements FilesService{

	/** MyBatis */
	// -> import org.springframework.beans.factory.annotation.Autowired;
	// -> import org.apache.ibatis.session.SqlSession; 
	@Autowired SqlSession sqlSession;
	
	@Override
	public Files getFilesItem(Files input) throws Exception {
		return null;
	}

	@Override
	public List<Files> getFilesList(Files input) throws Exception {
		List<Files> result = null;
		try {
			result = sqlSession.selectList("FilesMapper.selectItemIndexList", input);
			if(result == null) {
				throw new NullPointerException("result=null");
			}
		} catch (NullPointerException e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("조회된 데이터가 없습니다.");
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 조회에 실패했습니다.");
		}
		return result;
	}

	@Override
	public int getFilesCount(Files input) throws Exception {
		return 0;
	}

	@Override
	public int addFiles(Files input) throws Exception {
		return 0;
	}

	@Override
	public int editFiles(Files input) throws Exception {
		return 0;
	}

	@Override
	public int deleteFiles(Files input) throws Exception {
		return 0;
	}

}
