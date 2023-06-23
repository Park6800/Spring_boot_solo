package Annotation.Entity;

import Annotation.Dto.DiaryDto;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "Diary")
public class DiaryEntity {
    @Id
    @Column(name = "Diary_Id")
    private Integer Diary_Id;
    @Column(name = "Year")
    private int year;
    @Column(name = "Month")
    private int month;
    @Column(name = "Day")
    private int day;
    @Column(name = "Title")
    private String title;
    @Column(name = "Content")
    private String content;

    public static DiaryEntity toSaveEntity(DiaryDto diaryDto) {
        DiaryEntity diaryEntity = new DiaryEntity();
        diaryEntity.setDiary_Id(diaryDto.getDiary_Id());
        diaryEntity.setYear(diaryDto.getYear());
        diaryEntity.setMonth(diaryDto.getMonth());
        diaryEntity.setDay(diaryDto.getDay());
        diaryEntity.setTitle(diaryDto.getTitle());
        diaryEntity.setContent(diaryDto.getContent());
        return diaryEntity;
    }
}