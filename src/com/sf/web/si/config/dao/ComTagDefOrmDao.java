package com.sf.web.si.config.dao;

import java.util.*;
import org.springframework.data.jpa.repository.*;
import com.smartframework.core.dao.OrmDao;
import com.sf.web.si.config.entity.ComTagDef;

/**
 * @创建人    chenth
 * @日期    2020/05/28
 */
public interface ComTagDefOrmDao extends OrmDao<ComTagDef,  Integer>
{
	public List<ComTagDef> findByName(String name);
	
}
