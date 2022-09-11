# opentracer: DataDog-compatible OpenTracing implementation

This package is a fork of DataDog's ddtrace/opentracer package located
[here](https://github.com/DataDog/dd-trace-go/tree/v1.28.0/ddtrace/opentracer).
By default, the official opentracer package always calls `tracer.New`, which
destroys the settings added by the datadog-lambda-go (ddlambda) package.

This package is modified so that it no longer calls `tracer.New`. Additionally,
it makes it so that the package only uses publicly available APIs of the
ddtrace/tracer package.
