package com.project.hot.community.model.dto;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Community {
    private int communityNo;
    private String communityTitle;
    private String communityIntroduce;
    private String communityIsOpen;
    private List<CommunityUser> members;
    private String employeePhotos;
    private List<String> employeePhotoList;



}