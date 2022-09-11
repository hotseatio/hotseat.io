package fetchutil

import (
	"context"
	"errors"
	"net/http"

	tracehttp "gopkg.in/DataDog/dd-trace-go.v1/contrib/net/http"
)

type resourceNameKey struct{}

func WithResourceName(ctx context.Context, name string) context.Context {
	return context.WithValue(ctx, resourceNameKey{}, name)
}

func resourceNamer(req *http.Request) string {
	name, _ := req.Context().Value(resourceNameKey{}).(string)
	return name
}

var Client = tracehttp.WrapClient(&http.Client{
	// Don't follow redirects
	CheckRedirect: func(req *http.Request, via []*http.Request) error {
		return http.ErrUseLastResponse
	},
},
	tracehttp.RTWithResourceNamer(resourceNamer),
	tracehttp.RTWithServiceName("lambda-http"),
)

var DefaultClient = tracehttp.WrapClient(http.DefaultClient,
	tracehttp.RTWithResourceNamer(resourceNamer),
	tracehttp.RTWithServiceName("lambda-http"),
)

var ErrStatusCode = errors.New("response status is not OK")
