package Annotation.Dto;

import Annotation.Entity.DiaryEntity;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DiaryDto {
    private int Diary_Id;
    private int Year;
    private int Month;
    private int Day;
    private String Title;
    private String Content;

    public static DiaryDto toSaveDto(DiaryEntity diaryEntity) {
        DiaryDto diaryDto = new DiaryDto();
        diaryDto.setDiary_Id(diaryEntity.getDiary_Id());
        diaryDto.setYear(diaryEntity.getYear());
        diaryDto.setMonth(diaryEntity.getMonth());
        diaryDto.setDay(diaryEntity.getDay());
        diaryDto.setTitle(diaryEntity.getTitle());
        diaryDto.setContent(diaryEntity.getContent());
        return diaryDto;
    }

}
