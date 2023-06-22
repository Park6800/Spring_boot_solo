package Annotation.Service;

import Annotation.Dto.DiaryDto;
import Annotation.Entity.DiaryEntity;
import Annotation.Repository.DiaryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class DiaryService {

    @Autowired
    DiaryRepository diaryRepository;

    public List<DiaryEntity> LoadPage(DiaryEntity diaryEntity) {
        List<DiaryEntity> diaryList = null;
        try{
            diaryList = diaryRepository.findByMoon(diaryEntity.getMoon());
        } catch (Exception error) {
            error.printStackTrace();
        }
        return diaryList;
    }

    public List<DiaryEntity> diaryPlus(DiaryDto diaryDto) {
        List<DiaryEntity> diarylist = new ArrayList<DiaryEntity>();
        DiaryEntity diaryEntity = DiaryEntity.toSaveEntity(diaryDto);
        try {
            diaryRepository.save(diaryEntity);
            diarylist = diaryRepository.findByDiaryId(diaryEntity.getTitle());
        } catch(Exception error) {
            error.printStackTrace();
        }
        System.out.println("service : "+ diarylist);
        return diarylist;
    }

    public void diarySave (DiaryDto diaryDto) {
        DiaryEntity diaryEntity = DiaryEntity.toSaveEntity(diaryDto);
        try {
            diaryRepository.save(diaryEntity);
        } catch (Exception error){
            error.printStackTrace();
        }
    }
}
