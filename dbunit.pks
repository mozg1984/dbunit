create or replace package dbunit is
  -- Available notification modes:
  WITH_EXCEPTIONS constant integer := 0;    -- with throwing exceptions
  WITHOUT_EXCEPTIONS constant integer := 1; -- without throwing exceptions (reporting to output)

  -- Set notification mode for assertions
  procedure set_notification_mode(p_mode integer := WITH_EXCEPTIONS);

  /*********************************** ASSERTIONS API ***********************************/

  -- assert a condition
  procedure assert(condition boolean, message varchar2 := '');

  -- asserts that given values are equal
  procedure assert_equals(expected number, actual number, message varchar2 := '');
  procedure assert_equals(expected varchar2, actual varchar2, message varchar2 := '');
  procedure assert_equals(expected date, actual date, message varchar2 := '');
  procedure assert_equals(expected clob, actual clob, message varchar2 := '');
  procedure assert_equals(expected xmltype, actual xmltype, message varchar2 := '');

  -- asserts that given values are not equal
  procedure assert_not_equals(expected number, actual number, message varchar2 := '');
  procedure assert_not_equals(expected varchar2, actual varchar2, message varchar2 := '');
  procedure assert_not_equals(expected date, actual date, message varchar2 := '');
  procedure assert_not_equals(expected clob, actual clob, message varchar2 := '');
  procedure assert_not_equals(expected xmltype, actual xmltype, message varchar2 := '');

  -- asserts that given value is null
  procedure assert_null(actual number, message varchar2 := '');
  procedure assert_null(actual varchar2, message varchar2 := '');
  procedure assert_null(actual date, message varchar2 := '');
  procedure assert_null(actual clob, message varchar2 := '');
  procedure assert_null(actual xmltype, message varchar2 := '');

  -- asserts that given value is not null
  procedure assert_not_null(actual number, message varchar2 := '');
  procedure assert_not_null(actual varchar2, message varchar2 := '');
  procedure assert_not_null(actual date, message varchar2 := '');
  procedure assert_not_null(actual clob, message varchar2 := '');
  procedure assert_not_null(actual xmltype, message varchar2 := '');

  -- asserts that given xpath is correct
  procedure assert_xpath(xpath varchar2, actual xmltype, message varchar2 := '');
  procedure assert_xpath(expected varchar2, xpath varchar2, actual xmltype, message varchar2 := '');
end;
