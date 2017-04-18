declare
  n1 number;
  n2 number := 1;
  n3 number := 1;
  n4 number := 2;
  
  s1 varchar2(25);
  s2 varchar2(25) := 'some test string message1';
  s3 varchar2(25) := 'some test string message1';
  s4 varchar2(25) := 'some test string message2';
  
  d1 date;
  d2 date := sysdate;
  d3 date := sysdate;
  d4 date := sysdate + 1;

  clob1 clob;
  clob2 clob := to_clob('some test string message1');
  clob3 clob := to_clob('some test string message1');
  clob4 clob := to_clob('some test string message2');
  
  xmltype1 xmltype;
  xmltype2 xmltype := xmltype('<root><child attr1="1"></child></root>');
  xmltype3 xmltype := xmltype('<root><child attr1="1"></child></root>');
  xmltype4 xmltype := xmltype('<root><child attr1="2"></child></root>');
begin
  dbunit.assert(n1 is null, 'n1 is not null');
  dbunit.assert_null(n1);
  dbunit.assert(n2 is not null, 'n2 is null');
  dbunit.assert_not_null(n2);
  dbunit.assert(n3 is not null, 'n3 is null');
  dbunit.assert_not_null(n3);
  dbunit.assert(n2 is not null and n3 is not null, 'n2 and n3 both are null');
  dbunit.assert(n2 = n3, 'n2 is not equal to n3');
  dbunit.assert_equals(n2, n3);
  dbunit.assert_not_equals(n3, n4);
  
  dbunit.assert(s1 is null, 's1 is not null');
  dbunit.assert_null(s1);
  dbunit.assert(s2 is not null, 's2 is null');
  dbunit.assert_not_null(s2);
  dbunit.assert(s3 is not null, 's3 is null');
  dbunit.assert_not_null(s3);
  dbunit.assert(s2 is not null and s3 is not null, 's2 and s3 both are null');
  dbunit.assert(s2 = s3, 's2 is not equal to s3');
  dbunit.assert_equals(s2, s3);
  dbunit.assert_not_equals(s3, s4);
  
  dbunit.assert(d1 is null, 'd1 is not null');
  dbunit.assert_null(d1);
  dbunit.assert(d2 is not null, 'd2 is null');
  dbunit.assert_not_null(d2);
  dbunit.assert(d3 is not null, 'd3 is null');
  dbunit.assert_not_null(d3);
  dbunit.assert(d2 is not null and d3 is not null, 'd2 and d3 both are null');
  dbunit.assert(d2 = d3, 'd2 is not equal to d3');
  dbunit.assert_equals(d2, d3);
  dbunit.assert_not_equals(d3, d4);
  
  dbunit.assert(clob1 is null, 'clob1 is not null');
  dbunit.assert_null(clob1);
  dbunit.assert(clob2 is not null, 'clob2 is null');
  dbunit.assert_not_null(clob2);
  dbunit.assert(clob3 is not null, 'clob3 is null');
  dbunit.assert_not_null(clob3);
  dbunit.assert(clob2 is not null and clob3 is not null, 'clob2 and clob3 both are null');
  dbunit.assert_equals(clob2, clob3);
  dbunit.assert_not_equals(clob3, clob4);
  
  dbunit.assert(xmltype1 is null, 'xmltype1 is not null');
  dbunit.assert_null(xmltype1);
  dbunit.assert(xmltype2 is not null, 'xmltype2 is null');
  dbunit.assert_not_null(xmltype2);
  dbunit.assert(xmltype3 is not null, 'xmltype3 is null');
  dbunit.assert_not_null(xmltype3);
  dbunit.assert(xmltype2 is not null and xmltype3 is not null, 'xmltype2 and xmltype3 both are null');
  dbunit.assert_equals(xmltype2, xmltype3);
  dbunit.assert_not_equals(xmltype3, xmltype4);
  
  dbunit.assert_xpath('/root/child', xmltype4);
  dbunit.assert_xpath('/root/child[@attr1=2]', xmltype4);
  dbunit.assert_xpath('2', '/root/child/@attr1', xmltype4);
end;
