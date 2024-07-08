package com.project.hot.approval.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.hot.approval.model.dto.Approval;
import com.project.hot.approval.model.dto.VacationForm;

import java.util.List;

@Repository
public class ApprovalDocumentDaoImpl implements ApprovalDocumentDao {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<Approval> AllDocuments() {
        return sqlSession.selectList("approval.approvalAll");
    }

    @Override
    public List<String> getEmployeesByDepartment(String department) {
        return sqlSession.selectList("approval.getEmployeesByDepartment", department);
    }



}
