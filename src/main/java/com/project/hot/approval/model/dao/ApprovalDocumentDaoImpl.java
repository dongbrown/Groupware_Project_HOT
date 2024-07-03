package com.project.hot.approval.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.hot.approval.model.dto.Approval;

@Repository
public class ApprovalDocumentDaoImpl implements ApprovalDocumentDao {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<Approval> AllDocuments() {
        return null;
    }
}
