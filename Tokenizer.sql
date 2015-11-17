--First create a type named TOKENS
CREATE OR REPLACE TYPE tokens
AS
  TABLE OF VARCHAR2(1000);
  --Second create a StringTokenizer function which takes a String and a delimiter as a input parameter
CREATE OR REPLACE FUNCTION StringTokenizer(
  str   VARCHAR2,
  delim CHAR)
RETURN tokens
IS
  toks tokens;
  ch      VARCHAR2(1)   := SUBSTR(str,1,1);
  tempStr VARCHAR2(100) :='';
  index2  INTEGER       :=1;
  ctr     INTEGER       := 2;
BEGIN
  toks := tokens(1);
  toks.extend(LENGTH(str) );
  WHILE ch IS NOT NULL
  LOOP
    IF ch           = delim THEN
      toks(index2) := tempStr;
      tempStr      :='';
      index2       := index2 + 1;
      ch           := SUBSTR(str,ctr,1);
      ctr          := ctr + 1;
    ELSE
      tempStr := tempStr||ch;
      ch      := SUBSTR(str,ctr,1);
      ctr     := ctr + 1;
    END IF;
  END LOOP;
  IF LENGTH(tempStr) > 0 THEN
    toks(index2)    := tempStr;
  END IF;
  RETURN toks;
END;
