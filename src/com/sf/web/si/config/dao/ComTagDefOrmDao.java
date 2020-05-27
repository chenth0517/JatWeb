package com.sf.web.si.config.dao;

import java.util.*;
import org.springframework.data.jpa.repository.*;
import com.smartframework.core.dao.OrmDao;
import com.sf.web.si.config.entity.ComTagDef;

/**
 * @创建人    SmartWeb Code Plugin Created.
 * @日期    2017/12/27
 */
public interface ComTagDefOrmDao extends OrmDao<ComTagDef,  Integer>
{
	public List<ComTagDef> findByName(String name);
	
}
