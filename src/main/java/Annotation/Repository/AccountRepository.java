package Annotation.Repository;

import Annotation.Entity.AccountEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AccountRepository extends JpaRepository<AccountEntity, Long> {

    @Query(value="select * from Account",nativeQuery = true)
    public List<AccountEntity> findAll();
}
