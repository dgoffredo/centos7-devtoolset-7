#include <datadog/opentracing.h>

int main() {
    datadog::opentracing::TracerOptions tracer_options{"dd-agent", 8126};
    auto tracer = datadog::opentracing::makeTracer(tracer_options);
    {
        auto span_a = tracer->StartSpan("A");
        // In byungminkim's setup, omitting the following line prevents the crash.
        auto span_b = tracer->StartSpan("B", {opentracing::ChildOf(&span_a->context())});
    }
}
