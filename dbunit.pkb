create or replace package body dbunit is
  -- Current notification mode
  NOTIFICATION_MODE integer := WITH_EXCEPTIONS;

  -- Set notification mode for assertions
  procedure set_notification_mode(p_mode integer := WITH_EXCEPTIONS)
  is
  begin
    if (p_mode in (WITH_EXCEPTIONS, WITHOUT_EXCEPTIONS)) then
      NOTIFICATION_MODE := p_mode;
    end if;
  end;

  --
  function format(message varchar2) return varchar2
  is
  begin
    return initcap(trim(message)) || 
      case when length(trim(message)) > 0 then '     ' else '' end;
  end;

  -- Raise an error given a message (Notification)
  procedure raiseError(message varchar2)
  is
  begin
    if (NOTIFICATION_MODE = WITH_EXCEPTIONS) then
      raise_application_error(-20000, message);
    end if;

    dbms_output.put_line(message);
  end;

 -- Assert a condition
  procedure assert(condition boolean, message varchar2 := '')
  is
  begin
    if (not condition) then
      raiseError(message);
    end if;
  end;

  -- Asserts that given values are equal
  procedure assert_equals(expected number, actual number, message varchar2 := '')
  is
  begin
    if (not (expected = actual)) then
      raiseError(format(message) || 'Expected ' || to_char(expected) || ', got ' || to_char(actual));
    end if;
  end;

  procedure assert_equals(expected varchar2, actual varchar2, message varchar2 := '')
  is
  begin
    if (not (expected = actual)) then
      raiseError(format(message) || 'Expected ' || expected || ', got ' || actual);
    end if;
  end;

  procedure assert_equals(expected date, actual date, message varchar2 := '')
  is
  begin
    if (not (expected = actual)) then
      raiseError(format(message) || 'Expected ' || to_char(expected, 'dd.mm.yyyy hh24:mi:ss') || ', got ' || to_char(actual, 'dd.mm.yyyy hh24:mi:ss'));
    end if;
  end;

  procedure assert_equals(expected clob, actual clob, message varchar2 := '')
  is
  begin
    if (dbms_lob.compare(expected, actual) != 0) then
      raiseError(format(message) || 'Expected CLOB value IS NOT EQUAL to actual CLOB value');
    end if;
  end;

  procedure assert_equals(expected xmltype, actual xmltype, message varchar2 := '')
  is
  begin
    if (dbms_lob.compare(expected.getclobval(), actual.getclobval()) != 0) then
      raiseError(format(message) || 'Expected XMLTYPE value IS NOT EQUAL to actual XMLTYPE value');
    end if;
  end;

  -- asserts that given values are not equal
  procedure assert_not_equals(expected number, actual number, message varchar2 := '')
  is
  begin
    if (expected = actual) then
      raiseError(format(message) || 'Expected ' || to_char(expected) || ' IS EQUAL to ' || to_char(actual));
    end if;
  end;

  procedure assert_not_equals(expected varchar2, actual varchar2, message varchar2 := '')
  is
  begin
    if (expected = actual) then
      raiseError(format(message) || 'Expected ' || expected || ' IS EQUAL to ' || actual);
    end if;
  end;

  procedure assert_not_equals(expected date, actual date, message varchar2 := '')
  is
  begin
    if (expected = actual) then
      raiseError(format(message) || 'Expected ' || to_char(expected, 'dd.mm.yyyy hh24:mi:ss') || ' IS EQUAL to ' || to_char(actual, 'dd.mm.yyyy hh24:mi:ss'));
    end if;
  end;

  procedure assert_not_equals(expected clob, actual clob, message varchar2 := '')
  is
  begin
    if (dbms_lob.compare(expected, actual) = 0) then
      raiseError(format(message) || 'Expected CLOB value IS EQUAL to actual CLOB value');
    end if;
  end;

  procedure assert_not_equals(expected xmltype, actual xmltype, message varchar2 := '')
  is
  begin
    if (dbms_lob.compare(expected.getclobval(), actual.getclobval()) = 0) then
      raiseError(format(message) || 'Expected XMLTYPE value IS EQUAL to actual XMLTYPE value');
    end if;
  end;

  -- asserts that given value is null
  procedure assert_null(actual number, message varchar2 := '')
  is
  begin
    if (actual is not null) then
      raiseError(format(message) || 'Expected NULL NUMBER value, got NOT NULL NUMBER value');
    end if;
  end;

  procedure assert_null(actual varchar2, message varchar2 := '')
  is
  begin
    if (actual is not null) then
      raiseError(format(message) || 'Expected NULL VARCHAR2 value, got NOT NULL VARCHAR2 value');
    end if;
  end;

  procedure assert_null(actual date, message varchar2 := '')
  is
  begin
    if (actual is not null) then
      raiseError(format(message) || 'Expected NULL DATE value, got NOT NULL DATE value');
    end if;
  end;

  procedure assert_null(actual clob, message varchar2 := '')
  is
  begin
    if (actual is not null) then
      raiseError(format(message) || 'Expected NULL CLOB value, got NOT NULL CLOB value');
    end if;
  end;

  procedure assert_null(actual xmltype, message varchar2 := '')
  is
  begin
    if (actual is not null) then
      raiseError(format(message) || 'Expected NULL XMLTYE value, got NOT NULL XMLTYE value');
    end if;
  end;

  -- asserts that given value is not null
  procedure assert_not_null(actual number, message varchar2 := '')
  is
  begin
    if (actual is null) then
      raiseError(format(message) || 'Expected NOT NULL NUMBER value, got NULL NUMBER value');
    end if;
  end;

  procedure assert_not_null(actual varchar2, message varchar2 := '')
  is
  begin
    if (actual is null) then
      raiseError(format(message) || 'Expected NOT NULL VARCHAR2 value, got NULL VARCHAR2 value');
    end if;
  end;

  procedure assert_not_null(actual date, message varchar2 := '')
  is
  begin
    if (actual is null) then
      raiseError(format(message) || 'Expected NOT NULL DATE value, got NULL DATE value');
    end if;
  end;

  procedure assert_not_null(actual clob, message varchar2 := '')
  is
  begin
    if (actual is null) then
      raiseError(format(message) || 'Expected NOT NULL CLOB value, got NULL CLOB value');
    end if;
  end;

  procedure assert_not_null(actual xmltype, message varchar2 := '')
  is
  begin
    if (actual is null) then
      raiseError(format(message) || 'Expected NOT NULL XMLTYPE value, got NULL XMLTYPE value');
    end if;
  end;

  -- asserts that given xpath is correct
  procedure assert_xpath(xpath varchar2, actual xmltype, message varchar2 := '')
  is
    l_exists integer;
  begin
    select existsNode(actual, xpath) into l_exists from dual;
    if (l_exists = 0) then
      raiseError(format(message) || 'Expected XMLTYPE value IS NOT EQUAL to actual XMLTYPE value');
    end if;
  end;

  procedure assert_xpath(expected varchar2, xpath varchar2, actual xmltype, message varchar2 := '')
  is
    l_equals integer;
  begin
    select case when extractvalue(actual, xpath) = expected then 1 else 0 end into l_equals from dual;
    if (l_equals = 0) then
      raiseError(format(message) || 'Expected XMLTYPE value IS NOT EQUAL to actual XMLTYPE value');
    end if;
  end;
end;
