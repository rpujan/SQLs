

Declare

@Table Table

(

Col1

Varchar(5),

Col2

Varchar(5)

)

Insert

@Table

Values

(

'A' ,'1'),

(

'A' ,'2'),

(

'B' ,'3'),

(

'A' ,'3'),

(

'C' ,'1'),

(

'C' ,'3'),

(

'B' ,'1')

Select

Distinct T1.Col1,STUFF(

(Select ',' + T2.Col2 From @Table T2 Where T1.Col1 = T2.Col1 Order by T2.Col2 For XML Path ('')),1,1,'')

From

@Table T1