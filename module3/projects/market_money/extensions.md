---
layout: page
title: Market Money Extensions
length: 1 week
tags:
type: project
---
_[Back to Market Money Home](./index)_

Once your Market Money project is complete, you may choose any of the following extensions for additional practice:

- Add a `cash-only` attribute to your Market json responses. This attribute should return `true` if ALL vendors in that market don't accept credit. It should return `false` if there are any vendors in that market that accept credit. For example, if I had a market with an id of `90000`, and that market had 3 vendors, all of whome didn't accept credit, the response from `GET /api/v0/markets/90000` would look something like: 
    ```json
        {
          "data": {
              "id": "90000",
              "type": "market",
              "attributes": {
                    ...,
                    ...,
                  "cash-only": true
              }
          }
      }
    ```
- Add a query parameter for your `GET /api/v0/markets/:market_id/vendors` to search for vendors that accept credit or cash. Your request should look something like `GET /api/v0/markets/:market_id/vendors?credit-accepted=true` or `GET /api/v0/markets/:market_id/vendors?credit-accepted=false`. Your response should then return all vendors at that market that either accept credit or don't (based on what you pass in as your query parameter).
-  Write a rake task to remove the `lat` and `lon` from your `markets` table. Update your `nearest_atm` endpoint to use the [Geocode Endpoint](https://developer.tomtom.com/geocoding-api/documentation/product-information/introduction) from [TomTom API](https://developer.tomtom.com/) to get the lat and lon for the Market's address before getting cash dispensers near the Market's location. 
    * This means, that when making the request to get a nearest atm for a market (`GET /api/v0/markets/:market_id/nearest_atm`), you'll need to first hit the Geocode endpoint to get the Latitude and Longitude of that Market's address, and then, with those coordinates, get the nearest cash dispensers. 
- Implement pagination for `GET /api/v0/markets`
  This Endpoint should: 
    * render a JSON representation of all records of the requested resource, one "page" of data at a time
    * allow for the following OPTIONAL query parameters to be sent by the user:
    * `per_page`, an integer value of how many resources should be in the output; defaults to 20 if not specified by the user
    * `page`, an integer value of a "page" of resources to skip before returning data; defaults to 1 if not specified by the user
    * do not use any third-party gems for pagination

    Example use of query parameters:

    * `GET /api/v0/markets?per_page=50&page=2`

    This should fetch items 51 through 100, since we're returning `50` per "page", and we want "page `2`" of data.
    If a user tries to fetch a page for which there is no data, then `data` should report an empty array.


- Utilize the [Unsplash API](https://unsplash.com/documentation) - specifically, the [Search Photos](https://unsplash.com/documentation#search-photos) endpoint. Supply a query that would work for this market's location (state), and use the API to retrieve an image. 
  * If an invalid image id is passed in, a 404 status as well as a descriptive error message should be sent back in the response.
  * If no image is found, a link to a placeholder image URL can be used (see [placehold.co](https://placehold.co/)), using the `Text` option to include a URL-encoded string representing the Item's name in the placeholder image. 


      **Request:**
      ```
        GET /api/v0/markets/322458
        Content-Type: application/json
        Accept: application/json
      ```

      **Response:** 
      `status: 200`
      ```json
      {
          "data": {
              "id": "322458",
              "type": "market",
              "attributes": {
                  "name": "14&U Farmers' Market",
                  "street": "1400 U Street NW ",
                  "city": "Washington",
                  "county": "District of Columbia",
                  "state": "District of Columbia",
                  "zip": "20009",
                  "lat": "38.9169984",
                  "lon": "-77.0320505",
                  "vendor_count": 1,
                  "image_url": "https://api.unsplash.com/photos/eOLpJytrbsQ" //or, https://placehold.co/600x400?text=Super+Widget
              }
          }
      }
      ```
    
      **Request:**
      ```
        GET /api/v0/markets/123123123123 (where `123123123123` is an invalid Market id)
        Content-Type: application/json
        Accept: application/json
      ```

      **Response:** 
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
<br>