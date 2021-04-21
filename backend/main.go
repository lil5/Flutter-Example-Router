package main

import (
	"github.com/bxcodec/faker/v3"
	"github.com/gin-gonic/gin"
)

type User struct {
	UUID string `json:"uuid" faker:"uuid_hyphenated"`
	Name string `json:"name" faker:"name"`
}

func main() {
	r := gin.Default()
	gDatabase := r.Group("/user")
	{
		gDatabase.GET("/all", func(c *gin.Context) {
			faker.SetRandomMapAndSliceSize(4)

			var res []User
			err := faker.FakeData(&res)
			if err != nil {
				c.AbortWithError(500, err)
				return
			}

			c.JSON(200, res)
		})
	}

	r.Run(":7001")
}
