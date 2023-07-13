---
layout: page
title: Iteration 3 - Creating Objects from Multiple Data Sets and Analyzing Our Data
---

_[Back to The DMV Home](./index)_
_[Back to Requirements](./requirements)_

## Create Facility Objects from an External Data Source

Let's do that again with different data! Similar to when you created `Vehicle` objects from the data about EV Registrations in Washington, you'll create DMV `Facility` objects with data about DMV Facilities. Let's start with Colorado. You can follow the same pattern as you did for vehicles to access the data.

```ruby
DmvDataService.new.co_dmv_office_locations
```

The data should look something like this:
```ruby
pry(main)> DmvDataService.new.co_dmv_office_locations
# => [{:the_geom=>{:type=>"Point", :coordinates=>[-104.97443112500002, 39.75525297420336]},
#   :dmv_id=>"1",
#   :dmv_office=>"DMV Tremont Branch",
#   :address_li=>"2855 Tremont Place",
#   :address__1=>"Suite 118",
#   :city=>"Denver",
#   :state=>"CO",
#   :zip=>"80205",
#   :phone=>"(720) 865-4600",
#   :hours=>"Mon, Tue, Thur, Fri  8:00 a.m.- 4:30 p.m. / Wed 8:30 a.m.-4:30 p.m.",
#   :services_p=>"vehicle titles, registration, renewals;  VIN inspections",
#   :parking_no=>"parking available in the lot at the back of the bldg (Glenarm Street)",
#   :photo=>"images/Tremont.jpg",
#   :address_id=>"175164",
#   :":@computed_region_nku6_53ud"=>"1444"},
#  {:the_geom=>{:type=>"Point", :coordinates=>[-104.84839592880655, 39.78135984611333]},
#   :dmv_id=>"2",
#   :dmv_office=>"DMV Northeast Branch",
#   :address_li=>"4685 Peoria Street",
#   :address__1=>"Suite 101",
#   :location=>"Arie P. Taylor  Municipal Bldg",
#   :city=>"Denver",
#   :state=>"CO",
#   :zip=>"80239",
#   :phone=>"(720) 865-4600",
#   :hours=>"Mon, Tue, Thur, Fri  8:00 a.m.- 4:30 p.m. / Wed 8:30 a.m.-4:30 p.m.",
#   :services_p=>"vehicle titles, registration, renewals;  VIN inspections",
#   :parking_no=>"parking available in both the front and back of the bldg; also on Paris Street",
#   :photo=>"images/Peoria.jpg",
#   :address_id=>"11348",
#   :":@computed_region_nku6_53ud"=>"1444"},
#     ...}]
```

## Create Facility objects from Multiple Data Sources

Cool! Now you can handle creating `Facility` objects from one data source. But what about another state? The fun thing about data is that every entity that manages a data set has their own rules. Refactor your code to allow for the creation of `Facility` objects from another data source - NY State DMV Facilities. You should be able to create objects from ALL provided data sources. This means that by changing your code to work for the New York dataset, it should also continue to work for the Colorado dataset. Once you have New York working, add in Missouri! We **STRONGLY** recommend doing one at a time. Make sure all your past tests for the previous dataset still pass when you're done adding code for your new dataset.

You can access these data sets with the following code:

```ruby
new_york_facilities = DmvDataService.new.ny_dmv_office_locations

missouri_facilities = DmvDataService.new.mo_dmv_office_locations
```
