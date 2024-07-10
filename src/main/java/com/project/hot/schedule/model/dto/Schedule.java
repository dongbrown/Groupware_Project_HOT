package com.project.hot.schedule.model.dto;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Schedule {

    private int id;  // scheduleNo 대신
    private String title;  // scheduleTitle 대신
    private String description;  // scheduleContent 대신
    private String color;  // scheduleLabel 대신 (색상 코드로 사용)
    private String location;  // schedulePlace 대신
    private String type;  // scheduleType 대신
    private Date start;  // scheduleStartDate 대신
    private Date end;  // scheduleEndDate 대신
    private boolean allDay;

    private boolean updatedByDrag;

    // 공유 대상의 employeeNo 리스트
    private List<Integer> participants;

    //project_no 추가해야됨

    public boolean isUpdatedByDrag() {
    	return updatedByDrag;
    }


}
