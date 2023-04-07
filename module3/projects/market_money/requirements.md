---
layout: page
title: Market Money Requirements
length: 1 week
tags:
type: project
---

# 1. Set Up

1. Create a Rails API project called `market_money` (make sure you do not set up a "traditional" Rails project with a frontend, this is an API-only project): `rails _7.0.1_ new market_money -T -d postgresql --api`

2. Set Up [SimpleCov](https://github.com/colszowka/simplecov) to track test coverage in your rails-engine API project.

3. Download [market_money_development.pgdump](https://github.com/turingschool/backend-curriculum-site/blob/market_money_project/module3/projects/market_money/market_money_development.pgdump) and move it into the `/db/` folder in another folder called `/data/`, so your project files look like this:

```
/app
/bin
/config
/db
  /data                                     <-- create this folder
    market_money_development.pgdump         <-- put the file in the data folder
  seeds.rb                                  <-- seeds.rb is in `/db/` folder, not `/db/data/`
/lib
/log
etc
```

  - this file is in a binary format and your browser may try to automatically download the file instead of viewing it


4. Set up your `db/seeds.rb` file with the following content:
```ruby
cmd = "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U $(whoami) -d market_money_development db/data/market_money_development.pgdump"
puts "Loading PostgreSQL Data dump into local database with command:"
puts cmd
system(cmd)
```

5. Run `rails db:{drop,create,migrate,seed}` and you may see lots of output including some warnings/errors from `pg_restore` that you can ignore. If you're unsure about the errors you're seeing, ask an instructor.

6. Run `rails db:schema:dump` - Check to see that your `schema.rb` exists and has the proper tables/attributes that match the data in Postico. You can do the following to check to see if you have set up rails to effectively communicate with the database.
  * Add a `market.rb` file to your models directory
  * Create a `Market` class that inherits from `ApplicationRecord`
  * run `rails c` to jump into your rails console.
  * run `Market.first` to see the object: `##<Market id: 322458, name: "14&U Farmers' Market", street: "1400 U Street NW ", city: "Washington", county: "District of Columbia", state: "District of Columbia", zip: "20009", lat: "38.9169984", lon: "-77.0320505">`
  * run `Market.last` to see the object: `#<Market id: 331081, name: "Year-Round Cedar City Farmer's Market ", street: "905 South Main Street at IFA", city: "Cedar City", county: nil, state: "Utah", zip: "84720", lat: "37.6619", lon: "-113.069">`
  * If this all checks out you should be good to go.

7. Use a tool like Postico to examine the 3 tables that were created. Pay careful attention to the data types of each field:
  * markets
  * vendors 
  * market_vendors


**NOTE** If your `rails new ...` project name from above is NOT exactly called "market_money" you will need to modify the `cmd` variable below to change the `-d` parameter from `market_money_development` to `<YOUR PROJECT NAME>_development` instead. If you have questions, ask your instructors.

---

# 2. General Requirements

### Required Endpoints

You will need to expose the data through a multitude of API endpoints. All of your endpoints should follow these technical expectations:

* All endpoints should be fully tested for happy path AND sad path. 
<!-- The Postman tests are not a substitute for writing your own tests. -->
* All endpoints that return data will expect to return JSON data only
* All endpoints should be exposed under an `api` and version (`v0`) namespace (e.g. `/api/v0/markets`)
* API will be compliant to the [JSON API spec](https://jsonapi.org/) and match our requirements below precisely
  <!-- * if your tests pass but the Postman test does not, you have done something wrong. -->
* Controller actions should be limited to only the standard Rails actions and follow good RESTful convention.
* Endpoints such as `GET /api/v1/markets/search?parameters` will NOT follow RESTful convention, and that's okay. Consider creating an action that *appears* restful.
* In total, you will create **12 endpoints** (10 ReSTful, 2 non-ReSTful)

    ##### ReSTful Endpoints

    - **Market Endpoints**
      * get all markets
      * get one market
      * get all vendors for a market
    - **Vendor Endpoints**
      * get one vendor
      * create a vendor
      * update a vendor
      * delete a vendor
      * get markets for a vendor
    - **MarketVendor Endpoints**
      * create a market_vendor
      * delete a market_vendor

    ##### Non-ReSTful Endpoints

    - **AR Endpoint**
      * get all markets within a city or state that's name or description match a string fragment

    - **Consume API Endpoint**
      * get cash dispensers (ATMs) close to a market location

### Error Responses

If the user causes an error for which you are sending a 400-series error code, the JSON body of the response should be an error object that contains a detailed description of the error. 

For example, 
```json
  {
      "errors": [
          {
              "detail": "Couldn't find Market with 'id'=123123123123"
          }
      ]
  }
```

You can customize the value of the `detail` element. But, you must always have a top level `errors` key that points to a collection. 

---

# 3. API requests/responses, more details

Below, you will see 12 dropdowns that correspond to the core endpoint requirements of this project. Each dropdown gives you more details on what each endpoint should be doing, returning, and considering. Each endpoing also has some example request/responses to help you understand the requirements of the endpoint. Happy Path examples are denoted with a 😁  . Sad Path examples are denoted with a 😭  . 

<details>
<summary><h3>1. Get All Markets</h3></summary>

#### Details:
1. This endpoint should follow the pattern of `GET /api/v0/markets` and should return ALL markets in the database.
2. In addition to the market's main attributes, the market resource should also list an attribute for `vendor_count`, which is the number of vendors that are associated with that market. 

      <details><summary><h5>Example #1 😁 </h5></summary>
      
      #### Request: 
      ```
        GET /api/v0/markets
        Content-Type: application/json
        Accept: application/json
      ```

      #### Response:
      `status: 200`
      ```json
      {
          "data": [
              {
                  "id": "17",
                  "type": "market",
                  "attributes": {
                      "name": "18th Street Farmers Market",
                      "street": "825 18th Street",
                      "city": "Charleston",
                      "county": "Coles",
                      "state": "Illinois",
                      "zip": "61920",
                      "lat": "39.490737",
                      "lon": "-88.163254",
                      "vendor_count": 28
                  }
              },
              {
                  "id": "18",
                  "type": "market",
                  "attributes": {
                      "name": "19/27 Community Farmers Market",
                      "street": "NE 7th Ave",
                      "city": "Chiefland",
                      "county": "Levy",
                      "state": "Florida",
                      "zip": "32626",
                      "lat": "29.4848541",
                      "lon": "-82.8578732",
                      "vendor_count": 38
                  }
              },
              ...,
              ...,
          ]
      }
      ```
      </details>
</details>
<details><summary><h3>2. Get One Market</h3></summary>

#### Details:
1. This endpoint should follow the pattern of `GET /api/v0/markets/:id`.
2. If a valid market id is passed in, all market attributes, as well as a `vendor_count` should be returned.  
3. If an invalid market id is passed in, a 404 status as well as a descriptive error message should be sent back in the response.

      <details><summary><h5>Example #1 😁 </h5></summary>

      #### Request:
      ```
        GET /api/v0/markets/360
        Content-Type: application/json
        Accept: application/json
      ```

      #### Response: 
      `status: 200`
      ```json
      {
          "data": {
              "id": "360",
              "type": "market",
              "attributes": {
                  "name": "Austintown Farmers Market",
                  "street": "6000 Kirk Road (Austintown Township Park)",
                  "city": "Austintown",
                  "county": "Mahoning",
                  "state": "Ohio",
                  "zip": "44515",
                  "lat": "41.070511",
                  "lon": "-80.774094",
                  "vendor_count": 24
              }
          }
      }
      ```
      </details>
      <details><summary><h5>Example #2 😭 </h5></summary>
    
      #### Request:
      ```
        GET /api/v0/markets/123123123123 (where `123123123123` is an invalid Market id)
        Content-Type: application/json
        Accept: application/json
      ```

      #### Response: 
      `status: 404`
      ```json
      {
          "errors": [
              {
                  "detail": "Couldn't find Market with 'id'=123123123123"
              }
          ]
      }
      ```
      </details>
</details>

<details><summary><h3>3. Get All Vendors for a Market</h3></summary>

#### Details 
1. This endpoint should follow the pattern of `GET /api/v0/markets/:id/vendors`
2. If a valid market id is passed in, a JSON object is sent back with a top-level `data` key that points to a collection of that market's vendors. Each vendor contains all of it's attributes.
3. If an invalid market id is passed in, a 404 status as well as a descriptive error message should be sent back in the response.

    <details><summary><h5>Example #1 😁</h5></summary>

    #### Request: 
    ```
      GET /api/v0/markets/360/vendors
      Content-Type: application/json
      Accept: application/json
    ```

    #### Response: 
    `status: 200`
    ```json
    {
        "data": [
            {
                "id": "1150",
                "type": "vendor",
                "attributes": {
                    "name": "Jolly Scoops",
                    "description": "Handcrafted ice cream in a variety of festive flavors.",
                    "contact_name": "Kit Romaguera",
                    "contact_phone": "656.318.8117",
                    "credit_accepted": true
                }
            },
            {
                "id": "1452",
                "type": "vendor",
                "attributes": {
                    "name": "The Book Cellar",
                    "description": "A hidden gem of a bookstore, featuring a range of used and rare titles, with a focus on science fiction and fantasy.",
                    "contact_name": "Dorian O'Kon",
                    "contact_phone": "839-874-2562",
                    "credit_accepted": true
                }
            },
            {
                "id": "318",
                "type": "vendor",
                "attributes": {
                    "name": "Hot Diggity Dog",
                    "description": "sells gourmet hot dogs with unique toppings",
                    "contact_name": "Dan Connelly PhD",
                    "contact_phone": "322-239-3558",
                    "credit_accepted": false
                }
            },
            ...,
            ...,
        ]
    }
    ```
    </details>
    <details><summary><h5>Example #2 😭 </h5></summary>
      
      #### Request:
      ```
        GET /api/v0/markets/123123123123/vendors (where `123123123123` is an invalid Market id)
        Content-Type: application/json
        Accept: application/json
      ```

      #### Response: 
      `status: 404`
      ```json
    {
        "errors": [
            {
                "detail": "Couldn't find Market with 'id'=123123123123"
            }
        ]
    }
      ```
    </details>
</details>

<details><summary><h3>4. Get One Vendor</h3></summary>

#### Details
1. This endpoint should follow the pattern of `GET /api/v0/vendors/:id`
2. If a valid vendor id is passed in, a JSON object is sent back with a top-level `data` key that points to the vendor resource with that id, and all attributes for that vendor.
3. If an invalid vendor id is passed in, a 404 status as well as a descriptive error message should be sent back in the response.

    <details><summary><h5>Example #1 😁</h5></summary>

    #### Request: 
    ```
      GET /api/v0/vendors/1150
      Content-Type: application/json
      Accept: application/json
    ```

    #### Response:
    `status: 200`
    ```json 
    {
        "data": {
            "id": "1150",
            "type": "vendor",
            "attributes": {
                "name": "Jolly Scoops",
                "description": "Handcrafted ice cream in a variety of festive flavors.",
                "contact_name": "Kit Romaguera",
                "contact_phone": "656.318.8117",
                "credit_accepted": true
            }
        }
    }
    ```
    </details>
    <details><summary><h5>Example #2 😭 </h5></summary>
      
      #### Request:
      ```
        GET /api/v0/vendors/123123123123 (where `123123123123` is an invalid Vendor id)
        Content-Type: application/json
        Accept: application/json
      ```

      #### Response: 
      `status: 404`
      ```json
    {
        "errors": [
            {
                "detail": "Couldn't find Vendor with 'id'=123123123123"
            }
        ]
    }
      ```
    </details>
</details>

<details><summary><h3>5. Create a Vendor</h3></summary>

#### Details
1. This endpoint should follow the pattern of `POST /api/v0/vendors`, and should pass ALL attributes required to create a vendor (`name`, `description`, `contact_name`, `contact_phone`, and `credit_accepted`) as JSON in the body of the request. (In postman, navigate to `Body` tab, select `raw` and change the format to `JSON` instead of `Text`)
2. This endpoint should create a new vendor resource.
3. A successful response will return a response with a `201` status code, and return the newly created vendor resource. 
4. If any number of attributes are left out in the body of the request, a status code of `400`, as well as a descriptive error message should be sent back in the response.
5. Validating the presence of a boolean value can be tricky since `false` is evaluated as `nil`. Validating the presence of a field that could be false will generate some a validation error when we don't mean it to. We'd suggest creating your own [custom validation](https://guides.rubyonrails.org/active_record_validations.html#custom-methods) for validating the presence of a boolean field. 

    <details><summary><h5>Example #1 😁</h5></summary>

    #### Request:
    ```
      POST /api/v0/vendors
      Content-Type: application/json
      Accept: application/json
    ```

    ##### Body: 
    ```
    {
        "name": "Buzzy Bees",
        "description": "local honey and wax products",
        "contact_name": "Berly Couwer",
        "contact_phone": "8389928383",
        "credit_accepted": false
    }
    ```

    #### Response:
    `status: 201`
    ```json 
    {
        "data": {
            "id": "1694",
            "type": "vendor",
            "attributes": {
                "name": "Buzzy Bees",
                "description": "local honey and wax products",
                "contact_name": "Berly Couwer",
                "contact_phone": "8389928383",
                "credit_accepted": false
            }
        }
    }
    ```
    </details>
    <details><summary><h5>Example #2 😭 </h5></summary>
      
      #### Request:
      ```
        POST /api/v0/vendors
        Content-Type: application/json
        Accept: application/json
      ```
      ##### Body: 
      ```
      {
          "name": "Buzzy Bees",
          "description": "local honey and wax products",
          "credit_accepted": false
      }
      ```

      #### Response: 
      `status: 400`
      ```json
    {
        "errors": [
            {
                "detail": "Validation failed: Contact name can't be blank, Contact phone can't be blank"
            }
        ]
    }
      ```
    </details>
</details>

<details><summary><h3>6. Update a Vendor</h3></summary>

#### Details
1. This endpoint should follow the pattern of `PATCH /api/v0/vendors/:id`, and can pass any number and combination of attribtues to be updated (`name`, `description`, `contact_name`, `contact_phone`, and `credit_accepted`) as JSON in the body of the request. (In postman, navigate to `Body` tab, select `raw` and change the format to `JSON` instead of `Text`)
2. This endpoint should update an existing vendor with any parameters sent in via the body.
3. If someone were to try to update a vendor resource to have a `nil` or empty attribute, a proper 400-level status code as well as a descriptive error message should be sent back in the response.
4. A successful response will return the newly updated vendor resource. 

    <details><summary><h5>Example #1 😁</h5></summary>

    #### Request: 
    ```
      PATCH /api/v0/vendors/1694
      Content-Type: application/json
      Accept: application/json
    ```

    ##### Body: 
    ```
    {
        "contact_name": "Kimberly Couwer",
        "credit_accepted": false
    }
    ```

    #### Response: 
    `status: 200`
    ```json 
    {
        "data": {
            "id": "1694",
            "type": "vendor",
            "attributes": {
                "name": "Buzzy Bees",
                "description": "local honey and wax products",
                "contact_name": "Kimberly Couwer",
                "contact_phone": "8389928383",
                "credit_accepted": false
            }
        }
    }
    ```
    </details>
    <details><summary><h5>Example #2 😭 </h5></summary>
      
      #### Request:
      ```
        PATCH /api/v0/vendors/123123123123 (where `123123123123` is an invalid Vendor id)
        Content-Type: application/json
        Accept: application/json
      ```
      ##### Body: 
      ```
    {
        "contact_name": "Kimberly Couwer",
        "credit_accepted": false
    }
      ```

      #### Response: 
      `status: 404`
      ```json
    {
        "errors": [
            {
                "detail": "Couldn't find Vendor with 'id'=123123123123"
            }
        ]
    }
      ```
    </details>
    <details><summary><h5>Example #3 😭 </h5></summary>
      
      #### Request:
      ```
        PATCH /api/v0/vendors/1694 (where `1694` is an valid Vendor id)
        Content-Type: application/json
        Accept: application/json
      ```
      ##### Body: 
      ```
    {
        "contact_name": "",
        "credit_accepted": false
    }
      ```

      #### Response: 
      `status: 400`
      ```json
    {
        "errors": [
            {
                "detail": "Validation failed: Contact name can't be blank"
            }
        ]
    }
      ```
    </details>
</details>

<details><summary><h3>7. Delete a Vendor</h3></summary>

#### Details
1. This endpoint should follow the pattern of `DELETE /api/v0/vendors/:id`
2. When a valid id is passed in, that vendor will be destroyed, as well as any associations that vendor had. A status code of `204` should be sent back, without any content in the body. 
3. If an invalid id is passed in, a 404 status code as well as a descriptive message should be sent back with the response.

    <details><summary><h5>Example #1 😁 </h5></summary>

    #### Request: 
    ```
      DELETE /api/v0/vendors/70
      Content-Type: application/json
      Accept: application/json
    ```

    #### Response: 
    `status: 204`
    </details>

    <details><summary><h5>Example #2 😭 </h5></summary>
      
      #### Request:
      ```
        DELETE /api/v0/vendors/123123123123 (where `123123123123` is an invalid Vendor id)
        Content-Type: application/json
        Accept: application/json
      ```

      #### Response: 
      `status: 404`
      ```json
    {
        "errors": [
            {
                "detail": "Couldn't find Vendor with 'id'=123123123123"
            }
        ]
    }
      ```
    </details>
</details>

<details><summary><h3>8. Get Markets for a Vendor</h3></summary>

#### Details
1. This endpoint should follow the pattern of `GET /api/v0/vendors/:id/markets`, and it should return any markets that the vendor is associated with.
2. When a valid vendor id is passed in, a response will be sent back that lists out all markets that the vendor is associated with. 
3. If a vendor only has one market that they sell at, that market should still be returned in an array. 
4. If a vendor doesn't have any markets that they sell at, the `data` top level key should point to an empty array. 
3. If an invalid vendor id is passed in, a 404 status code as well as a descriptive message should be sent back with the response.

    <details><summary><h5>Example #1 😁 </h5></summary>

    #### Request: 
    ```
      GET /api/v0/vendors/1150/markets
      Content-Type: application/json
      Accept: application/json
    ```

    #### Response: 
    ```json 
    {
        "data": [
            {
                "id": "360",
                "type": "market",
                "attributes": {
                    "name": "Austintown Farmers Market",
                    "street": "6000 Kirk Road (Austintown Township Park)",
                    "city": "Austintown",
                    "county": "Mahoning",
                    "state": "Ohio",
                    "zip": "44515",
                    "lat": "41.070511",
                    "lon": "-80.774094",
                    "vendor_count": 24
                }
            },
            {
                "id": "994",
                "type": "market",
                "attributes": {
                    "name": "Canal Fulton Farmers Market ",
                    "street": "2309 Locust Street",
                    "city": "Canal Fulton",
                    "county": null,
                    "state": "Ohio",
                    "zip": "44614",
                    "lat": "40.8822",
                    "lon": "-81.5686",
                    "vendor_count": 39
                }
            },
            ...,
            ...,
        ]
    }
    ```
    </details>
    <details><summary><h5>Example #2 😭 </h5></summary>
      
      #### Request:
      ```
        GET /api/v0/vendors/123123123123/markets (where `123123123123` is an invalid Vendor id)
        Content-Type: application/json
        Accept: application/json
      ```

      #### Response: 
      `status: 404`
      ```json
    {
        "errors": [
            {
                "detail": "Couldn't find Vendor with 'id'=123123123123"
            }
        ]
    }
      ```
    </details>
</details>
<details><summary><h3>9. Create a MarketVendor</h3></summary>

#### Details
1. This endpoint should follow the pattern of `POST /api/v0/market_vendors`, and it should create a new association between a market and a vendor (so then, the vendor has a new market that they sell at).
2. When valid ids for vendor and market are passed in, a MarketVendor will be created, and a response will be sent back with a `201` status, detailing that a Vendor was added to a Market. 
3. After implementing the happy path for this endpoint, run it, and check that when you call `GET /api/v0/vendors/:id/markets` for the vendor in which you just added to a market, that you see the newly associated market listed. 
4. If an invalid vendor id or and invalid market id is passed in, a 404 status code as well as a descriptive message should be sent back with the response.
5. If there already exists a MarketVendor with that `market_id` and that `vendor_id`, a response with a `422` status code and a message informing the client that that association already exists, should be sent back. Looking at [custom validation](https://guides.rubyonrails.org/active_record_validations.html#custom-methods) might help to implement a validation for uniqueness of the attributes for this resource. 

    <details><summary><h5>Example #1 😁 </h5></summary>

    #### Request:
    ```
      POST /api/v0/market_vendors
      Content-Type: application/json
      Accept: application/json
    ```

    ##### Body: 
    ```json
    {
        "market_id": 19,
        "vendor_id": 1150
    }
    (where 19 and 1150 are valid market and vendor id's.)
    ```

    #### Response: 
    ```json
      {
        "message": "Successfully added vendor to market"
      }
    ```
    </details>
    <details><summary><h5>Example #2 😭 </h5></summary>
      
      #### Request:
      ```
        POST /api/v0/market_vendors
        Content-Type: application/json
        Accept: application/json
      ```
      ##### Body: 
      ```json
      {
          "market_id": 987654321, 
          "vendor_id": 1150 
      }
      (where 987654321 is an invalid market id)
      ```

      #### Response: 
      `status: 404`
      ```json
    {
        "errors": [
            {
                "detail": "Validation failed: Market must exist"
            }
        ]
    }
      ```
    </details>
    <details><summary><h5>Example #3 😭 </h5></summary>
      
      #### Request:
      ```
        POST /api/v0/market_vendors
        Content-Type: application/json
        Accept: application/json
      ```
      ##### Body: 
      ```json
      {
          "market_id": 19, 
          "vendor_id": 1150 
      }
      (where 19 and 1150 are valid market and vendor id's, but an existing MarketVendor with those values already exists.)
      ```

      #### Response: 
      `status: 422`
      ```json
    {
        "errors": [
            {
                "detail": "Validation failed: Market vendor asociation between market with market_id=70 and vendor_id=1150 already exists"
            }
        ]
    }
      ```
    </details>
</details>

<details><summary><h3>10. Delete a MarketVendor</h3></summary>

#### Details
1. This endpoint should follow the pattern of `DELETE /api/v0/market_vendors`, and it should destroy an existing association between a market and a vendor (so that a vendor no longer is listed at a certain market).
2. The `market_id` and the `vendor_id` should be passed in via the body. 
2. When a MarketVendor resource can be found with the passed in `vendor_id` and `market_id`, that resource should be destroyed, and a response will be sent back with a `204` status, with nothing returned in the body of the request.  
3. After implementing the happy path for this endpoint, run it, and check that when you call `GET /api/v0/vendors/:id/markets` for the vendor in which you just deleted an association to a market, that you don't see the recently removed market listed. 
4. If a MarketVendor resource can NOT be found with the passed in `vendor_id` and `market_id`, a 404 status code as well as a descriptive message should be sent back with the response.
  
    <details><summary><h5>Example #1 😁 </h5></summary>

    #### Request: 
    ```
      DELETE /api/v0/market_vendors
      Content-Type: application/json
      Accept: application/json
    ```

    ##### Body: 
    ```json
    {
        "market_id": 19,
        "vendor_id": 1697
    }
    ```

    #### Response: 
    `status: 204`
    </details>
    <details><summary><h5>Example #2 😭 </h5></summary>
      
      #### Request:
      ```
        DELETE /api/v0/market_vendors
        Content-Type: application/json
        Accept: application/json
      ```
      ##### Body: 
      ```json
      {
          "market_id": 423, 
          "vendor_id": 1150 
      }
      (where there is no MarketVendor that has a market_id=423 AND a vendor_id=1150)
      ```

      #### Response: 
      `status: 404`
      ```json
    {
        "errors": [
            {
                "detail": "No MarketVendor with market_id=423 AND vendor_id=1150 exists"
            }
        ]
    }
      ```
    </details>
</details>
<details><summary><h3>11. Search Markets by state, city, and/or name</h3></summary>

#### Details: 
1. The endpoint should be in the pattern of `GET /api/v0/markets/search`, and can accept `city`, `state`, and `name` parameters.
2. The following combination of parameters can be sent in at any time: 
  * `state`
  * `state`, `city`
  * `state`, `city`, `name`
  * `state`, `name`
  * `name`
3. The following combination of parameters can NOT be sent in at any time: 
  * `city`
  * `city`, `name`
4. If an invalid set of parameters are sent in, a proper error message should be sent back, along with a `422` status code. 
5. In the event that valid parameters are sent in, and only one market is returned from the search, the `data` top level key should still point to an array holding that one market resource data. 
6. Similar to above, in the event that valid parameters are sent in, and NO markets are returned, the `data` top level key should point to an empty array. And a status code of `200` should still be returned

    <details><summary><h5>Example #1 😁</h5></summary>

    #### Request: 
    ```
      GET /api/v0/markets/search?city=albququerque&state=new Mexico&name=uptown
      Content-Type: application/json
      Accept: application/json
    ```

    #### Response:
    `status: 200`
    ```json
    {
        "data": [
            {
                "id": "70",
                "type": "market",
                "attributes": {
                    "name": "ABQ Uptown Growers' Market",
                    "street": "NE parking lot of ABQ Uptown shopping center",
                    "city": "Albququerque",
                    "county": "Bernalillo",
                    "state": "New Mexico",
                    "zip": null,
                    "lat": "35.103988",
                    "lon": "-106.565838",
                    "vendor_count": 10
                }
            }
        ]
    }
    ```
    </details>
    <details><summary><h5>Example #2 😭 </h5></summary>
      
      #### Request: 
      ```
        GET /api/v0/markets/search?city=albququerque
        Content-Type: application/json
        Accept: application/json
      ```

      #### Response: 
      `status: 422`
      ```json
    {
        "errors": [
            {
                "detail": "Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint."
            }
        ]
    }
      ```
    </details>
</details>

<details><summary><h3>12. Get Cash Dispensers Near a Market</h3></summary>

#### Details: 
1. The endpoint should be in the pattern of `GET /api/v0/markets/:id/nearest_atms`
2. You will need to utilize the [TomTom API](https://developer.tomtom.com/) for this. Specifically, the category search endpoint. Find a category that would work for ATM's, and use the API to find ATM's near the location of the Farmer's Market. 
3. The atms that are returned should be in the order of closest to furthest away.
4. If an invalid market id is passed in, a 404 status as well as a descriptive error message should be sent back in the response.
5. The `data` top level key should always point to an array even if one or zero atms were located near the market location.

    <details><summary><h5>Example #1 😁 </h5></summary>

    #### Request: 
    ```
      GET /api/v0/markets/70/nearest_atms
      Content-Type: application/json
      Accept: application/json
    ```

    #### Response:
    `status: 200`
    ```json
    {
        "data": [
            {
                "id": null,
                "type": "atm",
                "attributes": {
                    "name": "Eds-Pyns",
                    "address": "2200 Louisiana Boulevard Northeast, Albuquerque, NM 87110",
                    "lat": 35.1034,
                    "lon": -106.56745,
                    "distance": 0.09976720439821812
                }
            },
            {
                "id": null,
                "type": "atm",
                "attributes": {
                    "name": "Prosperity Bank",
                    "address": "2240 Q St NE, Albuquerque, NM 87110",
                    "lat": 35.10273,
                    "lon": -106.56691,
                    "distance": 0.10595742641673364
                }
            },
            ...,
            ...,
            ...,
        ]
    }
    ```
    </details>
    <details><summary><h5>Example #2 😭 </h5></summary>
      
      #### Request:
      ```
        GET /api/v0/markets/123123123123/nearest_atm (where `123123123123` is an invalid Market id)
        Content-Type: application/json
        Accept: application/json
      ```

      #### Response: 
      `status: 404`
      ```json
    {
        "errors": [
            {
                "detail": "Couldn't find Market with 'id'=123123123123"
            }
        ]
    }
      ```
    </details>
</details>









<!-- ## Extra Practice Endpoints
* Get Vendors that sell at markets in a particular state
* DELETE a Market
* UPDATE a Market 
* CREATE a Market 
* get all markets within a certain city or state
* GET Markets for a Vendor 
* GET all the states the Vendor sells in 
* GET state w/ least amount of Vendors 
* GET all Vendors that sell in more than 1 state 
* If market has a vendor that doesn't accept credit, in market show page, give information about closest cash dispenser.  -->