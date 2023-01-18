---
layout: page
title: Iteration 3 - Creating Objects from Multiple Data Sets and Analyzing Our Data
---

_[Back to The DMV Home](./index)_
_[Back to Requirements](./requirements)_

## Create Facility Objects from an External Data Source

Let's do that again with different data! Similar to when you created `Vehicle` objects from the data about EV Registrations in Washington, you'll create DMV `Facility` objects with data about DMV Facilities. Let's start with Oregon. You can follow the same pattern as you did for vehicles to access the data.

```ruby
DmvDataService.new.or_dmv_office_locations
```

The data should look something like this:
```ruby
pry(main)> DmvDataService.new.or_dmv_office_locations
=> [{:title=>"Albany DMV Office",
  :zip_code=>"97321",
  :website=>"http://www.oregon.gov/ODOT/DMV/pages/offices/albany.aspx",
  :type=>"DMV Location",
  :phone_number=>"541-967-2014",
  :agency=>"Transportation, Department of ",
  :location_1=>
   {:latitude=>"44.632897",
    :longitude=>"-123.077928",
    :human_address=>"{\"address\": \"2242 Santiam Hwy SE\", \"city\": \"Albany\", \"state\": \"OR\", \"zip\": \"97321\"}"}},
 {:title=>"Ashland DMV Office",
  :zip_code=>"97520",
  :website=>"http://www.oregon.gov/ODOT/DMV/pages/offices/ashland.aspx",
  :type=>"DMV Location",
  :phone_number=>"541-776-6092",
  :agency=>"Transportation, Department of ",
  :location_1=>
   {:latitude=>"42.184549",
    :longitude=>"-122.671018",
    :human_address=>"{\"address\": \"600 Tolman Creek Rd\", \"city\": \"Ashland\", \"state\": \"OR\", \"zip\": \"97520\"}"}},
    ...]
```

## Create Facility objects from Multiple Data Sources

Cool! Now you can handle creating `Facility` objects from one data source. But what about another state? The fun thing about data is that every entity that manages a data set has their own rules. Refactor your code to allow for the creation of `Facility` objects from another data source - NY State DMV Facilities. You should be able to create objects from ALL provided data sources. This means that by changing your code to work for the New York dataset, it should also continue to work for the Oregon dataset. Once you have New York working, add in Missouri! We **STRONGLY** recommend doing one at a time. Make sure all your past tests for the previous dataset still pass when you're done adding code for your new dataset.

You can access these data sets with the following code:

```ruby
new_york_facilities = DmvDataService.new.ny_dmv_office_locations

missouri_facilities = DmvDataService.new.mo_dmv_office_locations
```
