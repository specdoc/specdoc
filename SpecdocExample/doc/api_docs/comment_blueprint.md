## comments  [/v1/arenas]
### create a comment  [POST]

+ Request succeed (application/x-www-form-urlencoded)

    + Parameters

            + comment = 'Hello+World'




+ Response 201 (application/json; charset=utf-8)

        {
          "ok": true
        }



+ Request with errors (application/x-www-form-urlencoded)

    + Parameters

            + foo = 'bar'




+ Response 422 (application/json; charset=utf-8)

        {
          "error": "Foo Bar Baz"
        }

