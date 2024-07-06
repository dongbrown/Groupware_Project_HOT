package com.project.hot.approval.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.hot.approval.model.dto.Approval;
import com.project.hot.approval.model.dto.VacationForm;

@Repository
public class ApprovalDocumentDaoImpl implements ApprovalDocumentDao {

    @Autowired
    private SqlSession sqlSession;
    private VacationForm vacationForm;

    @Override
    public List<Approval> AllDocuments() {
        return sqlSession.selectList("approval.approvalAll");
    }

    @Override
    public Map<String, Object> inputVacationForm(VacationForm vacationForm) {
        try {
            sqlSession.insert("approvalMapper.insertVacationForm", vacationForm);
            Map<String, Object> result = new HashMap<>();
            result.put("employeeId", vacationForm.getEmployeeId());
            return result;
        } catch (Exception e) {
            throw new RuntimeException("휴가 신청서 저장 중 오류 발생: " + e.getMessage(), e);
        }
    }


}
