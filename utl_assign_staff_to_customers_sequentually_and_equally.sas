Assign staff to customers sequentually and equally

github
https://tinyurl.com/y9hmu2ha
https://github.com/rogerjdeangelis/utl_assign_staff_to_customers_sequentually_and_equally

https://tinyurl.com/y9jh8g24
https://communities.sas.com/t5/Base-SAS-Programming/Equally-distribute-records-to-a-list/m-p/487306

Recent simplification by Mark
Mark Keintz
mkeintz@wharton.upenn.edu

I suggest dropping the "if _n_=0 ..." line, and attach the
"nobs=obs" parameter to the other set statement.
A good pedagogical example of compile time
vs execution time SET parameters.

data want;
  /* if _n_=0 then set staff nobs=obs;*/
  set customer;
    pnt=mod(_n_-1,obs) +1;
    set staff point=pnt nobs=obs;
run;quit;


INPUT
=====

 WORK.STAFF total obs=3

  STAFFNAME

   JOHN
   PAUL
   SARTRE

 WORK.CUSTOMER total obs=7

   CUSTID

   ABC123
   DEF456
   GHI789
   JKL101
   MNO112
   F000131
   G000415

 EXAMPLE OUTPUT
 --------------

 ORK.WANT total obs=7   |  RULES
                        |
  CUSTID     STAFFNAME  |
                        |
  ABC123      JOHN      | * cycle though staff sequentually
  DEF456      PAUL      |
  GHI789      SARTRE    |
                         |
  JKL101      JOHN      |
  MNO112      PAUL      |
  F000131     SARTRE    |
                         |
  G000415     JOHN      |
                        |

PROCESS
=======

data wantfix;
  if _n_=0 then set staff nobs=obs;
  set customer;
    pnt=mod(_n_-1,obs) +1;
    set staff point=pnt;
run;quit;

OUTPUT
======

 WORK.WANTFIX total obs=7

  STAFFNAME    CUSTID

   JOHN        ABC123
   PAUL        DEF456
   SARTRE      GHI789
   JOHN        JKL101
   PAUL        MNO112
   SARTRE      F000131
   JOHN        G000415

*                _              _       _
 _ __ ___   __ _| | _____    __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \  / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/ | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|  \__,_|\__,_|\__\__,_|

;

data customer;
input custid :$8.;
cards4;
ABC123
DEF456
GHI789
JKL101
MNO112
F000131
G000415
;;;;
run;

data staff;
input staffname :$8.;
cards4;
JOHN
PAUL
SARTRE
;;;;
run;

