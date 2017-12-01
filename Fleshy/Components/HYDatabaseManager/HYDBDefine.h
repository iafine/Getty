//
//  HYDBDefine.h
//  Fleshy
//
//  Created by Hyyy on 2017/11/14.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#ifndef HYDBDefine_h
#define HYDBDefine_h

#define HY_DB_NAME      @"fleshy.sqlite"
#define HY_DB_VERSION   1.0

#define HY_CREATE_PALN  @"create table fleshy_plan(\
                            plan_id INTEGER,\
                            plan_name TEXT NOT NULL UNIQUE,\
                            plan_start_time TEXT NOT NULL,\
                            plan_end_time TEXT NOT NULL,\
                            plan_create_time TEXT NOT NULL,\
                            plan_update_time TEXT NOT NULL,\
                            plan_duration_time INTEGER NOT NULL,\
                            plan_duration_days INTEGER NOT NULL,\
                            plan_is_delete  INTEGER DEFAULT 0,\
                            PRIMARY KEY (plan_id)\
                        );"

#define HY_CREATE_PERFORMANCE   @"CREATE TABLE IF NOT EXISTS fleshy_performance(\
                                    perform_id INTEGER,\
                                    plan_id INTEGER NOT NULL,\
                                    is_perform INTEGER DEFAULT 0,\
                                    perform_date TEXT,\
                                    perform_is_delete INTEGER DEFAULT 0,\
                                    PRIMARY KEY (perform_id),\
                                    FOREIGN KEY (plan_id) REFERENCES fleshy_plan(plan_id)\
                                );"


#endif /* HYDBDefine_h */
