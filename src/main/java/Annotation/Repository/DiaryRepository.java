package Annotation.Repository;

import Annotation.Entity.DiaryEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;

@Repository
public interface DiaryRepository extends JpaRepository<DiaryEntity, Long> {

    @Query(value="select * from Diary order by Day ASC",nativeQuery = true)
    public List<DiaryEntity> findByDiaryId(String title);

    @Query(value="select * from Diary where Month = ?1", nativeQuery = true)
    public List<DiaryEntity> findByMonth(int Month);

    @Modifying
    @Transactional
    @Query(value="update Diary set title = ?2 , content = ?3 where Diary_Id = ?1 ", nativeQuery = true)
    public void FixDiary(int Id , String title, String content);

    public List<DiaryEntity> findByTitle(String title);

}
