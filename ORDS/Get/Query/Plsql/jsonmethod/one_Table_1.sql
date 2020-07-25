SELECT
                          org.org_id,
                          org.org_name,
                          org.org_name_tl,
                          org.created_by,
                          To_date(To_char(org.creation_date,'DD-MM-YYYY'),'DD-MM-YYYY') as creation_date,
                          org.last_updated_by,
                          to_char(org.last_update_date, 'DD-MON-YYYY') AS last_update_date,
                          org.last_update_login
                      FROM
                          xxstg_organizations org
                      WHERE
                          org_id = decode(p_org_id, null,  org.org_id, p_org_id);
