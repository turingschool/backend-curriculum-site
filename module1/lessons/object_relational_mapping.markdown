# Object Relational Mapping (ORM)

## What is ORM

Object Relational Mapping (ORM) is a technique for managing and interacting with data that come from incompatible data sources. Sometimes referred to as "_an_" ORM, thus "Object Relational Mapper."

## Where You're Likely to See ORM

Rails applications use an ORM framework called ActiveRecord to manage this mapping process. Once your applications incorporate the use of formal databases, frameworks like Active Record allow you to dictate the loading of data into your system using Ruby (in this case) objects.

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

| Item |
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
