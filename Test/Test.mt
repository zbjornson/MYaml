(* Wolfram Language Test file *)

(* example2_10 *)
Test[
	ImportString["---
 hr:
   - Mark McGwire
   # Following node labeled SS
   - &SS Sammy Sosa
 rbi:
   - *SS # Subsequent occurrence
   - Ken Griffey", "YAML"]
	,
	{
		"hr" -> {"Mark McGwire", "Sammy Sosa"}, 
 		"rbi" -> {"Sammy Sosa", "Ken Griffey"}
 	}
	,
	TestID->"Test-20161011-Z8M2U3"
]

(* example2_11 *)
Test[
	ImportString["
? - Detroit Tigers
  - Chicago cubs
:
  - 2001-07-23

? [ New York Yankees,
    Atlanta Braves ]
: [ 2001-07-02, 2001-08-12,
    2001-08-14 ]", "YAML"]
	,
	{{"Detroit Tigers", 
   "Chicago cubs"} -> {DateObject[{2001, 7, 22}, 
    TimeObject[{17, 0, 0.}, TimeZone -> -7.], 
    TimeZone -> -7.]}, {"New York Yankees", 
   "Atlanta Braves"} -> {DateObject[{2001, 7, 1}, 
    TimeObject[{17, 0, 0.}, TimeZone -> -7.], TimeZone -> -7.], 
   DateObject[{2001, 8, 11}, TimeObject[{17, 0, 0.}, TimeZone -> -7.],
     TimeZone -> -7.], 
   DateObject[{2001, 8, 13}, TimeObject[{17, 0, 0.}, TimeZone -> -7.],
     TimeZone -> -7.]}}
	,
	TestID->"Test-20161011-S6A2M3"
]

(* example2_12 *)
Test[
	ImportString["---
 # products purchased
 - item    : Super Hoop
   quantity: 1
 - item    : Basketball
   quantity: 4
 - item    : Big Shoes
   quantity: 1", "YAML"]
	,
	{{"item" -> "Super Hoop", "quantity" -> 1}, {"item" -> "Basketball", 
  "quantity" -> 4}, {"item" -> "Big Shoes", "quantity" -> 1}}
	,
	TestID->"Test-20161011-B9K5F4"
]


(* example2_19 *)
Test[
	ImportString["
canonical: 12345
decimal: +12_345
sexagesimal: 3:25:45
octal: 014
hexadecimal: 0xC", "YAML"]
	,
	{"canonical" -> 12345, "decimal" -> 12345, "sexagesimal" -> 12345, 
 "octal" -> 12, "hexadecimal" -> 12}
	,
	TestID->"Test-20161011-H6B5W5"
]

(* example2_20 *)
Test[
	ImportString["
canonical: 1.23015e+3
exponential: 12.3015e+02
sexagesimal: 20:30.15
fixed: 1_230.15
negative infinity: -.inf
not a number: .NaN", "YAML"]
	,
	{"canonical" -> 1230.15, "exponential" -> 1230.15, 
 "sexagesimal" -> 1230.15, "fixed" -> 1230.15, 
 "negative infinity" -> -\[Infinity], "not a number" -> Indeterminate}
	,
	TestID->"Test-20161011-N9W3L9"
]

(* example2_22 *)
Test[
	ImportString["
canonical: 2001-12-15T02:59:43.1Z
iso8601: 2001-12-14t21:59:43.10-05:00
spaced: 2001-12-14 21:59:43.10 -5
date: 2002-12-14", "YAML"]
	,
	{"canonical" -> 
  DateObject[{2001, 12, 14}, 
   TimeObject[{18, 59, 43.}, TimeZone -> -7.], TimeZone -> -7.], 
 "iso8601" -> 
  DateObject[{2001, 12, 14}, 
   TimeObject[{18, 59, 43.}, TimeZone -> -7.], TimeZone -> -7.], 
 "spaced" -> 
  DateObject[{2001, 12, 14}, 
   TimeObject[{18, 59, 43.}, TimeZone -> -7.], TimeZone -> -7.], 
 "date" -> 
  DateObject[{2002, 12, 13}, TimeObject[{16, 0, 0.}, TimeZone -> -7.],
    TimeZone -> -7.]}
	,
	TestID->"Test-20161011-D4Y1V3"
]

(* example2_25*)
Test[
	ImportString["--- !!set
? Mark McGwire
? Sammy Sosa
? Ken Griff", "YAML"]
	,
	{"Mark McGwire", "Sammy Sosa", "Ken Griff"}
	,
	TestID->"Test-20161011-B0D2P0"
]

(* example2_26 *)
Test[
	ImportString["--- !!omap
- Mark McGwire: 65
- Sammy Sosa: 63
- Ken Griffy: 58", "YAML"]
	,
	{"Mark McGwire" -> 65, "Sammy Sosa" -> 63, "Ken Griffy" -> 58}
	,
	TestID->"Test-20161011-I9V7P6"
]

(* example2_28 abridged *)
Test[
	ImportString["
Date: 2001-11-23 15:03:17 -5
User: ed
Fatal:
  Unknown variable \"bar\"
Stack:
  - file: TopClass.py
    line: 23
    code: |
      x = MoreObject(\"345\\n\")
  - file: MoreClass.py
    line: 58
    code: |-
      foo = bar
", "YAML"]
	,
	{"Date" -> 
  DateObject[{2001, 11, 23}, 
   TimeObject[{12, 3, 17.}, TimeZone -> -7.], TimeZone -> -7.], 
 "User" -> "ed", "Fatal" -> "Unknown variable \"bar\"", 
 "Stack" -> {{"file" -> "TopClass.py", "line" -> 23, 
    "code" -> "x = MoreObject(\"345\\n\")
"}, {"file" -> "MoreClass.py", "line" -> 58, 
    "code" -> "foo = bar"}}}
	,
	TestID->"Test-20161011-K6D5Z7"
]

(* any-object-example *)
Test[
	ImportString["
none: [~, null]
bool: [true, false, on, off]
int: 42
float: 3.14159
list: [LITE, RES_ACID, SUS_DEXT]
dict: {hp: 13, sp: 5}
", "YAML"]
	,
	{
		"none" -> {Null, Null},
		"bool" -> {True, False, True, False}, 
 		"int" -> 42, "float" -> 3.14159, 
 		"list" -> {"LITE", "RES_ACID", "SUS_DEXT"}, 
 		"dict" -> {"hp" -> 13, "sp" -> 5}
 	}
	,
	TestID->"Test-20161011-V9W2Q8"
]

(* list-bean-1 *)
Test[
	ImportString["
children:
- aaa
- bbb
developers:
- name: Fred
  role: creator
- name: John
  role: committer
name: Bean123
", "YAML"]
	,
	{
		"children" -> {"aaa", "bbb"}, 
		"developers" -> {
			{"name" -> "Fred", "role" -> "creator"},
			{"name" -> "John", "role" -> "committer"}
		}, 
		"name" -> "Bean123"
	}
	,
	TestID->"Test-20161011-Q6S9A8"
]

(* list-bean-3 *)
Test[
	ImportString["
developers:
- name: Fred
  role: creator
- name: John
  role: committer
name: Bean123
", "YAML"]
	,
	{
		"developers" -> {
			{"name" -> "Fred", "role" -> "creator"},
			{"name" -> "John", "role" -> "committer"}
		}, 
		"name" -> "Bean123"
	}
	,
	TestID->"Test-20161011-Q4P6F4"
]

(* map-bean-1 *)
Test[
	ImportString["
name: Bean123
properties:
  key2: value2
  key1: value1
sorted:
  '1': one
  '2': two
", "YAML"]
	,
	{"name" -> "Bean123", 
 "properties" -> {"key2" -> "value2", "key1" -> "value1"}, 
 "sorted" -> {"1" -> "one", "2" -> "two"}}
	,
	TestID->"Test-20161011-I0H0Q1"
]

(* map-bean-10 *)
Test[
	ImportString["
data:
  aaa: 1
  bbb: 2
  zzz: 3
developers:
  team1:
    name: Fred
    role: creator
  team2:
    name: John
    role: committer
name: Bean123
", "YAML"]
	,
	{"data" -> {"aaa" -> 1, "bbb" -> 2, "zzz" -> 3}, 
 "developers" -> {"team1" -> {"name" -> "Fred", "role" -> "creator"}, 
   "team2" -> {"name" -> "John", "role" -> "committer"}}, 
 "name" -> "Bean123"}
	,
	TestID->"Test-20161011-D7N9V1"
]

(* map-bean-12 *)
Test[
	ImportString["
data:
  ? name: Andy
    role: tester
  : BLACK
  ? name: Lisa
    role: owner
  : RED
developers:
  WHITE:
    name: Fred
    role: creator
  BLACK:
    name: John
    role: committer
name: Bean123
", "YAML"]
	,
	{"data" -> {{"name" -> "Andy", "role" -> "tester"} -> 
    "BLACK", {"name" -> "Lisa", "role" -> "owner"} -> "RED"}, 
 "developers" -> {"WHITE" -> {"name" -> "Fred", "role" -> "creator"}, 
   "BLACK" -> {"name" -> "John", "role" -> "committer"}}, 
 "name" -> "Bean123"}
	,
	TestID->"Test-20161011-D8I0V3"
]

(* map-bean-2 *)
Test[
	ImportString["
- {'1': one, '2': two}
- {key2: value2, key1: value1}
- aaa
", "YAML"]
	,
	{{"1" -> "one", "2" -> "two"}, {"key2" -> "value2", 
  "key1" -> "value1"}, "aaa"}
	,
	TestID->"Test-20161011-A2E1M9"
]

(* set-bean-1 *)
Test[
	ImportString["
developers: !!set
  ? name: John
    role: founder
  : null
  ? name: Karl
    role: user
  : null
name: Bean123
sorted: !!set
  one: null
  three: null
  two: null
", "YAML"]
	,
	{"developers" -> {{"name" -> "John", 
    "role" -> "founder"}, {"name" -> "Karl", "role" -> "user"}}, 
 "name" -> "Bean123", "sorted" -> {"one", "three", "two"}}
	,
	TestID->"Test-20161011-Z6J3X5"
]

(* set-bean-2 *)
Test[
	ImportString["
developers: !!set
  ? name: Karl
    role: user
  : null
  ? name: John
    role: founder
  : null
  
name: Bean123

sorted: !!set
  two: null
  one: null
  three: null
", "YAML"]
	,
	{"developers" -> {{"name" -> "Karl", 
    "role" -> "user"}, {"name" -> "John", "role" -> "founder"}}, 
 "name" -> "Bean123", "sorted" -> {"two", "one", "three"}}
	,
	TestID->"Test-20161011-P1D9V3"
]

(* set-bean-4 *)
Test[
	ImportString["
!!set {bbb: null, aaa: null, zzz: null}
", "YAML"]
	,
	{"bbb", "aaa", "zzz"}
	,
	TestID->"Test-20161011-A9Q6O8"
]

