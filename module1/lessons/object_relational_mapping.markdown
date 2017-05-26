# Object Relational Mapping (ORM)  

## Learning Goals  
## Vocabulary  
## Warm Up  
## Some Data Storage Options  
#### Hashes  
#### CSV Comma Separated Values  
#### Relational Database (w/ tables)  
```
| Teachers|
|id | first_name | last_name | module |  
 2    Ali          Schlereth   1  
 5    Mike         Dao         1  
 1    Sal          Espinosa    1  
 6    Lauren       Fazah       2
```
#### Array of Ruby Objects   
It might be an array of Ruby Objects such as:  
```
[#<Teacher:0x007fc543b7ca90 @first_name="Ali", @id=2, @last_name="Schlereth", @mod=1>,  
 #<Teacher:0x007fc544540590 @first_name="Mike", @id=5, @last_name="Dao", @mod=1>,  
 #<Teacher:0x007fc544661758 @first_name="Sal", @id=1, @last_name="Espinosa", @mod=1>,  
 #<Teacher:0x007fc54479b6a0 @first_name="Lauren", @id=6, @last_name="Fazah", @mod=2>]  
```

### Independent Practice  
Write the Ruby that you would use to make these Teacher objects.  

## What is ORM

Object Relational Mapping (ORM) is a technique for managing and interacting with data that come from incompatible data sources. Sometimes referred to as "_an_" ORM, thus "Object Relational Mapper."

## Where You're Likely to See ORM

Rails applications use an ORM framework called Active Record to manage this mapping process. Once your applications incorporate the use of formal databases, frameworks like Active Record allow you to dictate the loading of data into your system using (in this case) Ruby  objects. We refer to ActiveRecord as an Object Relational Mapper, and the details of how you get your Ruby class to map to the database and what's in that Ruby class will depend on what ORM you're using.

A Ruby Object like Item would align with a corresponding database table. In Rails, we will call these classes "models."

```
class Item
  def initialize(id, name, description, unit_price, created_at, updated_at, merchant_id)
    @id = id
    @name = name
    @description = description
    @unit_price = unit_price
    @created_at = created_at
    @updated_at = updated_at
    @merchant_id = merchant_id
  end
end
```

| Items |
| --- |
| id |
| name |
| description |
| unit_price |
| created_at |
| updated_at |
| merchant_id |

In Rails applications, the process for defining new tables and models is slightly different than is called for in simple Ruby applications, but the underlying concept of using objects to organize and interact with data persists.

## Advantages

*   Allows you to extract data from disparate sources and interact with using consistent tactics (OOP).
*   Wraps data from disparate sources in one consistent object model, objects are easy to deal with
*   Maintenance: if/when your data source changes, you only need to make updates in one location
