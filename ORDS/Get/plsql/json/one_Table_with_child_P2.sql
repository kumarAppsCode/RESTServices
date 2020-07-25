create or replace PROCEDURE get_json_org_to_child_many (
    p_org_id IN xxstg_organizations.org_id%TYPE DEFAULT NULL
) AS
    l_cursor SYS_REFCURSOR;
BEGIN
    OPEN l_cursor FOR 
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
                                pro.PROJ_ID, pro.PROJECT_NAME, pro.PROJECT_NUMBER, pro.ORG_ID,
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
                                    )pro_milstone
                                from xxstg_projects pro
                                where pro.ORG_ID=org.ORG_ID
                          ) as pro

                      FROM
                          xxstg_organizations org
                      WHERE
                          org_id = decode(p_org_id, null,  org.org_id, p_org_id);

    apex_json.open_object;
    apex_json.write('org', l_cursor);
    apex_json.close_object;
END;
