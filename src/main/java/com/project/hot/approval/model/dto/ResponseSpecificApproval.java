package com.project.hot.approval.model.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ResponseSpecificApproval {
	private String approvalNo;
	private Approval approval;
	private List<ApprovalAtt> atts;
	private BusinessTripForm btf;
	private List<BusinessTripPartner> btp;
	private VacationForm vf;
	private OvertimeForm otf;
	private ExpenditureForm edf;
	private List<ExpenditureItem> edi;
	private CommutingTimeForm ctf;
	private List<Reference> referenceEmployee;
	private List<Approver> approverEmployee;
}
