Single shot 
--SELECT * FROM XXSTG_CUSTOMER
BEGIN
ORDS.define_template(
   p_module_name    => 'rest-v1',
   p_pattern        => 'customer');

ORDS.define_handler(
    p_module_name    => 'rest-v1',
    p_pattern        => 'customer/',
    p_method         => 'GET',
    p_source_type    => ORDS.source_type_collection_feed,
    p_source         => 'SELECT * FROM XXSTG_CUSTOMER',
    p_items_per_page => 2);
-------------   
ORDS.define_template(
   p_module_name    => 'rest-v1',
   p_pattern        => 'customer/:cusid');

ORDS.define_handler(
    p_module_name    => 'rest-v1',
    p_pattern        => 'customer/:cusid',
    p_method         => 'GET',
    p_source_type    => ORDS.source_type_collection_feed,
    p_source         => 'SELECT * FROM XXSTG_CUSTOMER WHERE CUST_ID = :cusid',
    p_items_per_page => 0);

--------
ORDS.define_template(
   p_module_name    => 'rest-v1',
   p_pattern        => 'customer/:cusid/:cust_num');

ORDS.define_handler(
    p_module_name    => 'rest-v1',
    p_pattern        => 'customer/:cusid/:cust_num',
    p_method         => 'GET',
    p_source_type    => ORDS.source_type_collection_feed,
    p_source         => 'SELECT * FROM XXSTG_CUSTOMER WHERE CUST_ID = :cusid and customer_number=:cust_num',
    p_items_per_page => 0);

COMMIT;
END;
