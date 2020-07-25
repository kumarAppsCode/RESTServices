--ORDS.source_type_query
--source_type_collection_feed

select * FROM user_ords_modules;
select * FROM user_ords_templates;
select * FROM user_ords_handlers;

select * FROM user_ords_modules;
select * FROM user_ords_templates;
select * FROM user_ords_handlers;

--http://localhost:8080/ords/sale/get/org/

--SELECT
--    temp.module_id,    mod.name,
--    mod.uri_prefix,
--    temp.uri_template,
--    hand.method,
--    hand.source,
--    hand.mimes_allowed,
--    hand.source_type
----    hand.items_per_page,
--FROM
--    user_ords_modules     mod,
--    user_ords_templates   temp,
--        user_ords_handlers    hand
--WHERE
--    mod.id = temp.module_id
--    AND temp.id = hand.template_id
-----------------------------------------------------------------
begin 
ORDS_METADATA.ORDS.DEFINE_MODULE(
    P_MODULE_NAME => 'GET_API',
    P_BASE_PATH => 'get/',
    P_ITEMS_PER_PAGE => 0
    );
end;
/
-----------------------------------------------------------------
begin
 ORDS_METADATA.ORDS.DEFINE_TEMPLATE(
    P_MODULE_NAME => 'GET_API',
    P_PATTERN => 'org/'
  );
end;
/
-----------------------------------------------------------------
begin
ORDS.DEFINE_HANDLER(
    P_MODULE_NAME => 'GET_API',
    P_PATTERN => 'org/',
    P_METHOD => 'GET',
    P_SOURCE_TYPE => ords.source_type_query,
    P_SOURCE => 'Select * from xxstg_organizations',
    p_items_per_page => 0
  );
  commit;
end;
/
----2nd 1 to many

begin
 ORDS_METADATA.ORDS.DEFINE_TEMPLATE(
    P_MODULE_NAME => 'GET_API',
    P_PATTERN => 'org/:orgid'
  );
ORDS.DEFINE_HANDLER(
    P_MODULE_NAME => 'GET_API',
    P_PATTERN => 'org/:orgid',
    P_METHOD => 'GET',
    P_SOURCE_TYPE => ords.source_type_query,
    P_SOURCE => 'Select * from xxstg_organizations where ORG_ID=:orgid',
    p_items_per_page => 0
  );  
  commit;
end;

--3

begin
 ORDS_METADATA.ORDS.DEFINE_TEMPLATE(
    P_MODULE_NAME => 'GET_API',
    P_PATTERN => 'org/:orgid/:orgname'
  );
ORDS.DEFINE_HANDLER(
    P_MODULE_NAME => 'GET_API',
    P_PATTERN => 'org/:orgid/:orgname',
    P_METHOD => 'GET',
    P_SOURCE_TYPE => ords.source_type_query,
    P_SOURCE => 'Select * from xxstg_organizations where ORG_ID=:orgid and ORG_NAME like ''%''||:orgname||''%''',
    p_items_per_page => 0
  );  
  commit;
end;
