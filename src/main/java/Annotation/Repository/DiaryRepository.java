package Annotation.Repository;

import Annotation.Entity.DiaryEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DiaryRepository extends JpaRepository<DiaryEntity, Long> {

    @Query(value="select * from Diary",nativeQuery = true)
    public List<DiaryEntity> findByDiaryId(String title);

    public List<DiaryEntity> findByMoon(int moon);

}
