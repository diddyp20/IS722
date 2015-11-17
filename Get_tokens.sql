SET serveroutput ON;
--get_words procedure
CREATE OR REPLACE PROCEDURE get_tokens_2(
    querystr VARCHAR2)
AS
  tok tokens;
  keyword  VARCHAR2(100);
  NA_flag  BOOLEAN := FALSE;
  temp_var VARCHAR2(50);
  counter  NUMBER;
BEGIN
  SELECT LENGTH(querystr) - LENGTH(REPLACE(querystr, ' ', '')) + 1
  INTO counter
  FROM dual;
  tok := StringTokenizer(querystr,' ');
  FOR i IN tok.first..counter
  LOOP
    NA_flag:= FALSE;
    dbms_output.put_line('==== '||i||' =====');
    --Open inner loop
    FOR CUR_VAL IN
    (SELECT kwtext FROM syskeyword_bnd
    )
    LOOP
      IF LOWER(tok(i))= LOWER(CUR_VAL.kwtext) THEN
        dbms_output.put_line('This token is a keyword in SQL: '||tok(i));
        NA_FLAG:= TRUE;
        --dbms_output.put_line(CUR_VAL.kwtext);
      END IF;
    END LOOP;
    --not in the keyword table
    IF NOT NA_flag THEN
      dbms_output.put_line('This token is not keyword in SQL: '||tok(i));
    END IF;
  END LOOP;
END;
EXEC get_tokens_2('allo bonjour * la terre select me voici parce que order');
