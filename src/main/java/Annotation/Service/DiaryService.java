package Annotation.Service;

import Annotation.Dto.AccountDto;
import Annotation.Dto.DiaryDto;
import Annotation.Entity.AccountEntity;
import Annotation.Entity.DiaryEntity;
import Annotation.Repository.AccountRepository;
import Annotation.Repository.DiaryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class DiaryService {

    @Autowired
    DiaryRepository diaryRepository;
    @Autowired
    AccountRepository accountRepository;

    public List<DiaryEntity> LoadPage(DiaryEntity diaryEntity) {
        List<DiaryEntity> diaryList = null;
        try{
            diaryList = diaryRepository.findByMonth(diaryEntity.getMonth());
        } catch (Exception error) {
            error.printStackTrace();
        }
        return diaryList;
    }

    public List<DiaryEntity> diaryPlus(DiaryDto diaryDto) {
        List<DiaryEntity> diarylist = new ArrayList<DiaryEntity>();
        DiaryEntity diaryEntity = DiaryEntity.toSaveEntity(diaryDto);
        try {
            diarylist = diaryRepository.findByMonth(diaryEntity.getMonth());
        } catch(Exception error) {
            error.printStackTrace();
        }
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

    public List<DiaryEntity> selecct_diary(String title) {
        List<DiaryEntity> detailDiaryDtos = null;
        try {
            detailDiaryDtos = diaryRepository.findByTitle(title);
        } catch (Exception error) {
            error.printStackTrace();
        }
        return detailDiaryDtos;
    }

    public void Fixdiary (DiaryDto diaryDto) {
        try {
            diaryRepository.FixDiary(diaryDto.getDiary_Id() ,diaryDto.getTitle(), diaryDto.getContent());
        } catch (Exception error) {
            error.printStackTrace();
        }
    }

    public List<AccountEntity> findMoney (AccountDto accountDto) {
        List<AccountEntity> accountlist = null;
        try {
            accountlist = accountRepository.findAll(accountDto.getMonth());
        } catch (Exception error){
            error.printStackTrace();
        }
        return accountlist;
    }

    public void AccountSave (AccountDto accountDto) {
        AccountEntity accountEntity = AccountEntity.toSaveEntity(accountDto);
        try {
            accountRepository.save(accountEntity);
        } catch (Exception error){
            error.printStackTrace();
        }
    }

    public String findmostUsed(AccountDto accountDto){
        AccountEntity accountEntity = AccountEntity.toSaveEntity(accountDto);
        String mostused = accountRepository.findMostUsed(accountEntity.getMonth());
        return mostused;
    }

    public int getCountByWhere(String location, int Month) {
        return accountRepository.countByWhere_use(location , Month);
    }

    // 돈의 사용 출처를 카운터
    public int getCountByMoney(String location, int Month) {
        return  accountRepository.countByMoney(location, Month);
    }
}
