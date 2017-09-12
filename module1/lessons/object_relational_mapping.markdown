---
title: Object Relational Mapping (ORM)
length: 60
tags: ruby, ORM, data structures
---  


## Learning Goals  
* discuss a variety of options for large scale data storage  
* explain what is an ORM and why is it useful?  
* evaluate pros/cons of strategies for navigating your data structure    

## Structure  
5 min - Warm Up  
10 min - Some Data Storage Options  
15 min - ORM  
5 min - Break  
20 min - Navigating Your Data Structure  
5 min - Wrap Up

## Vocabulary  
* Comma Separated Values (CSV)
* Object Relational Map (ORM)  
* Ruby Object  

## Warm Up  
* What do you know about large scale data storage?  
* How have you stored data in your previous Ruby programs?  

## Some Data Storage Options  
#### Hashes  
It might be stored as a mix of hashes and arrays such as:  
```
{"teachers" => [{id: 2, first_name: "Ali", last_name: "Schlereth", module: 1},  
                {id: 5, first_name: "Mike", last_name: "Dao", module: 1},  
                {id: 1, first_name: "Sal", last_name: "Espinosa", module: 1},  
                {id: 6, first_name: "Lauren", last_name: "Fazah", module: 2}]
}
```  

#### CSV Comma Separated Values  
It might be in a CSV where information is organized using commas such as:  
```
id,first_name,last_name,module  
 2,Ali,Schlereth,1  
 5,Mike,Dao,1  
 1,Sal,Espinosa,1  
 6,Lauren,Fazah,2
```  

#### Relational Database (w/ tables)  
It might be in a Relational Database which uses tables such as:  
```
| Teachers|  
----------
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
Write the Ruby code that you would use to make these Teacher objects.    

#### Turn & Talk  
Consider the scenario where some data comes from one type of data structure while other information comes from another data structure. How would that impact your application? What are some thoughts on how to make it easier for your application to navigate this different information?  

## ORM 
### What is ORM

Object Relational Mapping (ORM) is a technique for managing and interacting with data that come from incompatible data sources. Sometimes referred to as "_an_" ORM, thus "Object Relational Mapper." 

### Where You're Likely to See ORM

Rails applications use an ORM framework called Active Record to manage this mapping process. Once your applications incorporate the use of formal databases, frameworks like Active Record allow you to dictate the loading of data into your system using (in this case) Ruby objects. We refer to Active Record as an Object Relational Mapper. The details of how you get your Ruby class to map to the database and what's in that Ruby class will depend on what ORM you're using.

A Ruby Object like Item would align with a corresponding database table. In Rails, we will call these classes "models."
Active Record Model:  
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
Relational Database Table:  
```
| Items |  
---------
| id | name | description | unit_price | created_at | updated_at | merchant_id |
```
Or, the same table headers organized differently  

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

### Independent Practice  
In your notebook, write a pro/con table for using an ORM.  

#### Advantages

*   Allows you to extract data from disparate sources and interact with using consistent tactics (OOP).
*   Wraps data from disparate sources in one consistent object model, objects are easy to deal with
*   Maintenance: if/when your data source changes, you only need to make updates in one location   

** break **

## Navigating Your Data Structure  
In an ORM we might need to get something like `Merchant.all` which returns to us an array of merchant objects.  
* Where would this live? Why?  

You might also need to find all the items that belong to a merchant.  
Let's pause and take a moment to draw out how our classes relate to one another:  
```
                          SalesEngine 
       _______________________|____________________________
       |             |                 |                  |
  MerchantRepo   ItemRepo       InvoiceItemsRepo     InvoicesRepo
       |            |                  |                  | 
   Merchant       Item            InvoiceItem          Invoice

```
#### Turn & Talk  
If we need to know about all the items for a merchant, `merchant.items` which returns to us an array of item objects, what are some options for how to create these relationships? How can a merchant know about its items?    

#### Common Strategies:
*  Horizontal Knowledge  
*  Vertical Knowledge  

**Share & Record**
*  What are some of the pros/cons of each of these strategies?  
*  How does SRP(Single Responsiblity Principle) impact this list?  
*  What happens to our code base once we add on each new thing?  How will the diagram be impacted when we add customer            information into the mix?  
*  What happens if the structure/attributes of an Invoice changes? How will that impact each relationship strategy?  

## Wrap Up  
* What is an ORM, where might you use one?     
* What are some types of large scale data storage? What are some pros/cons of each? When would you want to use each?     
* Which method of data storage do you think will be the most useful in a Ruby Application? Why?  
* What are the costs/benefits of traversing vertically verses auto-loading? Which do you think you'd prefer to use in your project?  
