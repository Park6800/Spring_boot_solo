package Annotation.Dto;

import Annotation.Entity.DiaryEntity;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Detail_Diary_Dto {
    private String Title;
    private String Content;

}
