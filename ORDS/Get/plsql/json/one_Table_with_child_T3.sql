SELECT
                          org.org_id,
                          org.org_name,
                          org.org_name_tl,
                          org.created_by,
                          To_date(To_char(org.creation_date,'DD-MM-YYYY'),'DD-MM-YYYY') as creation_date,
                          org.last_updated_by,
                          to_char(org.last_update_date, 'DD-MON-YYYY') AS last_update_date,
                          org.last_update_login,
                          cursor (
                                select 
                                    pro.PROJ_ID, 
                                    pro.PROJECT_NAME, 
                                    pro.PROJECT_NUMBER, 
                                    pro.ORG_ID,
                                    cursor(
                                        SELECT 
                                            pm.PROJ_MS_ID, 
                                            pm.PROJ_ID, 
                                            pm.MS_NAME, 
                                            pm.START_DATE, 
                                            pm.COMPLETION_DATE
                                            FROM xxstg_project_milestones pm
                                            where 
                                            pm.PROJ_ID=pro.PROJ_ID
                                    )as projects_ms
                                from xxstg_projects pro
                                where pro.ORG_ID=org.ORG_ID
                          ) as pro,
                          cursor(
                                SELECT 
                                ppm.PROPERTY_ID, 
                                ppm.PROPERTY_NAME, 
                                ppm.PROPERTY_NUMBER, 
                                ppm.PROPERTY_SHORTCODE, 
                                ppm.ORG_ID 
                                FROM 
                                xxpm_property_master ppm
                                where 
                                ppm.ORG_ID=org.org_id
                          )as property_master

                      FROM
                          xxstg_organizations org
                      WHERE
                          org.org_id = decode(p_org_id, null,  org.org_id, p_org_id);
