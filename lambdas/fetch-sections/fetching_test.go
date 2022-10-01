package main

import (
	"testing"

	"github.com/nathunsmitty/hotseat.io/lambdas/registrar"
	"github.com/stretchr/testify/assert"
)

func TestCreateCourseCatalogNumber(t *testing.T) {
	course := registrar.Course{
		Number: "CM152B",
	}
	catalogNumber := CreateCourseCatalogNumber(course)
	assert.Equal(t, "0152B CM", catalogNumber)
}
